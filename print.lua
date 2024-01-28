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

 ScriptName = args[1]

require "scripts.wrapperPlaneteRoliste"
-- require "scripts.PRscript"
-- pcall(require, 'scripts.wfrp4')
local ScriptPath = "scripts." .. ScriptName
if args[2] == 'minified' then
  ScriptPath = ScriptPath .. "-minified"
elseif args[2] == 'original' or args[2] == nil then
	ScriptPath = ScriptPath
else
	usageError()
end

print(ScriptPath)

pcall(require, ScriptPath .. "")

BodyResponse = [[
    <!DOCTYPE html><html><head><style>
    :root {
      --main-bg-color: #dedede;
      --alt-bg-color: #222;
      --alt2-bg-color: #cdcdcd;
      --alt3-bg-color: #888;
      --alt4-bg-color: #950101;
      --inner-font-size: 1rem;
      --inner-line-height: 1.2rem;
      --inner-font-family: -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
      --main-font-family: "Verdana", "Arial", "Helvetica", sans-serif;
      --main-font-size: 78%;
      --main-line-height: 120%;
      --light-bg-color: #ccc;
      --dark-bg-color: #222;
      --main-titlebar-bg-color: #bbb;
      --main-toolbar-bg-color: #333;
      --main-header-bg-color: #950101;
      --main-wrapper-bg-color: #f6f6f6;
      --alt-wrapper-bg-color: #f6f6f6;
      --main-private-bg-color: #eaeaea;
      --main-private-bg-image: repeating-linear-gradient(45deg, transparent, transparent 35px, rgba(255,255,255,.3) 35px, rgba(255,255,255,.3) 70px);
      --main-body-bg-color: #eee;
      --main-body-color: #000;
      --main-topictable-bg-color: transparent;
      --main-menu-color: #fff;
      --main-tablegrid-border: none;
      --alt-tablegrid-border: 1px solid rgba(128,128,128,0.15);
      --main-content-border: none;
      --alt2-windowbg-color: #cacdd3;
      --alt-hover-color: lightgray;
      --main-text-color: #111;
      --alt-text-color: #000;
      --alt2-text-color: #000;
      --alt3-text-color: #fff;
      --light-text-color: #fff;
      --dark-text-color: #222;
      --main-link-color: #109c16;
      --main-link-hover-color: #111;
      --alt-link-color: #0519ff;
      --alt2-link-color: gray;
      --alt3-link-color: #950101;
      --main-button-bg-color: #888;
      --hover-button-bg-color: #950101;
      --main-headers-color: rgb(85,85,85);
      --main-quote-color: #333;
      --main-quote-border-color: #666;
      --main-quote-bg-color: #d6d6d6;
      --alt-quote-bg-color: #a7a7a7;
      --alt-quote-border-color: #D0D0D0;
      --highlight-bg-color: silver;
      --std-post-box-shadow: 3px 3px 5px rgba(0,0,0,0.2);
      --new-post-box-shadow: 3px 3px 5px rgba(150,0,0,0.45);
      --alt-post-box-shadow: 3px 3px 5px rgba(0,0,0,0.6);
      --std-button-box-shadow: 3px 3px 5px rgba(0,0,0,0.2);
      --alt-button-box-shadow: 3px 3px 5px rgba(14,14,14,0.36);
      --std-icon-filter-drop-shadow: drop-shadow(3px 3px 3px #635d5d);
      --std-post-filter-drop-shadow: drop-shadow(3px 3px 3px rgba(0,0,0,0.2));
      --std-post-filter-drop-shadow: drop-shadow(0 10px 10px rgba(0,0,0,0.19)) drop-shadow(0 6px 3px rgba(0,0,0,0.23));
      --new-post-filter-drop-shadow: drop-shadow(3px 3px 3px rgba(150,0,0,0.45));
      --new-post-filter-drop-shadow: drop-shadow(0 10px 10px rgba(150,0,0,0.19)) drop-shadow(0 6px 3px rgba(150,0,0,0.23));
      --main-title-bg-color: transparent;
      --main-sticky-bg-color: #ccc;
      --alt-sticky-bg-color: rgba(50,100,200,0.1);
      --main-locked-bg-color: rgba(200,0,0,0.1);
      --main-speaker-bg-color: rgba(200,200,200,.75);
      --alt-speaker-bg-color: #777;
      --editable-bg-color: #d5f7c9;
      --rp-color-speak: #093;
      --rp-color-do: rgb(207,95,7);
      --rp-color-recount: orange;
      --rp-color-comm: green;
      --rp-color-yell: var(--main-text-color);
      --rp-color-whisper: var(--main-text-color);
      --rp-color-think: var(--main-text-color);
      --rp-color-ooc: rgb(168,3,45);
      --main-inner-text-color: var(--main-text-color);
      --logo-bg: url(../images/theme/planete_roliste_3.jpg);
      --header-bg: url(../images/theme/top_bg_5.jpg);
      --rollgen-bg-image: url(../images/rollgen-bg4.png);
      --logo-bg: url(/SMF/Themes/dark/images/theme/planete_roliste_3.jpg);
      --header-bg: url(/SMF/Themes/dark/images/theme/top_bg_5.jpg);
    }


    body {
      background: #323232;
      background: var(--main-bg-color);
      font: 78%/120% "Verdana", "Arial", "Helvetica", sans-serif;
      font-family: "Verdana", "Arial", "Helvetica", sans-serif;
      font-family: var(--main-font-family);
      font-size: 78%;
      font-size: var(--main-font-size);
      line-height: 120%;
      line-height: var(--main-line-height);
      margin: 0 auto;
      padding: 0px 0;
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
<link rel="stylesheet" href="https://www.planeteroliste.com/SMF/Themes/default/hs4smf/highslide.css?zog280" media="screen" onload="null;this.media='screen'"></head>

<style>
.rollgen_block {
    margin-top: 12px;
    margin-left: auto;
    margin-right: auto;
    width: 450px;
    padding-bottom: 5px;
    padding-left: 2px;
    font-size: 13px;
    background-color: black;
    color: white;
    font-family; "Verdana", "Arial", "Helvetica", sans-serif;
  }

  h1 {
    padding-top: 2em;
    font-size: 1.5rem;
    text-align: center;
  }
  code {
    width: 100vw;
    padding-top: 0.5em;
    font-size: 0.8rem;
    text-align: center;
    display: inline-block;
  }
  </style>
  </head>
  <body>
]]

-- Déclenchement du script xxx-caller correspondant.

print(pcall(require, "scripts." .. ScriptName .. "-caller"))


ExportFile = io.open ("result.html", "w+")
ExportFile:write(BodyResponse)

print("Le résultat du test est disponible dans le fichier result.html")