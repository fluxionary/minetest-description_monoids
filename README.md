# description_monoids

API to allow multiple mods to make modifications to an itemstack's description without clobbering each other.

### usage

```lua
function break_wielded_item(player)
    local wielded_item = player:get_wielded_item()
    if wielded_item:get_definition().type == "tool" then
        description_monoids.monoid:add_change(wielded_item, {
            prefix = "BROKEN",
            colorize = "#FFFFFF",
            bgcolor = "#FF0000",
        }, "broken")
        player:set_wielded_item(wielded_item)
    end

end

function enchant(tool)
    description_monoids.monoid:add_change(tool, {
        prefix =  minetest.colorize("#FFFF00", "enchanted"),
        line = minetest.colorize("#FFFF00", "sharp (10%)")
    }, "enchanted")
end
```
