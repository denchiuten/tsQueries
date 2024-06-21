SELECT
	release.id,
	release.created_at,
	release.draft,
	release.name,
	release.prerelease,
	release.published_at,
	release.tag_name,
	release.author_id,
	CASE 
		WHEN release.name ILIKE '%hotfix%' THEN TRUE
		ELSE FALSE
	END AS is_hotfix
FROM github.repository AS r
INNER JOIN github.release AS release
	ON r.id = release.repository_id
WHERE
	1 = 1
	AND r.name = 'release-manifest'