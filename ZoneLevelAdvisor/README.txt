Zone Level Advisor
==================

World of Warcraft 3.3.5a add-on that recommends leveling zones and
dungeons based on the current character's level and faction.

Install
-------

1. Copy the ZoneLevelAdvisor folder into:
   World of Warcraft/Interface/AddOns/

2. Restart the game or type /reload.

3. Make sure "Zone Level Advisor" is enabled on the AddOns screen.

Commands
--------

/zla
  Opens the recommendation window.

/zla list
  Prints the top zone and dungeon recommendations in chat.

/zla zones
  Prints only zone recommendations in chat.

/zla dungeons
  Prints only dungeon recommendations in chat.

/zla hide
  Closes the recommendation window.

/zla help
  Shows command help.

Notes
-----

- Built for Wrath of the Lich King 3.3.5a using TOC interface 30300.
- Uses only the built-in WoW UI API; no external libraries are needed.
- Recommendations cover level 1-80 zones and dungeons, including
  Classic, Outland, and Northrend routes.
- Faction-specific dungeons such as Ragefire Chasm and The Stockade are
  filtered to the appropriate faction.
- Version 1.1.1 increases the advisor window size and spacing so entries
  do not overlap the refresh button or each other.

License
-------

Zone Level Advisor is released under the MIT License. See the repository
LICENSE file for details.
