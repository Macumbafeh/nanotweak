# nanotweak

## What is it

nanotweak is a personal collection of miscellaneous QoL tweaks and automation for Wow TBC 2.4.3.

It consists of the following modules:

* automation - automatically do the following:
    * vendor greys
    * repair
    * release in BGs
    * dismount at flightmaster
    * queue for BG when talking to battlemaster
    * accept invites from friends and guildmates
    * and open bags at vendor, ah, etc.
* slash - add a bunch of additional /commands: 
    * /clearbars to remove alls spells from actionbars
    * /clearquests to remove all quests from the questlog
    * /volume or /vol to change master volume
    * /cameradist or /camera to set max camera distance
    * /maxfps to set fps cap
    * /fps to toggle fps display
	* /lp or /lg to leave group
    * /clear or /cls to clear chat
    * /helm and /cloak to toggle display of them (they keep reseting..)
    * and others..
* misc - changes:
    * Increases maximum chat lines to 1024.
    * Replaces the confirm deletion box with one that requires only accepting, instead of typing "DELETE"
    * Hides Magnifying glass button and zoom out button from worldmap
* tooltip - adds spell/item icon to tooltips
* smartchannel - automatically select bg/raid/party channel with /i


## How to configure

Currently there is no in-game config, so if you wish to toggle some of the automation features, you will need to edit the nanotweak/modules/automation.lua file.
To do so, simply open the file in your favorite text editor, change what you want and save the file. Followed by a /run ReloadUI() in the games chat to load the changes!

## How to install

Go to Releases in https://github.com/nullfoxh/nanotweak/releases and download nanotweak.zip. Extract it to your World of Warcraft/Interface/AddOns folder and you're done! Once you're done the path should look like World of Warcraft/Interface/AddOns/nanotweak/nanotweak.toc.
