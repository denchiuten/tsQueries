SELECT 
	property_email,
	property_hs_additional_emails
FROM hubs.contact 
WHERE property_hs_additional_emails IS NOT NULL
LIMIT 1000