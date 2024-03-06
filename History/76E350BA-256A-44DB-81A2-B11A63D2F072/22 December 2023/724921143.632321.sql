SELECT 
	t.id,
	COUNT(*)
-- 	t.property_hs_ticket_category

FROM hubs.ticket AS t
GROUP BY 1
ORDER BY 2 DESC