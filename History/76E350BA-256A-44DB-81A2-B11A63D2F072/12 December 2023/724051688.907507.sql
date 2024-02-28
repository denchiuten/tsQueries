SELECT
	COUNT(c.*)
FROM hubs.contact AS c
LEFT JOIN hubs.vw_merged_contacts AS merged
	ON c.id = merged.merged_id