hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("EmmyLua")

local chooser = hs.chooser.new(function(selectedItem)
  hs.alert.show(hs.inspect(selectedItem))
end)
chooser:choices({
  {
    ["text"] = "First Choice",
    ["subText"] = "This is the subtext of the first choice",
    ["uuid"] = "0001",
  },
  { ["text"] = "Second Option", ["subText"] = "I wonder what I should type here?", ["uuid"] = "Bbbb" },
  {
    ["text"] = hs.styledtext.new(
      "Third Possibility",
      { font = { size = 18 }, color = hs.drawing.color.definedCollections.hammerspoon.green }
    ),
    ["subText"] = "What a lot of choosing there is going on here!",
    ["uuid"] = "III3",
  },
})
chooser:show()
