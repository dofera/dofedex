class dofus.aks.Tutorial extends dofus.aks.Handler
{
	static var INTRO_CINEMATIC_PATH = dofus.Constants.CINEMATICS_PATH + "8.swf";
	static var INTRO_CINEMATIC_MAX_LEN = 120;
	static var INTRO_CINEMATIC_PATH_LIGHT = "";
	static var INTRO_CINEMATIC_MAX_LEN_LIGHT = 120;
	static var NOOB_AREA_MUSIC_ID = 129;
	function Tutorial(var2, var3)
	{
		super.initialize(var3,var4);
	}
	function end(var2, var3, var4)
	{
		if(var2 == undefined)
		{
			var2 = 0;
		}
		if(var3 == undefined || var4 == undefined)
		{
			this.aks.send("TV" + String(var2),false);
		}
		else
		{
			this.aks.send("TV" + String(var2) + "|" + String(var3) + "|" + String(var4),false);
		}
	}
	function onShowTip(var2)
	{
		var var3 = Number(var2);
		this.api.kernel.TipsManager.showNewTip(var3);
	}
	function onCreate(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = var3[1];
		var var6 = this.api.config.language;
		this.api.kernel.TutorialServersManager.loadTutorial(var4 + "_" + var5);
	}
	function onGameBegin()
	{
		var var2 = new ank.utils.((!this.api.config.isStreaming?dofus.aks.Tutorial.INTRO_CINEMATIC_MAX_LEN:dofus.aks.Tutorial.INTRO_CINEMATIC_MAX_LEN_LIGHT) * 1000);
		dofus.aks.Tutorial.INTRO_CINEMATIC_PATH_LIGHT = dofus.Constants.CINEMATICS_PATH + "9_" + this.api.config.language + ".swf";
		var2.addAction(118,false,this.api.sounds,this.api.sounds.stopAllSounds);
		if(!this.api.config.isStreaming)
		{
			var2.addAction(119,true,this.api.ui,this.api.ui.loadUIComponent,["Cinematic","Cinematic",{file:(!this.api.config.isStreaming?dofus.aks.Tutorial.INTRO_CINEMATIC_PATH:dofus.aks.Tutorial.INTRO_CINEMATIC_PATH_LIGHT),sequencer:var2},{bUltimateOnTop:true}]);
		}
		var2.addAction(120,false,this.api.ui,this.api.ui.loadUIComponent,["AskGameBegin","AskGameBegin",undefined,{bAlwaysOnTop:true}]);
		var2.addAction(121,false,this.api.sounds,this.api.sounds.playMusic,[dofus.aks.Tutorial.NOOB_AREA_MUSIC_ID,true]);
		this.addToQueue({object:var2,method:var2.execute,params:[true]});
	}
}
