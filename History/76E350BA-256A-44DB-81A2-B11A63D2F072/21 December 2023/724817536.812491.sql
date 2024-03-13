-- DELETE i

SELECT 
	t.key,
	i._fivetran_deleted,
	COUNT(i.*)
FROM linear.issue AS i
INNER JOIN linear.team AS t
	ON i.team_id = t.id
	AND t.key IN ('CCF','DSCI','PLAT','SEC', 'QA')
-- WHERE i._fivetran_deleted = TRUE
GROUP BY 1,2
ORDER BY 1,2