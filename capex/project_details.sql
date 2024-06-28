SELECT 
	p.id,
	p.name,
	INITCAP(p.state) AS state,
	p.started_at,
	p.target_date,
	p.completed_at,
	i.id AS issue_id,
	i.completed_at AS issue_completion_date
FROM linear.project AS p
INNER JOIN linear.roadmap_to_project AS rp
	ON p.id = rp.project_id
	AND rp._fivetran_deleted IS FALSE
	AND rp.roadmap_id = 'bcaa52ba-7dc0-4004-9a1f-c493dac497b3'
INNER JOIN linear.issue AS i
	ON rp.project_id = i.project_id
	AND i._fivetran_deleted IS FALSE
INNER JOIN linear.workflow_state AS ws
	ON i.state_id = ws.id
	AND ws._fivetran_deleted IS FALSE	
WHERE p._fivetran_deleted IS FALSE