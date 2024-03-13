SELECT
	opt.*
FROM hubs.property_option AS opt
INNER JOIN hubs.property AS p
	ON opt.property_id = p._fivetran_id
	AND p.name = 'hs_time_to_close_sla_status'