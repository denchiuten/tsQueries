
-- first part of the query that identifies only shared resource members -- 
	SELECT DISTINCT 
		-- member's details -- 
		e.full_name,
		e.email,
		e.department,
		cm.team,
		e.title,
		cm.development_share, 
		cm.shared_resource,
		
		-- project details -- 
		active_projects.project_id,
		active_projects.project_name,
		INITCAP(active_projects.project_status) AS project_status,
		DATE_TRUNC('month', active_projects.started_at)::DATE AS project_start_date,
		LAST_DAY(active_projects.target_date) AS project_target_date,
		LAST_DAY(active_projects.completed_at::DATE) AS project_completed_date,
		active_projects.issue_completion_date AS issue_completed_at
		
	FROM google_sheets.capex_mapping AS cm
	INNER JOIN bob.employee AS e
		ON TRIM(LOWER(cm.role)) = TRIM(LOWER(e.title))
		AND cm.department = e.department
		AND cm.shared_resource IS TRUE
	
	CROSS JOIN ( SELECT DISTINCT
				 			p.id AS project_id,
				 			p.name AS project_name,
				 			p.state AS project_status,
							p.started_at,
							p.target_date,
							p.completed_at,
				 			DATE_TRUNC('month', i.completed_at)::DATE AS issue_completion_date
				 FROM linear.roadmap_to_project AS rp
				 INNER JOIN linear.project AS p
				 	ON rp.project_id = p.id
				 	AND p._fivetran_deleted IS FALSE
				 INNER JOIN linear.issue AS i
					ON rp.project_id = i.project_id
					AND i._fivetran_deleted IS FALSE
				 INNER JOIN linear.workflow_state AS ws 
					ON i.state_id = ws.id
					AND ws._fivetran_deleted IS FALSE
					AND ws.name = 'Done'
				 WHERE rp.roadmap_id = 'bcaa52ba-7dc0-4004-9a1f-c493dac497b3'
					AND rp._fivetran_deleted IS FALSE	 
	) AS active_projects  
	
-- UNION to all linear project individuals that filters out duplicates from shared resource members --  
UNION

(
	SELECT DISTINCT 
		-- member's details -- 
		e.full_name,
		e.email,
		e.department,
		map.team,
		e.title,
		map.development_share,
		map.shared_resource,
		
		-- project details -- 
		p.id AS project_id,
		p.name AS project_name,
		INITCAP(p.state) AS project_status,
		DATE_TRUNC('month', p.started_at)::DATE AS project_start_date,
		LAST_DAY(p.target_date) AS project_target_date,
		LAST_DAY(p.completed_at::DATE) AS project_completed_date,
		active_projects.issue_completion AS issue_completed_at
	
	FROM google_sheets.capex_mapping AS map
	INNER JOIN bob.employee AS e
		-- TRIM and LOWER for trailing white space/improper capitalisation, and JOIN on department since some job titles may exist in multiple departments 
		ON TRIM(LOWER(map.role)) = TRIM(LOWER(e.title))
		AND map.department = e.department
	INNER JOIN linear.users AS u
		ON LOWER(e.email) = LOWER(u.email)
	LEFT JOIN linear.project_member AS mem
		ON u.id = mem.member_id
		AND mem._fivetran_deleted IS FALSE
	LEFT JOIN linear.project AS p
		ON mem.project_id = p.id
		AND p._fivetran_deleted IS FALSE
	
	-- INNER JOIN to include only truly active projects, with storypoints completed within the month --
	INNER JOIN (
		SELECT DISTINCT
		    rp.project_id,
			DATE_TRUNC('month', i.completed_at)::DATE AS issue_completion
		FROM linear.roadmap_to_project AS rp
		INNER JOIN linear.issue AS i
			ON rp.project_id = i.project_id
			AND i._fivetran_deleted IS FALSE
		INNER JOIN linear.workflow_state AS ws
			ON i.state_id = ws.id
			AND ws._fivetran_deleted IS FALSE
			AND ws.name = 'Done'
		WHERE rp.roadmap_id = 'bcaa52ba-7dc0-4004-9a1f-c493dac497b3'
			AND rp._fivetran_deleted IS FALSE
	) AS active_projects
		ON mem.project_id = active_projects.project_id
	
	-- only capitalisable resources from within CapEx Roles Mapping (filters out non capitalisable roles in case they are somehow within the sheet) -- 
	WHERE map.development_share > 0
		AND e._fivetran_deleted IS FALSE
	
	UNION ALL
	
	-- add dummy rows for every combination of person and month
	SELECT DISTINCT 
		-- member's details -- 
		e.full_name,
		e.email,
		e.department AS department,
		map.team,
		e.title AS title,
		map.development_share,
		map.shared_resource,
			
		-- project details -- 
		NULL AS project_id,
		NULL AS project_name,
		NULL AS project_status,
		DATE_TRUNC('month', p.started_at)::DATE AS project_start_date,
		LAST_DAY(p.target_date) AS project_target_date,
		LAST_DAY(p.completed_at::DATE) AS project_completed_date,
		
		-- dummy completed date -- 
		DATE_TRUNC('month', d.date)::DATE AS completed_at
	
	FROM google_sheets.capex_mapping AS map
	INNER JOIN bob.employee AS e
		-- add RTRIM and LOWER to correct for trailing white space and improper capitalisation --
		ON RTRIM(LOWER(map.role)) = RTRIM(LOWER(e.title))
		
		-- also include department in the JOIN since some job titles may exist in multiple departments --
		AND map.department = e.department
		AND e._fivetran_deleted IS FALSE
	INNER JOIN linear.users AS u
		ON LOWER(e.email) = LOWER(u.email)
	LEFT JOIN linear.project_member AS mem
		ON u.id = mem.member_id
		AND mem._fivetran_deleted IS FALSE
	LEFT JOIN linear.project AS p
		ON mem.project_id = p.id
		AND p._fivetran_deleted IS FALSE
	LEFT JOIN plumbing.dates AS d
		
		-- dummy dates that are between the start of the year and current date --
		ON d.date BETWEEN DATE_TRUNC('year', CURRENT_DATE) AND CURRENT_DATE
)