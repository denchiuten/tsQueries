SELECT 
	field.value,
	opt.name
LEFT JOIN jra.field_option As opt
	ON field.value = opt.id