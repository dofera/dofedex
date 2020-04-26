class dofus.aks.Tutorial extends dofus.aks.Handler
{
	static var INTRO_CINEMATIC_PATH = dofus.Constants.CINEMATICS_PATH + "8.swf";
	static var INTRO_CINEMATIC_MAX_LEN = 120;
	static var INTRO_CINEMATIC_PATH_LIGHT = "";
	static var INTRO_CINEMATIC_MAX_LEN_LIGHT = 120;
	static var NOOB_AREA_MUSIC_ID = 129;
	function Tutorial(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function end(loc2, loc3, loc4)
	{
		if(loc2 == undefined)
		{
			loc2 = 0;
		}
		if(loc3 == undefined || loc4 == undefined)
		{
			this.aks.send("TV" + String(loc2),false);
		}
		else
		{
			this.aks.send("TV" + String(loc2) + "|" + String(loc3) + "|" + String(loc4),false);
		}
	}
	function onShowTip(loc2)
	{
		var loc3 = Number(loc2);
		this.api.kernel.TipsManager.showNewTip(loc3);
	}
	function onCreate(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = loc3[1];
		var loc6 = this.api.config.language;
		this.api.kernel.TutorialServersManager.loadTutorial(loc4 + "_" + loc5);
	}
	function onGameBegin()
	{
		var loc2 = new ank.utils.((!this.api.config.isStreaming?dofus.aks.Tutorial.INTRO_CINEMATIC_MAX_LEN:dofus.aks.Tutorial.INTRO_CINEMATIC_MAX_LEN_LIGHT) * 1000);
		dofus.aks.Tutorial.INTRO_CINEMATIC_PATH_LIGHT = dofus.Constants.CINEMATICS_PATH + "9_" + this.api.config.language + ".swf";
		loc2.addAction(false,this.api.sounds,this.api.sounds.stopAllSounds);
		if(!this.api.config.isStreaming)
		{
			loc2.addAction(true,this.api.ui,this.api.ui.loadUIComponent,["Cinematic","Cinematic",{file:(!this.api.config.isStreaming?dofus.aks.Tutorial.INTRO_CINEMATIC_PATH:dofus.aks.Tutorial.INTRO_CINEMATIC_PATH_LIGHT),sequencer:loc2},{bUltimateOnTop:true}]);
		}
		loc2.addAction(false,this.api.ui,this.api.ui.loadUIComponent,["AskGameBegin","AskGameBegin",undefined,{bAlwaysOnTop:true}]);
		loc2.addAction(false,this.api.sounds,this.api.sounds.playMusic,[dofus.aks.Tutorial.NOOB_AREA_MUSIC_ID,true]);
		this.addToQueue({object:loc2,method:loc2.execute,params:[true]});
	}
}
