-- simplified version of the capitalisable_projects query that omits project member-level details

SELECT
	p._fivetran_synced AS data_up_to,
	p.id AS project_id,
	p.name AS project_name,
	p.url AS project_url,
	p.started_at::DATE AS project_start_date,
	p.target_date::DATE AS project_target_date,
	p.completed_at::DATE AS project_completed_date,
	p.state AS project_status,
	i.completed_at AS issue_completed_at_month,
	i.estimate AS story_points_completed,
	
	-- redshift equivalent of PUBLIC.GROUP_CONCAT()
	LISTAGG(u.name, ', ') WITHIN GROUP (ORDER BY u.name) AS members

FROM linear.roadmap_to_project AS rp


-- join to projects table to pull details for each project
INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE

-- subquery to pull only issues that are Done in Linear
-- make it a left join in case finance needs to see all relevant projects even if they don't have any completed issues
LEFT JOIN (
	SELECT
		iss.project_id,
		DATE_TRUNC('month', iss.completed_at)::DATE AS completed_at,
		SUM(COALESCE(iss.estimate, 1)) AS estimate
	FROM linear.issue AS iss
	
	-- inner join to the workflow state table to filter only for issues where the state name = 'Done'
	INNER JOIN linear.workflow_state AS ws
		ON iss.state_id = ws.id
		AND ws._fivetran_deleted IS FALSE
		AND ws.name = 'Done'
	WHERE
		iss._fivetran_deleted IS FALSE
		AND iss.project_id IS NOT NULL
	GROUP BY 1,2
) AS i
	ON p.id = i.project_id
LEFT JOIN linear.project_member AS pm
	ON p.id = pm.project_id
	AND pm._fivetran_deleted IS FALSE
LEFT JOIN linear.users AS u
	ON pm.member_id = u.id
	AND u._fivetran_deleted IS FALSE
WHERE
	1 = 1
	-- roadmap ID for 2024 Features Roadmap
	AND rp.roadmap_id = 'bcaa52ba-7dc0-4004-9a1f-c493dac497b3'
	AND rp._fivetran_deleted IS FALSE
GROUP BY 1,2,3,4,5,6,7,8,9,10