SELECT 
	opt.name
INNER JOIN jra.field_option As opt
	ON field.value = opt.id