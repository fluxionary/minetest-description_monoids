item_description_monoid = fmod.create()

item_description_monoid.monoid = item_monoids.make_monoid("description", {
	get_default = function(itemstack)
		return itemstack:get_definition().description or itemstack:get_name()
	end,
	fold = function(values, default_description)
		local lines = { default_description }
		for key, value in futil.table.pairs_by_key(values) do
			if key == "description" then
				lines[1] = value
			else
				lines[#lines + 1] = value
			end
		end
		return table.concat(lines, "\n")
	end,
	apply = function(description, itemstack)
		local meta = itemstack:get_meta()
		meta:set_string("description", description)
	end,
})
