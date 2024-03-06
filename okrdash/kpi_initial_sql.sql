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

-- now drop the production table
DROP TABLE IF EXISTS plumbing.okrdash_kpis;

-- and rename the running table to the production name
ALTER TABLE plumbing.okrdash_kpis_RUNNING RENAME TO okrdash_kpis;