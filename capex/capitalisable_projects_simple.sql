-- simplified version of the capitalisable_projects query that omits project member-level details

SELECT
	p._fivetran_synced AS data_up_to,
	rp.roadmap_id,
	r.name AS roadmap_name,
	p.id AS project_id,
	p.name AS project_name,
	p.started_at::DATE AS project_start_date,
	p.target_date::DATE AS project_target_date,
	p.completed_at::DATE AS project_completed_date,
	p.state AS project_status,
	i.completed_at AS issue_completed_at_month,
	i.estimate AS story_points_completed

-- start from table of roadmaps for capitalisable projects from https://docs.google.com/spreadsheets/d/1gn5WFe1PfniN2UbDv9LytvbxX9n60XlbVEs31Og37v8/edit#gid=0
FROM google_sheets.capex_roadmaps AS gs

-- join to mapping table that connects roadmaps to projects
INNER JOIN linear.roadmap_to_project AS rp
	ON gs.linear_roadmap_id = rp.roadmap_id
	AND rp._fivetran_deleted IS FALSE

-- join to roadmaps table to pull specific details for each roadmap
INNER JOIN linear.roadmap AS r
	ON gs.linear_roadmap_id = r.id
	AND r._fivetran_deleted IS FALSE

-- do the same thing with the project table
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

