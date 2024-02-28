SELECT
	map.issue_id,
	map.label_id,
	COUNT(*)
FROM linear.issue_label AS map
WHERE
	1 = 1
	AND _fivetran_deleted IS FALSE
GROUP BY 1,2
ORDER BY 3 DESC