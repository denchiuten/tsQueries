DELETE i
FROM linear.issue AS i
INNER JOIN linear.team AS t
	ON i.team_id = t.id
	AND t.key IN ('CCF','DSCI','PLAT','SEC', 'QA')
WHERE i._fivetran_deleted = TRUE