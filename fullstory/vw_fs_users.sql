CREATE OR REPLACE VIEW fullstory_o_1jfe7s_na1.vw_fs_users AS (
	
	SELECT DISTINCT 
			e.device_id,
			REPLACE(e.event_properties.user_id::VARCHAR, '"', '') AS user_id,
			LOWER(c.property_email) AS user_email,
			JSON_EXTRACT_PATH_TEXT(JSON_SERIALIZE(e.event_properties.user_properties), 'organizationId_str') AS organization_id
		FROM fullstory_o_1jfe7s_na1.events AS e
		INNER JOIN hubs.contact_to_emails AS map
			ON LOWER(e.event_properties.user_email::VARCHAR) = LOWER(map.email)
		INNER JOIN hubs.contact AS c
			ON map.id = c.id
			AND c._fivetran_deleted IS FALSE
		WHERE 
			1 = 1
			AND e.event_type = 'identify'
			-- exclude various signals for internal users
			AND e.event_properties.user_email NOT LIKE '%@terrascope.com'
			AND e.event_properties.user_email <> 'jeevanantham.c@thoughtworks.com'
			AND e.event_properties.user_email NOT LIKE '%@mailinator.com'
			AND e.event_properties.user_email NOT LIKE '%@gmail.com'
			AND e.event_properties.user_email NOT LIKE '%@guerrillamail.com'
			AND e.event_properties.user_properties IS NOT NULL
);
