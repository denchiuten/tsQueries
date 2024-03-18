-- create a table to store all KPIs as monthly time series data

-- use a 'RUNNING' table to minimise the time during which the production table doesn't exist
DROP TABLE IF EXISTS plumbing.okrdash_kpis_RUNNING;
CREATE TABLE plumbing.okrdash_kpis_RUNNING (
	datemonth DATE,
	metric_1 VARCHAR(256),
	metric_2 VARCHAR(256),
	value_1 DOUBLE PRECISION,
	value_2 DOUBLE PRECISION
);


------------ time to first response for Customer Support tickets in Hubspot
INSERT INTO plumbing.okrdash_kpis_RUNNING (
	SELECT
		DATE_TRUNC('month', t.property_createdate)::DATE AS datemonth,
		'avg_time_to_first_response_in_hours' AS metric_1,
		'no_tickets' AS metric_2,
		
		-- column is in microseconds, so need to divide by 1000 to convert to seconds
		-- then by 60 to convert to minutes, and by 60 again to convert to hours
		AVG(property_time_to_first_agent_reply) / 1000 / 60 / 60 AS value_1,
		COUNT(DISTINCT t.id) AS value_2
	FROM hubs.ticket AS t
	WHERE
		1 = 1
		AND t._fivetran_deleted IS FALSE
		AND t.property_time_to_first_agent_reply IS NOT NULL
	GROUP BY 1,2
);


------------ unique monthly users and customers (i.e., companies) from FullStory
INSERT INTO plumbing.okrdash_kpis_RUNNING (
	SELECT 
		DATE_TRUNC('month', e.event_time)::DATE AS datemonth,
		'unique_monthly_users' AS metric_1,
		'unique_monthly_customers' AS metric_2,
		COUNT(DISTINCT fs.user_id) AS value_1,
		COUNT(DISTINCT cp.parent_id) AS value_2
	FROM fullstory_o_1jfe7s_na1.events AS e
	INNER JOIN fullstory_o_1jfe7s_na1.vw_fs_users AS fs
		ON e.device_id = fs.device_id
	INNER JOIN hubs.contact AS hc
		ON LOWER(fs.user_email) = LOWER(hc.property_email)
		AND hc._fivetran_deleted IS FALSE
	INNER JOIN hubs.contact_company AS cc
		ON hc.id = cc.contact_id
		-- primary company association type
		AND cc.type_id = 1
	INNER JOIN hubs.vw_child_to_parent AS cp
		ON cc.company_id = cp.child_id
		-- Exclude Terrascope employees
		AND cp.parent_id <> 9244595755
	GROUP BY 1,2,3
);

------------ mean and median time to resolve Linear issues labeled as Bugs
INSERT INTO plumbing.okrdash_kpis_RUNNING (
	SELECT
		DATE_TRUNC('month', i.created_at)::DATE AS datemonth,
		'mean_time_to_resolve' AS metric_1,
		'median_time_to_resolve' AS metric_2,
		AVG(DATEDIFF('day', i.created_at::DATE, i.completed_at::DATE)) AS value_1,
		MEDIAN(DATEDIFF('day', i.created_at::DATE, i.completed_at::DATE)) AS value_2
	FROM linear.issue AS i
	INNER JOIN linear.workflow_state AS ws
		ON i.state_id = ws.id
		AND ws._fivetran_deleted IS FALSE
		AND ws.name = 'Done'
	INNER JOIN linear.issue_label AS il
		ON i.id = il.issue_id
		-- label id for 'Bug' (under 'Issue Type' label group)
		AND il.label_id = '182bdac2-2793-457e-800d-0f4afc997c9b'
		AND il._fivetran_deleted IS FALSE
	WHERE
		1 = 1
		AND i._fivetran_deleted IS FALSE
	GROUP BY 1,2
);

------------ revenue Y/Y growth and ebitda margins to calculate rule of 40
INSERT INTO plumbing.okrdash_kpis_RUNNING(
	SELECT
		f.date,
		'revenue_yoy' AS metric_1,
		'ebitda_margin' AS metric_2,
		SUM(CASE WHEN f.team = 'Revenue' THEN value ELSE 0 END) / LAG(SUM(CASE WHEN f.team = 'Revenue' THEN value ELSE 0 END), 12) OVER(ORDER BY f.date) - 1 AS value_1,
		SUM(CASE WHEN f.mgmt_pnl_cost_type NOT IN ('Depreciation & Amortization', 'Taxes') THEN value ELSE 0 END) / SUM(CASE WHEN f.team = 'Revenue' THEN value ELSE 0 END) AS value_2
	FROM finance.actuals AS f
	WHERE
		1 = 1
		AND f.close_date = (SELECT MAX(close_date) FROM finance.actuals)
		AND f.date <= f.close_date
		AND f.pnl IS TRUE
	GROUP BY 1
);

------------ number of PTINC-free days

INSERT INTO plumbing.okrdash_kpis_RUNNING(
	SELECT
		DATE_TRUNC('month', d.date)::DATE AS datemonth,
		'ptinc-free days' AS metric_1,
		NULL AS metric_2,
		COUNT(DISTINCT d.date) AS value_1,
		0 AS value_2
	FROM plumbing.dates AS d	
	LEFT JOIN linear.issue AS i
		ON d.date = i.created_at::DATE
		-- id for PTINC team in Linear
		AND i.team_id = '586f61ec-9886-418d-a1e4-0a304ee33e4a'
		AND i._fivetran_deleted IS FALSE
	WHERE
		1 = 1
		AND i.id IS NULL
		AND d.date <= CURRENT_DATE
	GROUP BY 1
);


-- now drop the production table
DROP TABLE IF EXISTS plumbing.okrdash_kpis;

-- and rename the running table to the production name
ALTER TABLE plumbing.okrdash_kpis_RUNNING RENAME TO okrdash_kpis;