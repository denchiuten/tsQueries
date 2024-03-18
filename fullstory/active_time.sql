CREATE OR REPLACE VIEW fullstory.fullstory_1enq.view_web_pageviews (
	device_id,
	session_id,
	view_id,
	page_definition_id,
	page_definition_name,
	duration_seconds,
	start_time,
	end_time) AS WITH web_navigates AS (
	SELECT
		e.device_id,
		e.session_id,
		e.view_id,
		e.event_id,
		pd.id AS page_definition_id,
		pd.name AS page_definition_name,
		event_time AS navigate_time,
		nth_value(event_time,
			2) OVER (PARTITION BY e.device_id,
			e.session_id,
			e.view_id ORDER BY e.event_time ASC ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS next_navigate_time
	FROM
		events AS e
		JOIN page_definitions AS pd ON e.source_properties :page_definition_id = pd.id
	WHERE
		e.event_type = 'navigate'
		AND e.source_type = 'web'
),
last_events AS (
SELECT
	wn.event_id,
	max(e.event_time) last_event_time
FROM
	web_navigates wn
	JOIN events e ON e.device_id = wn.device_id
		AND e.session_id = wn.session_id
		AND e.view_id = wn.view_id
		AND e.event_time >= wn.navigate_time
		and(wn.next_navigate_time IS NULL
		OR e.event_time < wn.next_navigate_time)
	GROUP BY
		wn.event_id
)
SELECT
	wn.device_id,
	wn.session_id,
	wn.view_id,
	wn.page_definition_id,
	wn.page_definition_name,
	datediff(seconds, wn.navigate_time, le.last_event_time) AS duration_seconds,
	wn.navigate_time AS start_time,
	le.last_event_time AS end_time
FROM
	web_navigates AS wn
JOIN last_events AS le ON wn.event_id = le.event_id;