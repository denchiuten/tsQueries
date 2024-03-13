SELECT
	COUNT(*)
FROM hubs.company AS c
LEFT JOIN hubs.vw_merged_companies AS merged
	ON c.id = merged.merged_id
WHERE merged.merged_id IS NULL