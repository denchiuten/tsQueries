SELECT
	i.id,
	i.key,
	s.*
FROM jra.issue AS i
INNER JOIN jra.issue_board AS ib
	ON i.id = ib.issue_id
INNER JOIN jra.sprint AS s
	ON ib.board_id = s.board_id
	AND s.state = 'future'
	AND s.start_date >= '2024-01-10'
ORDER BY 2