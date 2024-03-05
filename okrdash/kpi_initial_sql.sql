-- create a table to store all KPIs as monthly time series data

-- use a 'RUNNING' table to minimise the time during which the production table doesn't exist
DROP TABLE IF EXISTS plumbing.okrdash_kpis_RUNNING;
CREATE TABLE plumbing.okrdash_kpis_RUNNING AS (

-- time to first response for Customer Support tickets in Hubspot
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

-- now drop the production table
DROP TABLE IF EXISTS plumbing.okrdash_kpis;

-- and rename the running table to the production name
ALTER TABLE plumbing.okrdash_kpis_RUNNING RENAME TO okrdash_kpis;