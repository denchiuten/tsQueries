SELECT
	s.name AS sprint_name,
	s.start_date::DATE AS jira_start_date,
	s.end_date::DATE AS jira_end_date,
	c.name AS linear_cycle_name,
	c.starts_at::DATE AS linear_start_date,
	c.ends_at::DATE AS linear_end_date
FROM plumbing.jira_sprint_to_linear_cycle AS map
INNER JOIN jra.sprint AS s
	ON map.jira_sprint_id = s.id
	AND s._fivetran_deleted IS FALSE
INNER JOIN linear.cycle As c
	ON map.linear_cycle_id = c.id
	AND c._fivetran_deleted IS FALSE