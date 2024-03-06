DROP VIEW IF EXISTS plumbing.vw_tool_users;
CREATE VIEW plumbing.vw_tool_users AS (
	SELECT	
		'Notion' AS tool,
		LOWER(not_u.email) AS email,
		not_u.id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM notion.users AS not_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(not_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND not_u._fivetran_deleted IS FALSE
		AND not_u.email IS NOT NULL
	
	UNION ALL
	
	SELECT
		'Slack' AS tool,
		LOWER(slack_u.profile_email) AS email,
		slack_u.id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM slack.users AS slack_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(slack_u.profile_email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND slack_u._fivetran_deleted IS FALSE
		AND slack_u.is_bot IS FALSE
		AND slack_u.deleted IS FALSE
	
	UNION ALL
	
	SELECT
		'Hubspot' AS tool,
		LOWER(hub_u.email) AS email,
		hub_u.id::VARCHAR(256) AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM hubs.users AS hub_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(hub_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND hub_u._fivetran_deleted IS FALSE
				
	UNION ALL
	
	SELECT
		'Linear' AS tool,
		LOWER(lin_u.email) AS email,
		lin_u.id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM linear.users AS lin_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(lin_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND lin_u._fivetran_deleted IS FALSE
		AND lin_u.active IS TRUE
	
	UNION ALL
	
	SELECT
		'Harvest' AS tool,
		LOWER(har_u.email) AS email,
		har_u.id::VARCHAR(256) AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM harvest.vw_users_latest AS har_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(har_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND har_u._fivetran_deleted IS FALSE
		AND har_u.is_active IS TRUE
	
	UNION ALL
	
	SELECT
		'Jira' AS tool,
		LOWER(jira_u.email) AS email,
		jira_u.id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM jra.user AS jira_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(jira_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND jira_u.is_active IS TRUE
		AND jira_u.email IS NOT NULL
	
	UNION ALL
	
	SELECT
		'auth0' AS tool,
		LOWER(auth0_u.email) AS email,
		auth0_u.id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM auth0.users AS auth0_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(auth0_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND auth0_u._fivetran_deleted IS FALSE
		AND auth0_u.email LIKE '%@terrascope.com'
	
	UNION ALL
	
	SELECT
		'Quickbooks' AS tool,
		LOWER(qb.email) AS email,
		qb.id AS user_id,
		COALESCE(emp.internal_status, 'Unknown') AS bob_status
	FROM quickbooks.employee AS qb
	LEFT JOIN bob.employee AS emp
		ON LOWER(qb.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND qb.active IS TRUE
		AND qb._fivetran_deleted IS FALSE
		AND qb.email IS NOT NULL
);