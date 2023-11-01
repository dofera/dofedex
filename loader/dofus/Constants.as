class dofus.Constants extends Object
{
	static var XML_LOADING_BANNERS_PATH = "loadingbanners.xml";
	static var LOADING_BANNERS_PATH = "loadingbanners/";
	static var MAP_TRIGGER_LAYEROBJECTS = [1030,1029,4088];
	static var MAP_UNWALKABLE_LAYEROBJECTS = [7020];
	static var DEBUG = false;
	static var DEBUG_DATAS = false;
	static var LOG_DATAS = false;
	static var DEBUG_ENCRYPTION = false;
	static var TEST = false;
	static var DOUBLEFRAMERATE = _global.DOUBLEFRAMERATE;
	static var USE_JS_LOG = false;
	static var USING_PACKED_SOUNDS = true;
	static var USING_UNPACKED_OBJECTS = true;
	static var SAVING_THE_WORLD = false;
	static var VERSION = 1;
	static var SUBVERSION = 34;
	static var SUBSUBVERSION = 1;
	static var BETAVERSION = 0;
	static var ALPHA = false;
	static var VERSIONDATE = "14/12/2020 11:37 GMT+1";
	static var LANG_SHAREDOBJECT_NAME = "ANKLANGSO";
	static var XTRA_SHAREDOBJECT_NAME = "ANKXTRASO";
	static var OPTIONS_SHAREDOBJECT_NAME = "ANKOPTIONSSO";
	static var GLOBAL_SO_LANG_NAME = "SHARED_OBJECT_LANG";
	static var GLOBAL_SO_XTRA_NAME = "SHARED_OBJECT_XTRA";
	static var GLOBAL_SO_OPTIONS_NAME = "SHARED_OBJECT_OPTIONS";
	static var GLOBAL_SO_SHORTCUTS_NAME = "SHARED_OBJECT_SHORTCUTS";
	static var GLOBAL_SO_OCCURENCES_NAME = "SHARED_OBJECT_OCCURENCES";
	static var GLOBAL_SO_TIPS_NAME = "SHARED_OBJECT_TIPS";
	static var GLOBAL_SO_IDENTITY_NAME = "SHARED_OBJECT_IDENTITY";
	static var GLOBAL_SO_DISPLAYS_NAME = "SHARED_OBJECT_DISPLAYS";
	static var GLOBAL_SO_CACHEDATE_NAME = "SHARED_OBJECT_CACHEDATE";
	static var CLIPS_PATH = "clips/";
	static var AUDIO_PATH = "audio/";
	static var MODULE_PATH = "modules/";
	static var STYLES_PATH = "styles/";
	static var GFX_ROOT_PATH = dofus.Constants.CLIPS_PATH + "gfx/";
	static var GFX_OBJECTS_PATH = dofus.Constants.GFX_ROOT_PATH + "objects/";
	static var GFX_GROUNDS_PATH = dofus.Constants.GFX_ROOT_PATH + "grounds/";
	static var CLIPS_PERSOS_PATH = dofus.Constants.CLIPS_PATH + "sprites/";
	static var ACCESSORIES_PATH = dofus.Constants.CLIPS_PERSOS_PATH + "accessories/";
	static var CHEVAUCHOR_PATH = dofus.Constants.CLIPS_PERSOS_PATH + "chevauchor/";
	static var SPELLS_PATH = dofus.Constants.CLIPS_PATH + "spells/";
	static var SPELLS_ICONS_PATH = dofus.Constants.SPELLS_PATH + "icons/";
	static var ITEMS_PATH = dofus.Constants.CLIPS_PATH + "items/";
	static var JOBS_ICONS_PATH = dofus.Constants.CLIPS_PATH + "jobs/";
	static var ARTWORKS_PATH = dofus.Constants.CLIPS_PATH + "artworks/";
	static var ILLU_PATH = dofus.Constants.ARTWORKS_PATH + "illu/";
	static var CARDS_PATH = dofus.Constants.CLIPS_PATH + "cards/";
	static var FIGHT_CHALLENGE_PATH = dofus.Constants.CLIPS_PATH + "challenges/";
	static var ALIGNMENTS_PATH = dofus.Constants.CLIPS_PATH + "alignments/";
	static var ALIGNMENTS_MINI_PATH = dofus.Constants.ALIGNMENTS_PATH + "mini/";
	static var ORDERS_PATH = dofus.Constants.ALIGNMENTS_PATH + "orders/";
	static var FEATS_PATH = dofus.Constants.ALIGNMENTS_PATH + "feats/";
	static var GUILDS_MINI_PATH = dofus.Constants.ARTWORKS_PATH + "mini/";
	static var GUILDS_FACES_PATH = dofus.Constants.ARTWORKS_PATH + "faces/";
	static var GUILDS_BIG_PATH = dofus.Constants.ARTWORKS_PATH + "big/";
	static var ARTWORKS_BIG_PATH = dofus.Constants.ARTWORKS_PATH + "big/";
	static var GUILDS_SYMBOL_PATH = dofus.Constants.ARTWORKS_PATH + "symbols/";
	static var SERVER_SYMBOL_PATH = dofus.Constants.ARTWORKS_PATH + "servers/";
	static var BREEDS_SYMBOL_PATH = dofus.Constants.ARTWORKS_PATH + "breeds/";
	static var BREEDS_SLIDER_PATH = dofus.Constants.BREEDS_SYMBOL_PATH + "slide/";
	static var BREEDS_BACK_PATH = dofus.Constants.BREEDS_SYMBOL_PATH + "back/";
	static var CINEMATICS_PATH = dofus.Constants.CLIPS_PATH + "cinematics/";
	static var SMILEYS_ICONS_PATH = dofus.Constants.CLIPS_PATH + "smileys/";
	static var EMOTES_ICONS_PATH = dofus.Constants.CLIPS_PATH + "emotes/";
	static var AURA_PATH = dofus.Constants.CLIPS_PATH + "auras/";
	static var EMBLEMS_BACK_PATH = dofus.Constants.CLIPS_PATH + "emblems/back/";
	static var EMBLEMS_UP_PATH = dofus.Constants.CLIPS_PATH + "emblems/up/";
	static var LOCAL_MAPS_PATH = dofus.Constants.CLIPS_PATH + "maps/";
	static var EXTRA_PATH = dofus.Constants.CLIPS_PATH + "extra/";
	static var GIFTS_PATH = dofus.Constants.CLIPS_PATH + "gifts/";
	static var XML_SPRITE_LIST = dofus.Constants.CLIPS_PERSOS_PATH + "sprites.xml";
	static var SOUND_EFFECTS_PACKAGE = dofus.Constants.AUDIO_PATH + "effects.swf";
	static var SOUND_MUSICS_PACKAGE = dofus.Constants.AUDIO_PATH + "musics.swf";
	static var XML_ADMIN_MENU_PATH = "menuadmin.xml";
	static var XML_ADMIN_RIGHT_CLICK_MENU_PATH = "rc-menuadmin.xml";
	static var MODULE_CORE = "core.swf";
	static var MODULE_SOUNDS = "soma.swf";
	static var MODULE_CORE_FILE = dofus.Constants.MODULE_PATH + dofus.Constants.MODULE_CORE;
	static var MODULE_SOUNDS_FILE = dofus.Constants.MODULE_PATH + dofus.Constants.MODULE_SOUNDS;
	static var MODULES_LIST = [[dofus.Constants.MODULE_CORE,dofus.Constants.MODULE_CORE_FILE,1,false,"CORE"]];
	static var CONFIG_XML_FILE = "config.xml";
	static var GROUND_FILE = dofus.Constants.CLIPS_PATH + "ground.swf";
	static var OBJECTS_FILE = dofus.Constants.CLIPS_PATH + "objects.swf";
	static var OBJECTS_LIGHT_FILE = dofus.Constants.CLIPS_PATH + "cells.swf";
	static var CIRCLE_FILE = dofus.Constants.CLIPS_PATH + "circle.swf";
	static var EFFECTSICON_FILE = dofus.Constants.CLIPS_PATH + "effectsicons.swf";
	static var SMILEY_FILE = dofus.Constants.CLIPS_PATH + "smileys.swf";
	static var DEMON_ANGEL_FILE = dofus.Constants.CLIPS_PATH + "demonangel.swf";
	static var FALLEN_DEMON_ANGEL_FILE = dofus.Constants.CLIPS_PATH + "fallenDemonAngel.swf";
	static var DEFAULT_CC_ICON_FILE = dofus.Constants.CLIPS_PATH + "defaultcc.swf";
	static var READY_FILE = dofus.Constants.CLIPS_PATH + "ready.swf";
	static var BOOK_FILE = dofus.Constants.CLIPS_PATH + "book.swf";
	static var FORBIDDEN_FILE = dofus.Constants.CLIPS_PATH + "forbidden.swf";
	static var FORBIDDEN_CELL_FILE = dofus.Constants.CLIPS_PATH + "forbiddenCell.swf";
	static var DEFAULT_GIFT_FILE = dofus.Constants.CLIPS_PATH + "gift.swf";
	static var MAP_HINTS_FILE = dofus.Constants.LOCAL_MAPS_PATH + "hints.swf";
	static var MAP_DUNGEON_FILE = dofus.Constants.LOCAL_MAPS_PATH + "dungeon.swf";
	static var MAP_DUNGEON_HINTS_FILE = dofus.Constants.LOCAL_MAPS_PATH + "dungeonHints.swf";
	static var CRITICAL_HIT_XTRA_FILE = dofus.Constants.EXTRA_PATH + "5.swf";
	static var CRITICAL_HIT_DURATION = 5000;
	static var AUDIO_MUSICS_PATH = dofus.Constants.AUDIO_PATH + "musics/";
	static var AUDIO_EFFECTS_PATH = dofus.Constants.AUDIO_PATH + "effects/";
	static var AUDIO_ENVIRONMENT_PATH = dofus.Constants.AUDIO_PATH + "environments/";
	static var AUDIO_BACKGROUND_PATH = dofus.Constants.AUDIO_ENVIRONMENT_PATH + "backgrounds/";
	static var AUDIO_NOISE_PATH = dofus.Constants.AUDIO_ENVIRONMENT_PATH + "noises/";
	static var CHALLENGE_CLIP_FILE_NORMAL = dofus.Constants.CLIPS_PERSOS_PATH + "0.swf";
	static var CHALLENGE_CLIP_FILE_ANGEL = dofus.Constants.CLIPS_PERSOS_PATH + "1.swf";
	static var CHALLENGE_CLIP_FILE_DEMON = dofus.Constants.CLIPS_PERSOS_PATH + "2.swf";
	static var CHALLENGE_CLIP_FILE_MONSTER = dofus.Constants.CLIPS_PERSOS_PATH + "3.swf";
	static var CHALLENGE_CLIP_FILE_TAXCOLLECTOR = dofus.Constants.CLIPS_PERSOS_PATH + "4.swf";
	static var CHALLENGE_CLIP_FILE_TAXCOLLECTOR_ATTACKERS = dofus.Constants.CLIPS_PERSOS_PATH + "5.swf";
	static var LANG_LOCAL_FILE_LIST = "lang/versions.swf";
	static var HTTP_LANG_PATH = "lang/";
	static var HTTP_LANG_SWF_PATH = dofus.Constants.HTTP_LANG_PATH + "swf/";
	static var HTTP_CHECK_XTRA_FILE_NAME = "checkxtra.php";
	static var HTTP_XTRA_FILE_NAME = "getxtra.php";
	static var HTTP_LANG_FILE = dofus.Constants.HTTP_LANG_PATH + "getlang.php";
	static var HTTP_LANG_FILE_SWF = dofus.Constants.HTTP_LANG_SWF_PATH + "lang_#1.swf";
	static var HTTP_CHECK_XTRA_FILE = dofus.Constants.HTTP_LANG_PATH + dofus.Constants.HTTP_CHECK_XTRA_FILE_NAME;
	static var HTTP_XTRA_FILE = dofus.Constants.HTTP_LANG_PATH + dofus.Constants.HTTP_XTRA_FILE_NAME;
	static var HTTP_XTRA_FILE_SWF = dofus.Constants.HTTP_LANG_SWF_PATH + "xtra_#1.swf";
	static var HTTP_ALERT_PATH = "login/xml/";
	static var HTTP_ALERT_FILE = "alert.xml";
	static var AVERAGE_FRAMES_PER_SECOND = 15;
	static var CLICK_MIN_DELAY = 800;
	static var SEQUENCER_TIMEOUT = 10000;
	static var MAX_DATA_LENGTH = 1000;
	static var MAX_MESSAGE_LENGTH = 200;
	static var MAX_MESSAGE_LENGTH_MARGIN = 50;
	static var OCCURENCE_REFRESH = 9000;
	static var MAX_OCCURENCE_DELAY = 10000;
	static var GUILD_ORDER = [6,7,8,9,1,11,10,2,3,4,5,12];
	static var PAYING_GUILD = [false,false,false,false,false,false,false,false,false,false,false,true];
	static var EPISODIC_GUILD = [1,1,1,1,1,1,1,1,1,1,1,18];
	static var BREED_SKIN_INDEXES = [[0,3,0,3,0,3,3,0,0,2,3,0],[0,3,0,3,0,3,3,0,0,3,3,0]];
	static var BREED_SKIN_BASE_COLOR = [[0,15648155,0,15854274,0,16446963,14129488,0,0,9656642,16634268,0],[0,15516310,0,16701093,0,16640204,15648155,0,0,10247750,16764573,0]];
	static var SMILEY_DELAY = 3000;
	static var EMOTE_CHAR = "*";
	static var INFO_CHAT_COLOR = "009900";
	static var MSG_CHAT_COLOR = "111111";
	static var EMOTE_CHAT_COLOR = "222222";
	static var THINK_CHAT_COLOR = "232323";
	static var MSGCHUCHOTE_CHAT_COLOR = "0066FF";
	static var GROUP_CHAT_COLOR = "006699";
	static var ERROR_CHAT_COLOR = "C10000";
	static var GUILD_CHAT_COLOR = "663399";
	static var PVP_CHAT_COLOR = "DD7700";
	static var RECRUITMENT_CHAT_COLOR = "737373";
	static var TRADE_CHAT_COLOR = "663300";
	static var MEETIC_CHAT_COLOR = "0000CC";
	static var ADMIN_CHAT_COLOR = "FF00FF";
	static var COMMANDS_CHAT_COLOR = "E4287C";
	static var CELL_PATH_COLOR = 16737792;
	static var CELL_PATH_OVER_COLOR = 16737792;
	static var CELL_PATH_USED_COLOR = 2385558;
	static var CELL_PATH_SELECT_COLOR = 2385558;
	static var CELL_SPELL_EFFECT_COLOR = 16737792;
	static var CELL_SPELL_RANGE_COLOR = 2385558;
	static var CELL_MOVE_RANGE_COLOR = 39168;
	static var LIFE_POINT_COLOR = 16711680;
	static var ACTION_POINT_COLOR = 255;
	static var MAP_CURRENT_POSITION = 16711680;
	static var MAP_WAYPOINT_POSITION = 255;
	static var OVERHEAD_TEXT_CHARACTER = 16777215;
	static var OVERHEAD_TEXT_OTHER = 16777113;
	static var OVERHEAD_TEXT_TITLE = 16777215;
	static var FLAG_MAP_SEEK = 13434624;
	static var FLAG_MAP_GROUP = 26265;
	static var FLAG_MAP_PHOENIX = 16711680;
	static var FLAG_MAP_OTHERS = 16711680;
	static var TEAMS_COLOR = [16711680,255];
	static var AREA_ALIGNMENT_COLOR = [65280,65535,16711680];
	static var AREA_NO_ALIGNMENT_COLOR = 16777113;
	static var NPC_ALIGNMENT_COLOR = [6750105,65535,16737894];
	static var NIGHT_COLOR = {ra:38,rb:0,ga:38,gb:0,ba:60,bb:0};
	static var DIFFICULTY_COLOR_0 = 65280;
	static var DIFFICULTY_COLOR_1 = 16777215;
	static var DIFFICULTY_COLOR_2 = 16711680;
	static var NOVICE_LEVEL = 5;
	static var PLAYER_LEVEL_FOR_BOOST_SPELL_LEVEL_6 = 100;
	static var SPELL_BOOST_MAX_LEVEL = 6;
	static var SPELL_BOOST_BONUS = [0,1,2,3,4,5];
	static var MAX_PLAYERS_IN_TEAM = 8;
	static var MAX_PLAYERS_IN_CHALLENGE = 16;
	static var MEMBERS_COUNT_IN_PARTY = 8;
	static var UPDATER_PORT = 4583;
	static var UPDATER_CONNECTION_TRY_DELAY = 500;
	static var MAX_UPDATER_CONNECTION_TRY = 5;
	static var EMBLEM_BACKS_COUNT = 17;
	static var EMBLEM_UPS_COUNT = 104;
	static var SELECT_MULTIPLE_ITEMS_KEY = Key.CONTROL;
	static var CHAT_INSERT_ITEM_KEY = Key.SHIFT;
	static var DELAYED_INVENTORY_ITEMS_VISUAL_REFRESH = 50;
	static var DELAYED_CHAT_VISUAL_REFRESH = 50;
	static var DELAYED_DEBUG_CONSOLE_VISUAL_REFRESH = 50;
	static var INTERFACES_MANIPULATING_ITEMS = ["Storage","PlayerShop","BigStoreSell","NpcShop","PlayerShopModifier","TaxCollectorStorage","Inventory","Craft","Exchange","ForgemagusCraft","SecureCraft"];
	function Constants()
	{
		super();
	}
	static function __get__ZONE_COLOR()
	{
		return dofus.utils.Api.getInstance().lang.getConfigText("ZONE_COLOR");
	}
	static function isItemSuperTypeSkinable(var2)
	{
		switch(var2)
		{
			case 10:
			case 11:
			case 2:
			case 7:
				return true;
			default:
				return false;
		}
	}
	static function getTeamFileFromType(var2, var3)
	{
		switch(var2)
		{
			case 0:
				if(var3 == 1)
				{
					var var4 = dofus.Constants.CHALLENGE_CLIP_FILE_ANGEL;
				}
				else if(var3 == 2)
				{
					var4 = dofus.Constants.CHALLENGE_CLIP_FILE_DEMON;
				}
				else
				{
					var4 = dofus.Constants.CHALLENGE_CLIP_FILE_NORMAL;
				}
				break;
			case 1:
				if(var3 == 1)
				{
					var4 = dofus.Constants.CHALLENGE_CLIP_FILE_ANGEL;
				}
				else if(var3 == 2)
				{
					var4 = dofus.Constants.CHALLENGE_CLIP_FILE_DEMON;
				}
				else
				{
					var4 = dofus.Constants.CHALLENGE_CLIP_FILE_MONSTER;
				}
				break;
			case 2:
				var4 = dofus.Constants.CHALLENGE_CLIP_FILE_NORMAL;
				break;
			case 3:
				var4 = dofus.Constants.CHALLENGE_CLIP_FILE_TAXCOLLECTOR;
		}
		return var4;
	}
	static function getElementColorById(var2)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		switch(var2)
		{
			case 0:
				return "7D7D7D";
			case 1:
				return "AB5703";
			case 2:
				return "FF0000";
			case 3:
				return "1F8EFE";
			case 4:
				return "4FB24F";
			default:
				return undefined;
		}
	}
}
