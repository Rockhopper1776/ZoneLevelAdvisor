# Zone Level Advisor

Zone Level Advisor is a World of Warcraft 3.3.5a add-on that recommends leveling zones and dungeons based on the current character's level and faction.

It is built for Wrath of the Lich King clients using TOC interface `30300`.

## Features

- Recommends leveling zones from 1-80.
- Recommends appropriate dungeons from Classic, Outland, and Northrend.
- Filters faction-specific recommendations for Alliance and Horde characters.
- Provides an in-game recommendation window and chat commands.
- Uses only the built-in WoW UI API.

## Install

1. Download or clone this repository.
2. Copy the `ZoneLevelAdvisor` folder into your WoW install at:

   ```text
   World of Warcraft/Interface/AddOns/
   ```

3. Restart the game or type `/reload`.
4. Enable "Zone Level Advisor" on the AddOns screen if needed.

## Commands

```text
/zla
```

Opens the recommendation window.

```text
/zla list
```

Prints the top zone and dungeon recommendations in chat.

```text
/zla zones
```

Prints only zone recommendations in chat.

```text
/zla dungeons
```

Prints only dungeon recommendations in chat.

```text
/zla hide
```

Closes the recommendation window.

```text
/zla help
```

Shows command help.

## Compatibility

This add-on targets World of Warcraft 3.3.5a. It is intentionally written without external libraries so it can run on older Wrath-era clients.

## License

Zone Level Advisor is released under the MIT License. See `LICENSE` for details.
