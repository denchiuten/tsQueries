SELECT
name,
label,
_fivetran_id
FROM hubs.property
WHERE hubspot_object = 'deal'
ORDER BY 1