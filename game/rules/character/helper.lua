-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characterHelper = {}

function characterHelper.newCharacter(props)
  props = props or {}
  return {
    x = props.x or 0,
    y = props.y or 0,
    isPlayerControlled = props.isPlayerControlled,
    isEnemy = props.isEnemy,
    health = 10,
    attack = 50,
    defense = 50
  }
end

return characterHelper