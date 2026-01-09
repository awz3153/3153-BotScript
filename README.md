# 3153-BotScript
Yeah use it to advertise

Here's the script: (change phrases as needed or fiddle with the thing ingame idfk)
```lua
getgenv().BotConfig = {
    DefaultPhrases = {
        {
            "The Void Cult is the best! /GsDRVhHjPN!",
            "/GsDRVhHjPN on blue to join the Void Cult Cut Haven!",
            "in order to join the Void Cult server -> /GsDRVhHjPN",
            "/GsDRVhHjPN. Do you want to draw blood for Noli?",
            "The void cult accepts all /GsDRVhHjPN. Praise Noli!",
            "Noli is the only real true god! /GsDRVhHjPN",
            "awz_3d on blue to join our VoidCult community",
            "Join Void Cult Today! /GsDRVhHjPN",
            "This is for my Doggy! Don't threaten me! /GsDRVhHjPN",
            "To join the Void cult you can use this! -> /GsDRVhHjPN",
            "Praise Noli! /GsDRVhHjPN",
            "Noli is the only true and real god. Draw Blood for Noli. /GsDRVhHjPN",
        }
    }
}

getgenv().Blacklist = {
    blacklistt = {
        {
            942653597, --dans diner admins, feel free to customize to whatever userid's u want
            879676591,
            857518801,
            1335534276,
            1335528478,
            8191356826,
            1574588618,
            1717851749,
            2808984456,
            545818648,
            743384709,
            90406139,
            3690849901,
            1285859230,
            1577718065,
            583178932,
            347895335,
            678233755,
            484566334,
            159016709,
            1982232439,
			327553725
        }
    }
}


loadstring(game:HttpGet("https://raw.githubusercontent.com/awz3153/3153-BotScript/refs/heads/main/3153-BOT.lua"))()
```

Anti-AFK version:
```lua
local function tio()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))();
end

local function awz()
    getgenv().BotConfig = {
        DefaultPhrases = {
           {
            "The Void Cult is the best! /GsDRVhHjPN!",
            "/GsDRVhHjPN on blue to join the Void Cult Cut Haven!",
            "in order to join the Void Cult server -> /GsDRVhHjPN",
            "/GsDRVhHjPN. Do you want to draw blood for Noli?",
            "The void cult accepts all /GsDRVhHjPN. Praise Noli!",
            "Noli is the only real true god! /GsDRVhHjPN",
            "awz_3d on blue to join our VoidCult community",
            "Join Void Cult Today! /GsDRVhHjPN",
            "This is for my Doggy! Don't threaten me! /GsDRVhHjPN",
            "To join the Void cult you can use this! -> /GsDRVhHjPN",
            "Praise Noli! /GsDRVhHjPN",
            "Noli is the only true and real god. Draw Blood for Noli. /GsDRVhHjPN",
        }
        }
    }

    getgenv().Blacklist = {
        blacklistt = {
            {
                942653597, --dans diner admins, feel free to customize to whatever userid's u want
                879676591,
                857518801,
                1335534276,
                1335528478,
                8191356826,
                1574588618,
                1717851749,
                2808984456,
                545818648,
                743384709,
                90406139,
                3690849901,
                1285859230,
                1577718065,
                583178932,
                347895335,
                678233755,
                484566334,
                159016709,
                1982232439,
                327553725
            }
        }
    }
    loadstring(game:HttpGet("https://raw.githubusercontent.com/awz3153/3153-BotScript/refs/heads/main/3153-BOT.lua"))()
end

task.spawn(tio)
task.spawn(awz)
```
