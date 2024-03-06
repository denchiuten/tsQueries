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
	),
	primary_emails AS (
	  SELECT
	    id,
	    property_email as email
	  FROM
	    hubs.contact
	  WHERE
	    property_email IS NOT NULL
	)

	SELECT * FROM split_additional_emails
	UNION
	SELECT * FROM primary_emails
);