SELECT
	COUNT(board_id),
	COUNT(DISTINCT board_id),
	COUNT(project_id),
	COUNT(DISTINCT project_id)
FROM jra.project_board