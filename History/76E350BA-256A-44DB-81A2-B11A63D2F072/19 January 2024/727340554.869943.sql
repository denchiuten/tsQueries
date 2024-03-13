SELECT
	i.id AS issue_id,
	i.key AS issue_key,
	p.key AS project_key,
	s.id AS sprint_id,
	s.start_date::DATE AS start_date,
	s.end_date::DATE AS end_date,
	linear_cycle_id
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p.key NOT IN ('CUSIMP', 'DBCLEAN')
INNER JOIN jra.issue_board AS ib
	ON i.id = ib.issue_id
INNER JOIN jra.sprint AS s
	ON ib.board_id = s.board_id
	AND s.state <> 'closed'
	AND s.start_date >= '2023-12-20'
INNER JOIN plumbing.jira_sprint_to_linear_cycle AS map
	ON s.id = map.jira_sprint_id
WHERE
	1 = 1
	AND _fivetran_deleted IS FALSE
	AND i."key" = 'MEASURE-2476'