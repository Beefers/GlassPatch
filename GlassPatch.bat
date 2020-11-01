@echo off
setlocal enableDelayedExpansion

rem Variables (don't mess with unless you know what you're doing)
set "glasscord=require('./glasscord.asar');"
set "core=module.exports = require('./core.asar');"
set "stablever=0.0.308"
set "ptbver=0.0.55"
set "canaryver=0.0.284"

rem Introduction
echo Hi, and welcome to GlassPatch, created by Beef#3980.
echo.
echo First, we'll need you to choose which variant of Discord you have.
echo.
echo If you're unaware, Discord has 4 versions publicly available; Stable (the one most people will have) PTB (useful as a backup client) and Canary (you'll use this if you have Powercord). The 4th version is Developer, and as far as I'm aware, no client-mods support it, so there's no support for Glasscord.
echo.
:discordvar
set /p discordvar=Type "s" for Stable, "p" for PTB and "c" for Canary: 
)
IF %discordvar%==s (
goto stable
)
IF %discordvar%==p (
goto ptb
)
IF %discordvar%==c (  
goto canary
)
) ELSE (
echo Sorry, but that wasn't a valid variant of Discord! Please type in one of the versions specified.
goto discordvar
)

:stable
IF EXIST %userprofile%\AppData\Roaming\discord\!stablever!\modules\discord_desktop_core\index.js (
echo !glasscord! > %userprofile%\AppData\Roaming\discord\!stablever!\modules\discord_desktop_core\index.js
echo !core! >> %userprofile%\AppData\Roaming\discord\!stablever!\modules\discord_desktop_core\index.js
taskkill /f /im Discord.exe
cd %userprofile%\AppData\Local\Discord\app-!stablever!
start Discord.exe
echo DEBUG: Launching Discord
goto done
) ELSE (
echo Stable was not found in its default location. Are you sure you have it installed?
goto discordvar
)

:ptb
IF EXIST %userprofile%\AppData\Roaming\discordptb\!ptbver!\modules\discord_desktop_core\index.js (
echo !glasscord! > %userprofile%\AppData\Roaming\discordptb\!ptbver!\modules\discord_desktop_core\index.js
echo !core! >> %userprofile%\AppData\Roaming\discordptb\!ptbver!\modules\discord_desktop_core\index.js
taskkill /f /im DiscordPTB.exe
cd %userprofile%\AppData\Local\DiscordPTB\app-!ptbver!
start DiscordPTB.exe
goto done
) ELSE (
echo PTB was not found in its default location. Are you sure you have it installed?
goto discordvar
)

:canary
IF EXIST %userprofile%\AppData\Roaming\discordcanary\!canaryver!\modules\discord_desktop_core\index.js (
echo !glasscord! > %userprofile%\AppData\Roaming\discordcanary\!canaryver!\modules\discord_desktop_core\index.js
echo !core! >> %userprofile%\AppData\Roaming\discordcanary\!canaryver!\modules\discord_desktop_core\index.js
taskkill /f /im DiscordCanary.exe
cd %userprofile%\AppData\Local\DiscordCanary\app-!canaryver!
start DiscordCanary.exe
echo DEBUG: Launching DiscordCanary
goto done
) ELSE (
echo Canary was not found in its default location. Are you sure you have it installed?
echo (We don't support Canary's beta, though it will be coming soon™, so if your Canary version is above !canaryver!, you will not be able to use this installer.)
goto discordvar
)

:done
echo.
echo DEBUG: We're done!
exit