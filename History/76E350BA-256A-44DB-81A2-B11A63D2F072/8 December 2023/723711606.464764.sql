SELECT
  i.key,
  i.summary,
  user.name AS assignee,
  priority.name AS priority,
  latest.value AS severity,
  type.name AS issue_type,
  'https://gpventure.atlassian.net/browse/' || i.key AS url,
  i.created AS date_created,
  u.first_update,
  i.resolved AS date_resolved
FROM `jira.issue` AS i
INNER JOIN `jira.project` AS p
  ON i.project = p.id
  AND p.key = 'PTINC'
INNER JOIN `jira.issue_type` AS type
  ON i.issue_type = type.id
INNER JOIN `jira.user` AS user
  ON i.assignee = user.id
INNER JOIN `jira.priority` AS priority
  ON i.priority = priority.id
LEFT JOIN jra.vw_latest_issue_field_value AS latest
  ON i.id = latest.issue_id
  AND latest.field_id ='customfield_11118'
LEFT JOIN (
  SELECT 
    h.issue_id,
    MIN(h.value) AS first_update
  FROM `jira.issue_field_history` AS h
  WHERE h.field_id = 'updated'
  GROUP BY 1
) AS u
  ON i.id = u.issue_id