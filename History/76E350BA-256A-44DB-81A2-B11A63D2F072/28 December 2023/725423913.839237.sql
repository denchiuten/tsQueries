SELECT	
	not_u.email,
	not_u.name,
	emp.internal_status AS bob_status,
	bot.user_id
FROM notion.users AS not_u
LEFT JOIN bob.employee AS emp
	ON not_u.email = emp.email
LEFT JOIN notion.user_bot AS bot
	ON not_u.id = bot.user_id
WHERE
	1 = 1
	AND not_u._fivetran_deleted IS FALSE
ORDER BY 3,1