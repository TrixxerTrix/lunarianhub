local templateurl = "https://raw.githubusercontent.com/TrixxerTrix/lunarianhub/games/%s"
local gameids = {
  [9203864304] = "raiseafloppa"
}

local gameId = game.PlaceId
if gameids[gameId] then
  loadstring(game:HttpGet(templateurl:format(gameids[gameId]))()
else game:GetService("Players").LocalPlayer:Kick("Game not found") end
