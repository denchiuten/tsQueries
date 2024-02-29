DROP VIEW IF EXISTS fullstory_o_1jfe7s_na1.vw_fs_users;
CREATE VIEW fullstory_o_1jfe7s_na1.vw_fs_users AS (
SELECT DISTINCT 
	device_id,
-- 	session_id,
-- 	event_id,
	JSON_EXTRACT_PATH_TEXT(event_properties::VARCHAR, 'user_id') AS user_id,
	LOWER(JSON_EXTRACT_PATH_TEXT(event_properties::VARCHAR, 'user_email')) AS user_email,
	JSON_EXTRACT_PATH_TEXT(event_properties::VARCHAR, 'user_properties', 'organizationId_str') AS organization_id
FROM fullstory_o_1jfe7s_na1.events
WHERE 
	event_type = 'identify'
	AND LOWER(JSON_EXTRACT_PATH_TEXT(event_properties::VARCHAR, 'user_email')) NOT LIKE '%@terrascope.com'
	AND JSON_EXTRACT_PATH_TEXT(event_properties::VARCHAR, 'user_properties', 'organizationId_str') IS NOT NULL
	AND JSON_EXTRACT_PATH_TEXT(event_properties::VARCHAR, 'user_properties', 'organizationId_str') <> ''
);