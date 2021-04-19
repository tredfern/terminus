# Procedural Generation Design and Notes

## Generation Technic
1. Build up the outline for the dungeon composed of areas that define different parameters
  a. An area could be a room
  b. An area could be a corridor connecting points together
  c. An area could be an open area of a world, like a forest, village, or cave
2. Areas can be broken down into more areas or into individual tiles if
  the area is specific enough
3. This outline can define a hierarchical nature to the data, allowing descriptions etc.
  It also allows freedom from the specifics of the tiles until we are ready to fill those
  in.
4. Fill in the tile/terrain
  a. Iterate over all the areas and fill in the area based on what it is. Filling in a laboratory, add items that
    are appropriate. Maybe a room has defined a caved in wall, put some rubble onto one side, etc...

I like this as a concept because it delays the tile information until we have enough information to make 
interesting decisions on what the tiles should represent.

I dislike this because delaying the tile data means making irregular shapes might be difficult or maybe
the map won't seem to fit together well. It also means we need to have a good understanding of the structure
of the outline and not overlap accidentally.
  _Though with more thinking on this, I think irregular shapes won't be too difficult. If the blocking out just defines
  the total area available and some more specific room generation routines are used to fill in the tile map data, then
  this becomes less of an issue_

## Multiple maps
Maps that connect to maps that connect back to maps... how to organize this?

**Requirements**
  - Characters need to know what map they are on
  - Characters should be able to move from one map to another if they want
  - How many maps can I keep loaded at a time? (Start with all?)
  - Requests for map information like neighbors or terrain need to specify the map
  - Avoid building something like "current" map? It's a handy shortcut but does that
    result in brittleness?
  - Redefine position information to include the map? 
  - Another option is to create 3-dimensional map and changing levels just changes
    Z coordinates. That way there is always just one "map". Actually, this is more
    robust since it could allow for rooms that are multiple levels tall. It also would
    support interesting outdoor environments. Finally, switching to isometric could
    allow more interesting rendering.
  - However, even with this, there will be times when a new map is loaded, but that
    actually isn't bad. Because at that time, everything will need to be refreshed.
    It still means that characters/entities need to track the map for their position
    coordinates. 
  - If ladders change between z-indexes then the map needs to connect levels together
    directly. That's cool though because then ladders make sense if there are multiple
    ways between levels.



## Research

### Links
#### Dungeons
- [donjon](https://donjon.bin.sh/code/dungeon/)
- [Comprehensive overview](https://devforum.roblox.com/t/dungeon-generation-a-procedural-generation-guide/342413)
- [Nice and Direct](https://gamedevelopment.tutsplus.com/tutorials/create-a-procedurally-generated-dungeon-cave-system--gamedev-10099)
- [Cogmind](https://www.gridsagegames.com/blog/2014/06/procedural-map-generation/)

#### Caves
- [Cave Like Map](https://csharpcodewhisperer.blogspot.com/2013/07/Rouge-like-dungeon-generation.html)


#### Tunnelers
* http://dungeonmaker.sourceforge.net/DM2_Manual/index.html