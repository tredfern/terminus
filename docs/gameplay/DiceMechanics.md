<!--
 Copyright (c) 2021 Trevor Redfern
 
 This software is released under the MIT License.
 https://opensource.org/licenses/MIT
-->

TN == Target Number

## Dice Mechanics
1. Dice Rolls will be based on _2d6 + modifiers >= 8_
2. Degrees of success will add bonuses or just missing target will have different failures
3. Success and Failures are scored by the amount succeed or missing the TN. 
  a. Failure(2) == TN - 2, Success(0) == TN, Success(3) == TN + 3
4. Missing by more than 5 results in a Major Failure
5. Succeeding by more than 5 results in a Major Success
6. Some actions might have degrees of success of failures

## Combat Mechanics
1. TN is calculated based on Weapon base/Range Matrix
2. Modifiers are applied for Attacker skill and abilities or other modifiers like terrain
3. Modifiers are applied for Defender skill, agility, armor, or terrain
4. Major Failures might result in consequences but not always
5. Major Successes result in some bonus to damage, additional levels of success increase potential impact


### Damage Rolls
1. Damage rolls are rolled on hits
2. Armor reduces damage by a certain amount

### Modifiers
#### Character Attributes

Attribute modifiers are calculated by: `floor(Attribute / 3) - 2`

```
Attribute | Formula | Result |
----------|---------|--------|
2         | 2/3 - 2 |   -2   |
3         | 3/3 - 2 |   -1   |
4         | 4/3 - 2 |   -1   |
5         | 5/3 - 2 |   -1   |
6         | 6/3 - 2 |    0   |
7         | 7/3 - 2 |    0   |
8         | 8/3 - 2 |    0   |
9         | 9/3 - 2 |    1   |
10        |10/3 - 2 |    1   |
11        |11/3 - 2 |    1   |
12        |12/3 - 2 |    2   |
42        |42/3 - 2 |   12   |
```

### Task Difficulty

Task Level  | TN  |
------------|-----|
Trivial     | +6  |
Basic       | +4  |
Easy        | +2  |
Average     |  0  |
Challenging | -2  |
Difficult   | -4  |
Formidable  | -6  |
Legendary   | -8  |
Impossible  |-10  |
