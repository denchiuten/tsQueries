SELECT *

FROM linear.label
WHERE id IN (
	'bd8f293e-3782-4793-a8dd-08a076912b91',
	'218c7918-1f4c-4ce7-a231-c6a78e658538',
	'9a5cf354-1d3a-49c4-91fd-5a7419ce11e9',
	'2bc391a6-06b5-4cb5-92f2-2e2802f695a8'
)

-- UPDATE plumbing.hs_ticket_to_linear_label
-- SET linear_label_id = '9f7b3fd0-6a89-48df-ac2a-f0e828f06d9a'
-- WHERE linear_label_name = 'Platform Issues'


-- SELECT *
-- FROM linear.label
-- WHERE name = 'Platform Issues'