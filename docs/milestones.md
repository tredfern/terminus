#### Current Goal: First public release
A game with:
- Basic Character Generation
- Combat mechanics
- Small variety of enemies
- Basic skill checks
- Something that feels like a spaceship
- A story framework exists
- Small variety items that can be found and used
- A couple of different environments
- Some NPC characters to interact with

## Key Milestones
### 0. Basic foundations [COMPLETED]
This is some next steps to lay good foundations depending on what comes up next
  - Load/Save game: Always a tricky thing to work out, building this in early should be easier than deferring to the last moment. Use a save game slot system
  - Options screen: Simple ability to set resolution for game, change key maps. This is to prevent anything being too rigid to change later
  - Character Details Screen: Something in game to pop-up a display over the map

### 1. Simple roguelike [COMPLETED]
This should focus on moving the character around an testing the combat system
  - Inventory to equip melee and ranged weapon
  - Create enemy spawners that trigger new enemies whenever rooms are empty
  - Character generation gives some ability scores and combat skills
  - AI that charges the player down
  - Some ability to heal character
  - Spawners can be removed with an item
  - Removing all spawners results in winning the game

### 2. Gameplay Focus << I Am Here >>
This milestone will be complete when there is game that has received feedback from at least 1 person that I do not know.

Expanding the maps slightly
  - Ladders that go up/down. When returning to a previous level the level should look like it did when you left
  - Introduce skill checks like a computer terminal that opens a door, 
  - Items are added to rooms/corridors that could serve a function for skill checks
  - Description generators for rooms
  - "Static" rooms that could be used for key plot points
  - Map zoom out display

### 3. Improved AI
  - Patrolling AI that moves from room to room 
  - Guard AI that stays in room until the player enters
  - Repair AI that fixes up enemy units that are damaged
  - Fleeing AI that runs after taking a certain amount of damage
  - Introduce Allies that assist player
    - AI Holding rooms that are cleared
    - AI Follow player and assist in battle

### 4. Story Events
  - Introduce quests
  - Messages that can happen describing what is going on
  - Intro screen setting up the scene
  - Define a story arc based on the levels that you move through
  - Introduce different environment conditions (Fire and Vacuum)