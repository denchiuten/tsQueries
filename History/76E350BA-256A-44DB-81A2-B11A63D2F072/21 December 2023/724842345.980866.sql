SELECT

COUNT(i.*)
FROM jra.issue AS i
INNER JOIN jra.issue_type AS t
	ON i.issue_type = t.id
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p."key" = 'MEASURE'	
WHERE i._fivetran_deleted IS FALSE