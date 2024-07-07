SELECT
	mar.measured_date,
	mar.connector_id,
	mar.table_name,
	mar.sync_type,
	d.day_in_quarter,
	SUM(mar.incremental_rows) AS incremental_rows,
	MAX(MAX(mar._fivetran_synced)) OVER() AS data_up_to
FROM fivetran_metadata.incremental_mar AS mar
INNER JOIN plumbing.dates AS d
	ON mar.measured_date = d.date
WHERE
	1 = 1
	AND mar.incremental_rows > 0
GROUP BY 1,2,3,4,5
