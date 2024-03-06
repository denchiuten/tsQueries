-- SELECT *
-- FROM hubs.contact_to_emails
-- WHERE email = 'shlim@networkfoods.com.my'

SELECT
	id,
	property_email,
	property_firstname,
	property_lastname,
	property_hs_additional_emails,
	property_hs_merged_object_ids
FROM hubs.contact
WHERE id IN(41201,3447251)