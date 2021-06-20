-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Player = require "game.rules.player"
local connect = require "moonpie.redux.connect"
local tables = require "moonpie.tables"
local SpriteImage = require "game.ui.widgets.sprite_image"

local Slot = Components("quick_slots_slot", function(props)
  print("slot")
  return {
    id = "hotkey_" .. props.hotkey,
    SpriteImage { id = "HotKeyImage", sprite = props.action.image },
    Components.text { text = props.hotkey, style = "align-bottom align-right" },
    click = props.action.handler,
  }
end)

local QuickSlots = Components("quick_slots", function(props)
  local hotkeys = props.hotkeys or {}
  return {
    hotkeys = hotkeys,
    render = function(self)
      return tables.map(self.hotkeys, function(item)
        return Slot { action = item.value, hotkey = item.key }
      end)
    end
  }
end)


return connect(QuickSlots, function(state)
  local hotkeys = Player.selectors.getHotKeys(state) or {}
  local sortedKeys = tables.sortBy(hotkeys, function(k) return k end)
  return {
    hotkeys = sortedKeys
  }
end)