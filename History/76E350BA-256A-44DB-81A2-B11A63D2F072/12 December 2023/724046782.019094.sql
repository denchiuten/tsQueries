-- create a table with one row per Hubspot contact per email address
-- in hubs.contact, multiple secondary email addresses may be nested in a single column property_hs_additional_emails which can't be used for joins

-- use a temporary table first to minimise the time the production table is dropped
DROP TABLE IF EXISTS hubs.contact_to_emails_temp;
CREATE TABLE hubs.contact_to_emails_temp AS (
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
	  FROM 
	    hubs.contact AS hc, 
	    numbers AS n
	  WHERE 
	    SPLIT_PART(hc.property_hs_additional_emails, ';', n.n) <> ''
	    AND hc.property_hs_additional_emails IS NOT NULL
	),
	primary_emails AS (
	  SELECT
	    id,
	    property_email as email
	  FROM
	    hubs.contact
	  WHERE
	    property_email IS NOT NULL
	    AND property_email != ''
	)

	SELECT * FROM split_additional_emails
	UNION
	SELECT * FROM primary_emails
);
-- now drop the production table and rename the temp table to the production name
DROP TABLE IF EXISTS hubs.contact_to_emails;
ALTER TABLE hubs.contact_to_emails_temp RENAME TO contact_to_emails;