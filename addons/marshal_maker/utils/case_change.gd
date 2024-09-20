class_name MMCaseChange


static func camel(string: String) -> String:
	return string.to_camel_case()


static func pascal(string: String) -> String:
	return string.to_pascal_case()


static func sentance(string: String) -> String:
	return _title(string, 1)

static func title(string: String) -> String:
	return _title(string, -1)

static func _title(string: String, amount: int) -> String:
	var snaked := snake(string)
	var splits := snaked.split("_")
	
	var MMResult := ""
	for index in splits.size():
		var split := splits[index]
		if not split:
			continue
		
		if amount < 0 or index < amount:
			split[0] = split[0].to_upper()
		
		MMResult += split
		
		var is_last := index == splits.size() - 1
		if not is_last:
			MMResult += " "
	
	return MMResult


static func snake(string: String) -> String:
	return string.replace("-", "_").to_snake_case()

static func upper_snake(string: String) -> String:
	return snake(string).to_upper()


static func kebab(string: String) -> String:
	return snake(string).replace("_", "-")

static func upper_kebab(string: String) -> String:
	return kebab(string).to_upper()
