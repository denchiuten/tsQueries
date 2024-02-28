WITH RECURSIVE date_series (employee_id, vacation_date, vacation_end_date) AS (
    SELECT 
        ooo.employee_id, 
        ooo.start_date::DATE AS vacation_date, 
        ooo.end_date::DATE AS vacation_end_date
    FROM bob.employee_out_of_office AS ooo

    UNION ALL

    SELECT 
        employee_id, 
        (vacation_date + INTERVAL '1 day')::DATE, 
        vacation_end_date
    FROM date_series
    WHERE vacation_date < vacation_end_date
)

SELECT
	t.name AS team,
	c.id AS cycle_id,
	c.starts_at::DATE AS cycle_start,
	c.ends_at::DATE AS cycle_end,
	COALESCE(u.name, 'Unassigned') AS assignee,
	s.name AS slack_issue_status,
	i.estimate AS issue_estimate,
	c.ends_at::DATE - c.starts_at::DATE AS days_in_cycle,
	COUNT(DISTINCT ds.vacation_date) AS n_days_ooo
FROM linear.issue AS i
INNER JOIN linear.cycle AS c	
	ON i.cycle_id = c.id
	AND c._fivetran_deleted IS FALSE
	AND c.completed_at IS NULL
INNER JOIN linear.team AS t
	ON c.team_id = t.id
	AND t.key - 'CCF'
INNER JOIN linear.workflow_state AS s
	ON i.state_id = s.id
LEFT JOIN linear.users AS u
	ON i.assignee_id = u.id
LEFT JOIN bob.employee AS b
	ON LOWER(u.email) = LOWER(b.email)
LEFT JOIN date_series AS ds
	ON b.id = ds.employee_id
	AND ds.vacation_date BETWEEN c.starts_at::DATE AND c.ends_at::DATE
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
GROUP BY 1,2,3,4,5,6,7,8