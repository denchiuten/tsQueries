CREATE OR REPLACE VIEW plumbing.vw_user_id_lookup AS (
SELECT
	LOWER(COALESCE(b.email, s.profile_email, n.email, l.email, hub.email, hub_o.email, har.email, t.email, test.email)) AS email,
	b.id AS bob_user_id,
	s.id AS slack_user_id,
	n.id AS notion_user_id,
	l.id AS linear_user_id,
	hub.id AS hubspot_user_id,
	hub_o.owner_id AS hubspot_owner_id,
	har.id AS harvest_user_id,
	t.id AS tableau_user_id,
	test.id AS testmo_user_id
FROM bob.employee AS b
FULL OUTER JOIN slack.users AS s
	ON LOWER(b.email) = LOWER(s.profile_email)
	AND s._fivetran_deleted IS FALSE
	AND s.is_bot IS FALSE
	AND s.deleted IS FALSE
	AND s.profile_email IS NOT NULL
FULL OUTER JOIN google_sheets.notion_users AS n
	ON LOWER(b.email) = LOWER(n.email)
	AND n.type = 'person'
FULL OUTER JOIN linear.users AS l
	ON LOWER(b.email) = LOWER(l.email)
	AND l._fivetran_deleted IS FALSE
	AND l.active IS TRUE
FULL OUTER JOIN hubs.users AS hub
	ON LOWER(b.email) = LOWER(hub.email)
	AND hub._fivetran_deleted IS FALSE
FULL OUTER JOIN hubs.owner AS hub_o
	ON LOWER(b.email) = LOWER(hub_o.email)
	AND hub_o.is_active IS TRUE
FULL OUTER JOIN harvest.vw_users_latest AS har
	ON LOWER(b.email) = LOWER(har.email)
	AND har._fivetran_deleted IS FALSE
	AND har.is_active IS TRUE
FULL OUTER JOIN tableau.users AS t
	ON LOWER(b.email) = LOWER(t.email) 
	AND t.email IS NOT NULL
	AND t._fivetran_deleted IS FALSE
FULL OUTER JOIN google_sheets.testmo_users AS test
	ON LOWER(b.email) = LOWER(test.email)
	AND test.is_active IS TRUE
WHERE
	1 = 1
	AND b._fivetran_deleted IS FALSE
	AND b.internal_status = 'Active'
ORDER BY 1
);
