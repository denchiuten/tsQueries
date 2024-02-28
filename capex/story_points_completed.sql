SELECT 
	p.name AS project_name,
	lead.name AS project_lead,
	p.started_at:: DATE AS project_start_date,
	p.target_date::DATE AS project_target_date,
	p.completed_at::DATE AS project_completed_date,
	t.name AS team_name,
	t.key AS team_key,
	u.email AS assignee_email,
	u.name AS assignee_name,
	b.work_title AS role,
	cpm.team,
	b.work_department AS department,
	i.completed_at::DATE AS completed_at,
	i.id AS issue_id,
	i.identifier AS issue_key,
	i.title AS issue_title,
	COALESCE(i.estimate, 1) AS estimate,
	cpm.development_share,
	MAX(MAX(i._fivetran_synced)) OVER()::TIMESTAMP AS data_up_to
	-- Retrieving MAX fivetran_synced to get latest update date -- 
	
FROM linear.roadmap AS r
INNER JOIN linear.roadmap_to_project AS rp
	ON r.id = rp.roadmap_id
	AND rp._fivetran_deleted IS FALSE
-- Joining roadmap table to roadmap_to_project table , for current valid records only -- 

INNER JOIN linear.project AS p
	ON rp.project_id = p.id
	AND p._fivetran_deleted IS FALSE
-- Joining roadmap_to_project table to project table , for current valid records only -- 

INNER JOIN linear.issue AS i
	ON p.id = i.project_id
	AND i._fivetran_deleted IS FALSE
	AND i.completed_at IS NOT NULL
	
-- Joining project table to issue table , for current valid records and completed issues only -- 

INNER JOIN linear.team AS t 
	ON i.team_id = t.id
	AND t._fivetran_deleted IS FALSE	 
-- Joining issue table to team table , for current valid records only (why do we need the team) -- 

INNER JOIN linear.users AS u 
	ON i.assignee_id = u.id
<<<<<<< HEAD
	AND u._fivetran_deleted IS FALSE	
-- Joining issue table to users table , for current valid records only -- 

INNER JOIN linear.users AS lead
=======
LEFT JOIN linear.users AS lead
>>>>>>> 45b05617b993369a4fd703021a62e0bd23d4c7e3
	ON p.lead_id = lead.id
	AND lead._fivetran_deleted IS FALSE
-- Joining project table to users table , to retrieve project's lead (user) --

INNER JOIN bob.employee AS b
	ON u.email = b.email
	AND b._fivetran_deleted IS FALSE
-- Joining linear schema to bob schema to retrieve employee's email on email column --  

INNER JOIN google_sheets.capex_mapping AS cpm
	ON b.work_title = cpm.role
-- Joining bob schema to google_sheets schema to retrieve employee's role --  

LEFT JOIN linear.issue_label AS il
	ON i.id = il.issue_id 
	AND il.label_id = '182bdac2-2793-457e-800d-0f4afc997c9b'
-- Joining issue table to issue_label table to filter out bug issue type -- 

WHERE 
	il.label_id IS NULL	
AND
	r.name = '2024 Features Roadmap' 
AND 
	r._fivetran_deleted IS FALSE 
	
GROUP BY 
	p.name,
	lead.name,
	p.started_at :: DATE,
	p.target_date :: DATE, 
	p.completed_at :: DATE,
	t.name,
	t.key,
	u.email,
	u.name,
	b.work_title,
	b.work_department,
	cpm.team,
	i.completed_at :: DATE,
	i.id,
	i.identifier,
	i.title,
	COALESCE(i.estimate, 1),
	cpm.development_share