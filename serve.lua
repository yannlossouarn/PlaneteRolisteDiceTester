Pegasus = require 'pegasus'



Server = Pegasus:new({
  host='127.0.0.1',
  port='9090',
  location='/'
})



local function usageError()
	error(
			"\nusage: <script> minified or <script> beautified or <script> original\n" ..
			"  The PlaneteRoliste wrapper will load the corresponding script\n" ..
			"  either in its original form, or in its minified form :\n\n" ..
			"        lua5.4 serve.lua wfrp4 original\n\n" ..
			"  * original will use the original code.\n" ..
			"  * minified will use the minified file.\n", 0)
end

local args = {...}
if #args < 1 or #args > 2 or (#args == 2 and not (args[2] == "original" or args[2] == "minified")) then
	usageError()
end

--local sourceFile = io.open(args[2], 'r')
--if not sourceFile then
--	error("Could not open the input file `" .. args[2] .. "`", 0)
--end

local scriptName = args[1]




require "scripts.wrapperPlaneteRoliste"
-- require "scripts.PRscript"
-- pcall(require, 'scripts.wfrp4')
local scriptPath = "scripts." .. scriptName
if args[2] == 'minified' then
  scriptPath = scriptPath .. "-minified"
elseif args[2] == 'original' or args[2] == nil then
	scriptPath = scriptPath
else
	usageError()
end

print(scriptPath)

pcall(require, scriptPath .. "")

BodyResponse = [[
    <!DOCTYPE html><html><head><style>:root{
    --main-color1:;
    --main-color2:;
    --rp-test:light;
    --main-inner-text-color:#000000;
    --alpha-level:235;
    --color-transp:0.88;
    --rp-color-speak:#009933;
    --rp-color-do:#CF5F07;		
    --rp-color-recount:#AF6302;
    --rp-color-comm:#008000;
    --rp-color-yell:#000000;
    --rp-color-whisper:#000000;
    --rp-color-think:#000000;
    --rp-color-ooc:#A8032D;
}

div.inner{
}

span.rp_color_speak,span.rp_color_speak:before,span.rp_color_speak:after{
}

span.rp_color_do{
}

span.rp_color_recount{
}

span.rp_color_comm{
}

span.rp_action_yell{
font-size:18pt;}

span.rp_action_whisper{
font-size:7pt;}

span.rp_action_think{
}

span.rp_color_ooc{
}
#sp_center div.cat_bar,#sp_left div.cat_bar,#sp_right div.cat_bar,div#chardisplay li.active span.a_tab,div#activeDecks li.active span.a_tab,div#myTabs ul.mootabs_title.tabs li.active:before, div#accordion h3.toggler,div#chardisplay .tabs li.selected:before,div#chardisplay .tabs li.selected span{
        background-color: ;
    }

</style>
<link rel="stylesheet" href="https://www.planeteroliste.com/SMF/Themes/default/css/portal.css?zog280" media="all" onload="null;this.media='all'">
<link rel="stylesheet" href="https://www.planeteroliste.com/SMF/Themes/dark/css/roliste.css?zog280" media="all" onload="null;this.media='all'">
<link rel="stylesheet" href="https://www.planeteroliste.com/SMF/Themes/dark/css/pretty-checkbox.css?zog280" media="all" onload="null;this.media='all'">
<link rel="stylesheet" href="https://www.planeteroliste.com/SMF/Themes/dark/css/jquery.ui.css?zog280" media="all" onload="null;this.media='all'">
<link rel="stylesheet" href="https://www.planeteroliste.com/SMF/Themes/dark/css/roliste-extra.css?zog280" media="all" onload="null;this.media='all'">	
<link rel="stylesheet" href="https://www.planeteroliste.com/SMF/Themes/dark/css/select2.css?zog280" media="all" onload="null;this.media='all'">
<link rel="stylesheet" href="https://www.planeteroliste.com/SMF/Themes/default/hs4smf/highslide.css?zog280" media="screen" onload="null;this.media='screen'"></head><body style="background-color: #333; color: white">

<style>
.rollgen_block {
    margin-top: 12px;
    margin-left: auto;
    margin-right: auto;
    width: 450px;
    padding: 12px;
    font-size: 13px;
    background-color: black;
  }

  h1 {
    padding-top: 2em;
    font-size: 1.5rem;
    text-align: center;
  }
  code {
    width: 100vw;
    padding-top: 0.5em;
    font-size: 1.2rem;
    text-align: center;
    display: inline-block;
  }
  </style>
  </head>
  <body>
]]

-- Déclenchement du script xxx-caller correspondant.

pcall(require, "scripts." .. scriptName .. "-caller")

print(string.format("\n\nVotre page de test est disponible sur http://%s:%s%s\n", Server.host, Server.port, Server.location))

print("Appuyez deux fois sur Ctrl+C pour fermer le serveur et retrouver l'invite de commande.\n\n\n\n")


Server:start(function (req, rep)
    rep:addHeader('Content-Type', 'text/html; charset=utf-8')
    rep:write(BodyResponse)
  end)

