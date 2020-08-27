class dofus.utils.DofusConfiguration
{
	var _bIsStreaming = false;
	function DofusConfiguration()
	{
		if(_global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME] == undefined)
		{
			_global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME] = ank.utils.SharedObjectFix.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
		}
	}
	function __set__dataServers(var2)
	{
		this._aDataServers = var2;
		return this.__get__dataServers();
	}
	function __get__dataServers()
	{
		return this._aDataServers;
	}
	function __set__language(var2)
	{
		var var3 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
		var3.data.language = var2;
		var3.flush();
		return this.__get__language();
	}
	function __get__language()
	{
		var var2 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.language;
		if(var2 == undefined || (var2 == "undefined" || _root.htmlLang != undefined))
		{
			if(_root.htmlLang != undefined)
			{
				var var3 = _root.htmlLang;
			}
			else
			{
				var3 = System.capabilities.language;
			}
			switch(var3)
			{
				default:
					switch(null)
					{
						default:
							if(var0 !== "it")
							{
								return "en";
							}
							break;
						case "pt":
						case "ru":
						case "nl":
						case "es":
					}
					break;
				case "fr":
				case "en":
				case "de":
			}
			return var3;
		}
		return var2.toLowerCase();
	}
	function __set__languages(var2)
	{
		this._aLanguages = var2;
		return this.__get__languages();
	}
	function __get__languages()
	{
		var var2 = new Array();
		if(this._aXmlLanguages != undefined)
		{
			var var3 = 0;
			while(var3 < this._aXmlLanguages.length)
			{
				var2.push(this._aXmlLanguages[var3]);
				var3 = var3 + 1;
			}
		}
		if(this._aLanguages != undefined)
		{
			var var4 = 0;
			while(var4 < this._aLanguages.length)
			{
				var var5 = false;
				var var6 = 0;
				while(var6 < this._aXmlLanguages.length)
				{
					if(this._aXmlLanguages[var6] == this._aLanguages[var4])
					{
						var5 = true;
					}
					var6 = var6 + 1;
				}
				if(!var5)
				{
					var2.push(this._aLanguages[var4]);
				}
				var4 = var4 + 1;
			}
		}
		return var2;
	}
	function __set__xmlLanguages(var2)
	{
		this._aXmlLanguages = var2;
		return this.__get__xmlLanguages();
	}
	function __get__xmlLanguages()
	{
		return this._aXmlLanguages;
	}
	function __set__skipLanguageVerification(var2)
	{
		this._bSkipLanguageVerification = var2;
		return this.__get__skipLanguageVerification();
	}
	function __get__skipLanguageVerification()
	{
		return this._bSkipLanguageVerification;
	}
	function __set__cacheAsBitmap(var2)
	{
		this._aCacheAsBitmap = var2;
		return this.__get__cacheAsBitmap();
	}
	function __get__cacheAsBitmap()
	{
		return this._aCacheAsBitmap;
	}
	function __set__isExpo(var2)
	{
		this._bIsExpo = var2;
		return this.__get__isExpo();
	}
	function __get__isExpo()
	{
		return this._bIsExpo;
	}
	function __set__isStreaming(var2)
	{
		this._bIsStreaming = var2;
		return this.__get__isStreaming();
	}
	function __get__isStreaming()
	{
		return this._bIsStreaming;
	}
	function __set__streamingMethod(var2)
	{
		this._sStreamingMethod = var2;
		return this.__get__streamingMethod();
	}
	function __get__streamingMethod()
	{
		return this._sStreamingMethod;
	}
	function __get__isLinux()
	{
		return String(System.capabilities.version).indexOf("LNX") > -1;
	}
	function __get__isWindows()
	{
		return String(System.capabilities.version).indexOf("WIN") > -1;
	}
	function __get__isMac()
	{
		return String(System.capabilities.version).indexOf("MAC") > -1;
	}
	function getCustomIP(var2)
	{
		return this.customServersIP[var2];
	}
}
