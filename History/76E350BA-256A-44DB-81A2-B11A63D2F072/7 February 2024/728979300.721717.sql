SELECT * 
FROM pg_constraint 
WHERE conrelid = 'plumbing.auth0_to_hubspot_company'::regclass;