SELECT 
	s.id,
	s.state,
	s.name,
	s.start_date,
	s.end_date,
	b.name,
	b.type
FROM jra.sprint AS s
INNER JOIN jra.board AS b
	ON s.board_id = b.id
WHERE
	1 = 1
	AND _fivetran_deleted IS FALSE
	AND start_date IS NOT NULL
	AND state <> 'closed'