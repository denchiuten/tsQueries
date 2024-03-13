-- 1st CTE to identify all project_ids under the 2024 Features roadmap -- 
WITH 
all_projects AS (
 	SELECT 
 		p.id AS project_id,
 		p.name AS project_name	
 	FROM linear.project AS p
	INNER JOIN linear.roadmap_to_project AS rp
  		ON p.id = rp.project_id
	WHERE rp.roadmap_id = 'bcaa52ba-7dc0-4004-9a1f-c493dac497b3'
	AND p._fivetran_deleted IS FALSE 
	AND rp._fivetran_deleted IS FALSE
 	AND p.state IN ('backlog', 'started', 'planned')
),

-- 2nd CTE to identify all employees who are a shared resource -- 
shared_user_data AS (
	SELECT 
		e.full_name AS full_name,
		e.work_title AS work_title,
		u.id AS user_id
	FROM google_sheets.capex_mapping AS cm
	INNER JOIN bob.employee AS e
		ON cm.role = e.work_title
		AND e._fivetran_deleted IS FALSE 
	INNER JOIN linear.users AS u
		ON LOWER(e.email) = LOWER(u.email)
		AND u._fivetran_deleted IS FALSE
	WHERE cm.shared_resource IS TRUE
)

-- CROSS JOIN to get all possible combination of members who are shared users and their projects they should be in -- 
SELECT 
	shared_user_data.full_name,
	shared_user_data.work_title,
	shared_user_data.user_id,
	all_projects.project_id,
	all_projects.project_name
FROM shared_user_data
CROSS JOIN all_projects
