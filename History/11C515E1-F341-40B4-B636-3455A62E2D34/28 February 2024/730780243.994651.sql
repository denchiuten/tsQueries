SELECT d.date
FROM plumbing.dates AS d	
WHERE d.date BETWEEN DATE_TRUNC('year', CURRENT_DATE) AND CURRENT_DATE
ORDER BY 1