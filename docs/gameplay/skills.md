<!--
 Copyright (c) 2021 Trevor Redfern
 
 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

## Skills
Skills have an attribute that establishes the base ability for the skill. If the character is untrained
in the skill, either a penalty is applied or they are incapable of attempting the skill.

## Defining New Skills

Core skills are added to `data/skills.lua`

```lua
  -- Defining a skill
  local Skills = require "game.rules.skills"

  Skills.describe {
    name = "Pilot",  -- How the skill is displayed
    key = "pilot",  -- The reference key for the skill
    attribute = attributes.education, -- What attribute provides the base for the skill
    untrained = -4 -- What modifier for being untrained in a skill. If not defined, the skill cannot be used
  }
```

## Skill Checks

Skill checks are performed by rolling 3d6 and comparing against the skill and attributes of the character in question.

### Opposing Skill Checks

Opposing skill checks are made by the aggressor and defender both performing their skill checks. The scores are
subtracted from the target. The highest value left over wins.

```
  Aggressor: Diplomacy (15)
  Defender: Insight (8)

  Aggressor rolls a 13, Defender rolls a 4. (15-13 =2, 8-4 = 4). The defender wins
  Aggressor rolls a 16, Defender rolls a 12 (15-16 = -1, 8 - 12 = -4). The aggressor wins
```

In contested skill checks their is always a winner right now. Maybe that will change??

