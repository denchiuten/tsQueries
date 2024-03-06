SELECT
COUNT(i.*)
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p."key" = 'PTINC'
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE