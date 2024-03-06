SELECT *
FROM linear.label
WHERE id IN (
	'bd8f293e-3782-4793-a8dd-08a076912b91',
	'62429111-3bbb-4d32-a26d-58de3a5f3293'
);
SELECT *
FROM plumbing.hs_ticket_to_linear_label AS map
WHERE map.linear_label_id IN (
	'bd8f293e-3782-4793-a8dd-08a076912b91',
	'62429111-3bbb-4d32-a26d-58de3a5f3293'
);