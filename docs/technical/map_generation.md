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