CREATE OR REPLACE VIEW hubs.all_engagements AS (

	SELECT
		engagement_id,
		type,
		_fivetran_synced,
		_fivetran_deleted,
		property_hubspot_owner_id,
		property_hs_createdate
	FROM hubs.engagement_email
	
	UNION ALL
	
	SELECT
		engagement_id,
		type,
		_fivetran_synced,
		_fivetran_deleted,
		property_hubspot_owner_id,
		property_hs_createdate
	FROM hubs.engagement_meeting
	
	UNION ALL
	
	SELECT
		engagement_id,
		type,
		_fivetran_synced,
		_fivetran_deleted,
		property_hubspot_owner_id,
		property_hs_createdate
	FROM hubs.engagement_call
	
	UNION ALL
	
	SELECT
		engagement_id,
		type,
		_fivetran_synced,
		_fivetran_deleted,
		property_hubspot_owner_id,
		property_hs_createdate
	FROM hubs.engagement_communication
);