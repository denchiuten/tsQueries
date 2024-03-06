SELECT 
	s.id AS sprint_id,
	s.state,
	s.name,
	s.start_date::DATE AS start_date,
	s.end_date::DATE AS end_date,
	b.name
FROM jra.sprint AS s
INNER JOIN jra.board AS b
	ON s.board_id = b.id

WHERE
	1 = 1
	AND s._fivetran_deleted IS FALSE
	AND s.start_date >= '2023-12-20'
	AND s.state <> 'closed'
	AND b.name <> 'CUSIMP board'