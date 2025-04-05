# YourMAPS FlagScript

A flag system for **RedM**, created to fill the gap in available scripts that allow players to equip and interact with flags as in-game items.

This system enables players to carry, drop, and pick up flags in an immersive and configurable way. 
It supports full integration with item-based frameworks, animations, prompts, and a wide selection of customizable flags.

---

## Supported Frameworks

- ✅ **REDEMRP** (fully integrated with item usage and jobs)
- ✅ **VORP** (with built-in prompt support)
- ✅ **OTHER** (basic usage with native text prompts)

---
![imagem](https://github.com/user-attachments/assets/df41b58d-4426-4485-aaa7-026e5259950c)

## Key Features

- Carry Flags in Hand
Players can equip and carry flags using immersive animations and prop attachments.

- Drop & Pick Up with Keybinds
Easily drop flags on the ground or pick them up again using fully configurable keybinds.

- Client & Server-Side Logic
Handles full animation flow, object attachment, drop/pickup distances, item checks, and cleanup logic.

- Optional Slash Commands & Item Requirements
Works with REDEMRP, VORP, or any other framework. You can restrict flags to specific items or jobs if desired.

- Automatic Cleanup on Respawn
Ensures flags are removed or reset when a player dies or respawns, preventing visual or logic issues.

- Only Mexico, Canada, LGBTQ, and Trans flags are included by default. 40+ Flags Preconfigured
Includes national, tribal, and in-game state flags. Other flags are not included on this free release.

- Support Available
Join our community for help, updates, and suggestions regarding the flag system or other mapping support.

![imagem](https://github.com/user-attachments/assets/31dde33b-d76a-48bb-be80-94f0de7b60df)

---

Installation

    Place the resource:

Put the folder yourmaps_flags inside your RedM resources directory.

    Start the script:

Add this line to your server.cfg:

 ensure yourmaps_flags

    Configure the script:

Open config.lua and adjust the settings, keybinds, language translation and flags to your preference.

    Create the flag items:

This script uses inventory items to spawn flags.

**You must create the flag items in your inventory system**, using either:

    Your framework's item registration method, OR

    Directly inserting them into your database via SQL.

    ⚠️ Note: All usable flag items are already listed inside config.lua and on SQL file for easy copy/paste into your item database.

After that, restart your server and enjoy! 

---

![imagem](https://github.com/user-attachments/assets/27960af6-3c6b-42e5-9230-5e153ca96f91)


This script was developed due to the lack of standalone flag systems available for RedM.

It is a fully open-source and free script designed to expand roleplay possibilities by allowing players to carry, drop, and interact with immersive flags in-game.

Feel free to edit, expand, or adapt the code to fit your server's needs.
If you add new features or improvements, we encourage you to share them with the community so others can benefit too!

---

**Tafé - YourMAPS**   

