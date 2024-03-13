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
);