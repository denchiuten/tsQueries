SELECT i.* 
FROM linear.attachment AS att
INNER JOIN linear.issue AS i
	ON att.issue_id = i.id
WHERE att.url = 'https://gpventure.atlassian.net/browse/MEASURE-3324'