SELECT
	e.event_properties,
	e.event_properties.user_properties
FROM fullstory_o_1jfe7s_na1.events AS e
WHERE 
	EXTRACT(YEAR FROM e.event_time::DATE) = 2024
	AND e.event_properties.user_properties IS NOT NULL
LIMIT 1000

