SELECT * 
FROM pg_constraint 
WHERE conrelid = 'auth0_to_hubspot_company'::regclass;