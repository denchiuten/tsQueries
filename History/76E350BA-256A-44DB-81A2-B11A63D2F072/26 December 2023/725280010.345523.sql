SELECT
	i.id,
	i.key,
	s.*
FROM jra.issue AS i
INNER JOIN jra.issue_board AS ib
	ON i.id = ib.issue_id
INNER JOIN jra.sprint AS s
	ON ib.board_id = s.board_id
	AND s.state <> 'current'
	AND s.start_date >= '2023-12-20'
ORDER BY 2