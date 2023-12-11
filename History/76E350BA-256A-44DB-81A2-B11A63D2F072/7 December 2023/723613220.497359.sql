SELECT
	internal_status,
	internal_lifecycle_status,
	COUNT(*) AS n
FROM bob.employee
GROUP BY 1,2
ORDER BY 1,2