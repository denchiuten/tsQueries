SELECT *
FROM notion.page
-- WHERE id LIKE '7fe%'
WHERE REPLACE(parent_page_id, '-', '') = '7fe0dfb4f84f4b3b8fc3cca27a621022'