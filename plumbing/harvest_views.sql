
-- Create views of latest records for harvest entries
CREATE OR REPLACE VIEW harvest.vw_time_entry_latest AS 
SELECT
	t.*
FROM harvest.time_entry AS t
INNER JOIN (
	SELECT
		id,
		MAX(updated_at) AS updated_at
	FROM harvest.time_entry
	WHERE _fivetran_deleted IS FALSE
	GROUP BY 1
) AS latest
	ON t.id = latest.id
	AND t.updated_at = latest.updated_at
	AND t._fivetran_deleted IS FALSE;

CREATE OR REPLACE VIEW harvest.vw_users_latest AS 
SELECT
	u.*
FROM harvest.users AS u
INNER JOIN (
	SELECT
		id,
		MAX(updated_at) AS updated_at
	FROM harvest.users
	WHERE _fivetran_deleted IS FALSE
	GROUP BY 1
) AS latest
	ON u.id = latest.id
	AND u.updated_at = latest.updated_at
	AND u._fivetran_deleted IS FALSE;

CREATE OR REPLACE VIEW harvest.vw_tasks_latest AS 
SELECT
	t.*
FROM harvest.task AS t
INNER JOIN (
	SELECT
		id,
		MAX(updated_at) AS updated_at
	FROM harvest.task
	WHERE _fivetran_deleted IS FALSE
	GROUP BY 1
) AS latest
	ON t.id = latest.id
	AND t.updated_at = latest.updated_at
	AND t._fivetran_deleted IS FALSE;
