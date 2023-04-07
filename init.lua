description_monoids = fmod.create()

description_monoids.description = item_monoids.make_monoid("description", {
	get_default = function(itemstack)
		local def = itemstack:get_definition()
		return def.description or def.short_description or itemstack:get_name()
	end,
	fold = function(values, default_description)
		local bgcolor
		local prefixes = {}
		local suffixes = {}
		local lines = {}
		for _, value in futil.table.pairs_by_key(values) do
			if type(value) == "string" then
				lines[#lines + 1] = value
			elseif type(value) == "table" then
				if value.colorize then
					default_description = minetest.colorize(value.colorize, default_description)
				end
				if value.bgcolor then
					bgcolor = minetest.get_background_escape_sequence(value.bgcolor)
				end
				if value.prefix then
					prefixes[#prefixes + 1] = value.prefix
				end
				if value.suffix then
					suffixes[#suffixes + 1] = value.suffix
				end
				if value.line then
					lines[#lines + 1] = value.line
				end
			end
		end
		prefixes[#prefixes + 1] = default_description
		table.insert_all(prefixes, suffixes)
		local first_line = table.concat(prefixes, " ")
		if bgcolor then
			first_line = bgcolor .. first_line
		end
		return table.concat({ first_line, unpack(lines) }, "\n")
	end,
	apply = function(description, itemstack)
		local meta = itemstack:get_meta()
		meta:set_string("description", description)
	end,
})

description_monoids.short_description = item_monoids.make_monoid("short_description", {
	get_default = function(itemstack)
		local def = itemstack:get_definition()
		if def.short_description then
			return def.short_description
		elseif def.description then
			return futil.get_safe_short_description(def.description)
		else
			return itemstack:get_name()
		end
	end,
	fold = function(values, default_short_description)
		local bgcolor
		local prefixes = {}
		local suffixes = {}
		for _, value in futil.table.pairs_by_key(values) do
			if type(value) == "string" then
				suffixes[#suffixes + 1] = value
			elseif type(value) == "table" then
				if value.colorize then
					default_short_description = minetest.colorize(value.colorize, default_short_description)
				end
				if value.bgcolor then
					bgcolor = value.bgcolor
				end
				if value.prefix then
					prefixes[#prefixes + 1] = value.prefix
				end
				if value.suffix then
					suffixes[#suffixes + 1] = value.suffix
				end
			end
		end
		prefixes[#prefixes + 1] = default_short_description
		table.insert_all(prefixes, suffixes)
		local short_description = table.concat(prefixes, " ")
		if bgcolor then
			return bgcolor .. short_description
		else
			return short_description
		end
	end,
	apply = function(description, itemstack)
		local meta = itemstack:get_meta()
		meta:set_string("description", description)
	end,
})
