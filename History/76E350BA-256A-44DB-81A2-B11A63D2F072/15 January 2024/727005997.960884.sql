SELECT DISTINCT 
	start_date::DATE,
	end_date::DATE
FROM jra.sprint
WHERE complete_date IS NULL
ORDER BY 2 DESC