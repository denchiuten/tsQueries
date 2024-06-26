-- create a table with one row per Hubspot contact per email address
-- in hubs.contact, multiple secondary email addresses may be nested in a single column property_hs_additional_emails which can't be used for joins

-- use a temporary table first to minimise the time the production table is dropped
CREATE OR REPLACE VIEW hubs.contact_to_emails AS 
-- Create a temporary numbers table
WITH numbers AS (
	SELECT 1 AS n UNION ALL
	SELECT 2 UNION ALL
	SELECT 3 UNION ALL
	SELECT 4 UNION ALL
	SELECT 5
),
split_additional_emails AS (
	SELECT 
		id, 
		SPLIT_PART(hc.property_hs_additional_emails, ';', n.n) as email
	FROM hubs.contact AS hc
	LEFT JOIN hubs.vw_merged_contacts AS merged
	  		ON hc.id = merged.merged_id 
	CROSS JOIN numbers AS n
	WHERE 
		SPLIT_PART(hc.property_hs_additional_emails, ';', n.n) <> ''
		AND hc.property_hs_additional_emails IS NOT NULL
		AND merged_id IS NULL
),
primary_emails AS (
	SELECT
		id,
		property_email as email
	FROM hubs.contact AS hc
	LEFT JOIN hubs.vw_merged_contacts AS merged
		ON hc.id = merged.merged_id 
	WHERE
		property_email IS NOT NULL
		AND property_email != ''
		AND merged_id IS NULL
)

SELECT * FROM split_additional_emails
UNION
SELECT * FROM primary_emails
