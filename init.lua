local spawner_def = minetest.registered_nodes["mcl_mobspawners:spawner"]
spawner_def.on_place = nil

minetest.override_item("mcl_mobspawners:spawner", {
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local itemmeta = itemstack:get_meta()
		meta:set_string("name", itemmeta:get_string("name"))
		meta:set_string("description", itemmeta:get_string("description"))
		local fields = itemmeta:to_table().fields
		mcl_mobspawners.setup_spawner(pos, fields.Mob, fields.MinLight, fields.MaxLight, fields.MaxMobsInArea, fields.PlayerDistance, fields.YOffset)
	end,
	after_dig_node = function(pos, node, meta, digger)
		local itemstack = ItemStack("mcl_mobspawners:spawner")
		itemstack:get_meta():from_table(meta)
		tt.reload_itemstack_description(itemstack)
		minetest.add_item(pos, itemstack)
	end
})

tt.register_snippet(function(itemstring, _, itemstack)
	if itemstring ~= "mcl_mobspawners:spawner" or not itemstack then
		return
	end
	local mob = itemstack:get_meta():get_string("Mob")
	if mob ~= "" then
		return "Mob type: " .. mob
	end
end)
