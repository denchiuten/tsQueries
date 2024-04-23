-- create a table to store all KPIs as monthly time series data

-- use a 'RUNNING' table to minimise the time during which the production table doesn't exist
DROP TABLE IF EXISTS plumbing.okrdash_kpis_RUNNING;
CREATE TABLE plumbing.okrdash_kpis_RUNNING (
	datemonth DATE,
	category VARCHAR(256),
	metric_1 VARCHAR(256),
	metric_2 VARCHAR(256),
	value_1 DOUBLE PRECISION,
	value_2 DOUBLE PRECISION
);


------------ time to first response for Customer Support tickets in Hubspot
INSERT INTO plumbing.okrdash_kpis_RUNNING (
	SELECT
		DATE_TRUNC('month', t.property_createdate)::DATE AS datemonth,
		'cs_tickets' AS category,
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
	GROUP BY 1,2,3,4
);

------------ unique monthly users and customers (i.e., companies) from FullStory
INSERT INTO plumbing.okrdash_kpis_RUNNING (
	SELECT 
		DATE_TRUNC('month', e.event_time)::DATE AS datemonth,
		'fs_usage' AS category,
		'unique_monthly_users' AS metric_1,
		'unique_monthly_customers' AS metric_2,
		COUNT(DISTINCT fs.user_id) AS value_1,
		COUNT(DISTINCT cp.parent_id) AS value_2
	FROM fullstory_o_1jfe7s_na1.events AS e
	INNER JOIN fullstory_o_1jfe7s_na1.users AS fs
		ON e.device_id = fs.device_id
	INNER JOIN hubs.contact_to_emails AS hc
		ON LOWER(fs.user_email) = LOWER(hc.email)
	INNER JOIN hubs.contact_company AS cc
		ON hc.id = cc.contact_id
		-- primary company association type
		AND cc.type_id = 1
	INNER JOIN hubs.vw_child_to_parent AS cp
		ON cc.company_id = cp.child_id
		-- Exclude Terrascope employees
		AND cp.parent_id <> 9244595755
	GROUP BY 1,2,3,4
);

------------ mean and median time to resolve Linear issues labeled as Bugs
INSERT INTO plumbing.okrdash_kpis_RUNNING (
	SELECT
		DATE_TRUNC('month', i.created_at)::DATE AS datemonth,
		'bug_resolution' AS category,
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
	GROUP BY 1,2,3,4
);

------------ revenue Y/Y growth and ebitda margins to calculate rule of 40
INSERT INTO plumbing.okrdash_kpis_RUNNING(
	SELECT
		f.date,
		'rule_of_40' AS category,
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
	GROUP BY 1,2,3,4
);

------------ number of PTINC-free days

INSERT INTO plumbing.okrdash_kpis_RUNNING(
	SELECT
		DATE_TRUNC('month', d.date)::DATE AS datemonth,
		'ptinc' AS category,
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
	GROUP BY 1,2,3,4
);

------------ conversion rate of leads to SQL

INSERT INTO plumbing.okrdash_kpis_RUNNING(
	SELECT 
		DATE_TRUNC('month', c.property_createdate)::DATE AS datemonth,
		'lead_conversion' AS category,
		'leads' AS metric_1,
		'sql_leads' AS metric_2,
		COUNT(DISTINCT c.id) AS value_1,
		COUNT(DISTINCT CASE WHEN d.deal_id IS NOT NULL THEN c.id END) AS value_2
	FROM hubs.contact AS c
	LEFT JOIN hubs.deal_contact AS dc
			ON c.id = dc.contact_id
	LEFT JOIN hubs.deal AS d
			ON dc.deal_id = d.deal_id
			AND d._fivetran_deleted IS FALSE
			AND d.property_dealname NOT ILIKE '%Belkins%'
	WHERE c.property_hs_analytics_source IN ('DIRECT_TRAFFIC', 'ORGANIC_SEARCH', 'ORGANIC_SOCIAL', 'PAID_SEARCH', 'PAID_SOCIAL')
			AND c.property_hs_email_domain NOT IN ('terrascope.com', 'terrascope-workspace.slack.com', 'puretech.com')
			AND c._fivetran_deleted IS FALSE
			OR c.property_hs_analytics_source_data_2 = '178192'
	GROUP BY 1,2,3,4
);

------------ monthly cloud spend per customer data plane
INSERT INTO plumbing.okrdash_kpis_RUNNING (
	SELECT
		f.date AS datemonth,
		'cloud_costs' AS category,
		'n_data_planes' AS metric_1,
		'external_cloud_spend' AS metric_2,
		fs.n_data_planes AS value_1,
		SUM(f.value) AS value_2
	FROM finance.actuals AS f
	INNER JOIN (
		SELECT 
			LAST_DAY(e.event_time::DATE) AS date,
			COUNT(DISTINCT map.company_id) AS n_data_planes
		FROM fullstory_o_1jfe7s_na1.events AS e
		INNER JOIN plumbing.auth0_to_hubspot_company AS map
			ON JSON_EXTRACT_PATH_TEXT(JSON_SERIALIZE(e.event_properties.user_properties), 'organizationId_str') = map.auth0_id
			AND e.event_properties.user_properties IS NOT NULL	
		GROUP BY 1
	) AS fs
		ON f.date = fs.date
	WHERE
		1 = 1
		AND f.close_date = (SELECT MAX(close_date) FROM finance.actuals)
		AND f.date <= f.close_date
		AND f.lt_ppt_mapping = 'Cloud Cost - External'
		-- exclude reversals
		AND f.value > 0 
	GROUP BY 1,2,3,4,5
);


------------ metrics for net revenue retention
INSERT INTO plumbing.okrdash_kpis_RUNNING (
	SELECT
		a.lead_month AS datemonth,
		'net_revenue_retention' AS category,
		'lagged_revenue' AS metric_1,
		'leading_revenue' AS metric_2,
		SUM(a.acv) AS value_1 ,
		SUM(a.acv_leading) AS value_2
	FROM (
		SELECT
			all_dates.obs_date AS base_month,
			ADD_MONTHS(all_dates.obs_date, 12)::DATE AS lead_month,
			com.id AS company_id,
			com.property_name AS company_name,
			SUM(CASE WHEN all_dates.obs_date BETWEEN deal.property_commencement_date AND deal.property_end_date THEN deal.property_acv_usd ELSE 0 END) AS acv,
			LEAD(SUM(CASE WHEN all_dates.obs_date BETWEEN deal.property_commencement_date AND deal.property_end_date THEN deal.property_acv_usd ELSE 0 END), 12) OVER(
				PARTITION BY com.id
				ORDER BY  all_dates.obs_date
			) AS acv_leading
		FROM hubs.deal AS deal
		INNER JOIN hubs.deal_company AS dc
			ON deal.deal_id = dc.deal_id
			AND dc.type_id = 5 -- primary company only
		INNER JOIN hubs.company AS com
			ON dc.company_id = com.id
		INNER JOIN hubs.deal_pipeline_stage AS stage
			ON deal.deal_pipeline_stage_id = stage.stage_id
			AND stage.label = '#09 WON'
		CROSS JOIN (
			SELECT DISTINCT LAST_DAY(d.date)::DATE AS obs_date
			FROM plumbing.dates AS d
			WHERE d.date <= ADD_MONTHS(CURRENT_DATE, 12)
		) AS all_dates
		WHERE
			1 = 1
			AND deal.property_arr_usd_ + deal.property_acv_usd + deal.property_amount_in_home_currency > 0
			AND deal._fivetran_deleted IS FALSE
		GROUP BY 1,2,3,4
	) AS a
	WHERE
		1 = 1 
		AND a.lead_month <= CURRENT_DATE
		AND a.acv > 0
	GROUP BY 1,2,3,4
);


------------ customer acquisition cost
INSERT INTO plumbing.okrdash_kpis_RUNNING (
	SELECT
		f.date AS datemonth,
		'customer_acquisition' AS category,
		'acquisition_cost' AS metric_1,
		f.team AS metric_2,
		SUM(f.value) AS value_1,
		0 AS value_2
	FROM finance.actuals AS f
	WHERE f.import_date = (SELECT MAX(import_date) FROM finance.actuals)
		AND f.date <= f.close_date
		AND f.team IN ('Sales', 'Partnerships', 'Solution Engineering', 'Implementation', 'Marketing')
		AND f.lt_ppt_mapping NOT ILIKE '%adjustment%'
	GROUP BY 1,4
);


-- now drop the production table
DROP TABLE IF EXISTS plumbing.okrdash_kpis;

-- and rename the running table to the production name
ALTER TABLE plumbing.okrdash_kpis_RUNNING RENAME TO okrdash_kpis;