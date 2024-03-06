DROP TABLE IF EXISTS plumbing.auth0_to_hubspot_company_new;
CREATE TABLE plumbing.auth0_to_hubspot_company_new (
	id BIGINT IDENTITY(1,1),
	auth0_id VARCHAR(256),
	company_id BIGINT,
	is_primary boolean
);