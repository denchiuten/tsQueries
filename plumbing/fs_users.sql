TRUNCATE TABLE fullstory_o_1jfe7s_na1.users;
INSERT INTO fullstory_o_1jfe7s_na1.users (
	SELECT DISTINCT 
		device_id,
		REPLACE(event_properties.user_id::VARCHAR, '"', '') AS user_id,
		LOWER(event_properties.user_email::VARCHAR) AS user_email,
		JSON_EXTRACT_PATH_TEXT(JSON_SERIALIZE(event_properties.user_properties), 'organizationId_str') AS organization_id
	FROM fullstory_o_1jfe7s_na1.events
	WHERE 
		event_type = 'identify'
		-- exclude various signals for internal users
		AND event_properties.user_email NOT LIKE '%@terrascope.com'
		AND event_properties.user_email <> 'jeevanantham.c@thoughtworks.com'
		AND event_properties.user_email NOT LIKE '%@mailinator.com'
		AND event_properties.user_email NOT LIKE '%@gmail.com'
		AND event_properties.user_email NOT LIKE '%@guerrillamail.com'
		AND event_properties.user_properties IS NOT NULL
);