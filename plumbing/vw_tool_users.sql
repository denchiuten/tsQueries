CREATE OR REPLACE VIEW plumbing.vw_tool_users AS (
	SELECT	
		'Notion' AS tool,
		LOWER(not_u.email) AS email,
		not_u.id AS user_id,
		COALESCE(emp.status, 'Unknown') AS bob_status
	FROM google_sheets.notion_users AS not_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(not_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND not_u.type = 'person'
	
	UNION ALL
	
	SELECT
		'Slack' AS tool,
		LOWER(slack_u.profile_email) AS email,
		slack_u.id AS user_id,
		COALESCE(emp.status, 'Unknown') AS bob_status
	FROM slack.users AS slack_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(slack_u.profile_email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND slack_u._fivetran_deleted IS FALSE
		AND slack_u.is_bot IS FALSE
		AND slack_u.deleted IS FALSE
		AND slack_u.name <> 'slackbot'
	
	UNION ALL
	
	SELECT
		'Hubspot' AS tool,
		LOWER(hub_u.email) AS email,
		hub_u.owner_id::VARCHAR(256) AS user_id,
		COALESCE(emp.status, 'Unknown') AS bob_status
	FROM hubs.owner AS hub_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(hub_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND hub_u.is_active IS TRUE
				
	UNION ALL
	
	SELECT
		'Linear' AS tool,
		LOWER(lin_u.email) AS email,
		lin_u.id AS user_id,
		COALESCE(emp.status, 'Unknown') AS bob_status
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
		COALESCE(emp.status, 'Unknown') AS bob_status
	FROM harvest.vw_users_latest AS har_u
	LEFT JOIN bob.employee AS emp
		ON LOWER(har_u.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND har_u._fivetran_deleted IS FALSE
		AND har_u.is_active IS TRUE
	
	UNION ALL
	
	SELECT
		'auth0' AS tool,
		LOWER(auth0_u.email) AS email,
		auth0_u.id AS user_id,
		COALESCE(emp.status, 'Unknown') AS bob_status
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
		COALESCE(emp.status, 'Unknown') AS bob_status
	FROM quickbooks.employee AS qb
	LEFT JOIN bob.employee AS emp
		ON LOWER(qb.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND qb.active IS TRUE
		AND qb._fivetran_deleted IS FALSE
		AND qb.email IS NOT NULL
	
	UNION ALL
		
	SELECT
		'Tableau' AS tool,
		LOWER(t.email) AS email,
		t.id AS user_id,
		COALESCE(emp.status, 'Unknown') AS bob_status
	FROM tableau.users AS t
	LEFT JOIN bob.employee AS emp
		ON LOWER(t.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND t._fivetran_deleted IS FALSE
		AND t.email IS NOT NULL
	
	UNION ALL
		
	SELECT
		'Testmo' AS tool,
		LOWER(testmo.email) AS email,
		testmo.id::VARCHAR(256) AS user_id,
		COALESCE(emp.status, 'Unknown') AS bob_status
	FROM google_sheets.testmo_users AS testmo
	LEFT JOIN bob.employee AS emp
		ON LOWER(testmo.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND testmo.is_active IS TRUE
	
	UNION ALL
	
	SELECT
		'Zoom' AS tool,
		LOWER(z.email) AS email,
		z.id AS user_id,
		COALESCE(emp.status, 'Unknown') AS bob_status
	FROM zoom.users AS z
	LEFT JOIN bob.employee AS emp
		ON LOWER(z.email) = LOWER(emp.email)
	WHERE
		1 = 1
		AND z.status = 'active'
		AND z._fivetran_deleted IS FALSE
);