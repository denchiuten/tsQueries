SELECT
	i._fivetran_deleted,
	COUNT(i.*)
FROM linear.issue AS i
INNER JOIN linear.team AS t
	ON i.team_id = t.id
	AND t.key = 'CCF'
GROUP BY 1