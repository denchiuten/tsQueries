SELECT
COUNT(i.*)
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p."key" = 'MEASURE'