SELECT 
	s.id AS jira_sprint_id,
	s.name AS jira_sprint_name,
	s.start_date::DATE AS jira_start_date,
	s.end_date::DATE AS jira_end_date,
	b.name AS jira_board_name
FROM jra.sprint AS s
INNER JOIN jra.board AS b
	ON s.board_id = b.id
LEFT JOIN plumbing.jira_sprint_to_linear_cycle AS map
	ON s.id = map.jira_sprint_id
WHERE
	1 = 1
	AND s._fivetran_deleted IS FALSE
	AND s.start_date >= '2023-12-20'
	AND s.state <> 'closed'
	AND b.name <> 'CUSIMP board'
	AND map.linear_cycle_id IS NULL