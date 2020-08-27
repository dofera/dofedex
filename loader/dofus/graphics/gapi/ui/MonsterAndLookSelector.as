class dofus.graphics.gapi.ui.MonsterAndLookSelector extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MonsterAndLookSelector";
	static var ANIM_LIST = ["static","walk","run","hit","bonus","anim0","anim1","anim2","anim3","anim4","anim5","anim6","anim7","anim8","anim9","anim10","anim11","anim12","anim12","anim13","anim14","anim15","anim16","anim17","anim18","anim111","anim112","anim113","anim114","anim115","anim116","anim117","emote1","emote2","emote3","emote4","emote5","emote6","emote7","emote8","emote9","emote10","emote11","emote12","emote13","emote14","emote15","emote16","emote17","emote18","emote19","emote20","emote21","emoteStatic1","emoteStatic14","emoteStatic15","emoteStatic16","emoteStatic19","emoteStatic20","emoteStatic21","die"];
	function MonsterAndLookSelector()
	{
		super();
	}
	function __set__monster(var2)
	{
		this._bMonster = var2;
		return this.__get__monster();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.MonsterAndLookSelector.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initAnimList});
		if(this._bMonster)
		{
			this.addToQueue({object:this,method:this.loadMonsters});
		}
		else
		{
			this.addToQueue({object:this,method:this.loadLooks});
		}
	}
	function initTexts()
	{
		if(this._bMonster)
		{
			this._winBg.title = "Liste des monstres";
		}
		else
		{
			this._winBg.title = "Liste des look";
		}
		this._lblType.text = this.api.lang.getText("TYPE");
		this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		this._btnSelect.label = this.api.lang.getText("SELECT");
		this._btnSearch.label = this.api.lang.getText("OK");
		this._tiSearch.text = !this._tiSearch.text.length?"Recherche...":this._tiSearch.text;
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnCancel.addEventListener("click",this);
		this._btnSelect.addEventListener("click",this);
		this._cbType.addEventListener("itemSelected",this);
		this._cbAnim.addEventListener("itemSelected",this);
		this._cg.addEventListener("selectItem",this);
		this._cg.addEventListener("overItem",this);
		this._cg.addEventListener("outItem",this);
		this._cg.addEventListener("dblClickItem",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		this._btnSearch.addEventListener("click",this);
		var ref = this;
		var var2 = new Object();
		var2.onSetFocus = function(var2, var3)
		{
			if(eval(Selection.getFocus())._parent == ref._tiSearch)
			{
				if(ref._tiSearch.text == "Recherche...")
				{
					ref._tiSearch.text = "";
				}
			}
			else if(ref._tiSearch.text == "")
			{
				ref._tiSearch.text = "Recherche...";
			}
		};
		Selection.addListener(var2);
	}
	function initAnimList(var2)
	{
		var var3 = new ank.utils.();
		var var4 = 0;
		while(var4 < dofus.graphics.gapi.ui.MonsterAndLookSelector.ANIM_LIST.length)
		{
			var3.push({label:dofus.graphics.gapi.ui.MonsterAndLookSelector.ANIM_LIST[var4]});
			var4 = var4 + 1;
		}
		this._cbAnim.dataProvider = var3;
	}
	function initData(var2)
	{
		this._cciSprite.deleteButton = false;
		this._eaTypes = var2;
		var2.sortOn("label");
		this._cbType.dataProvider = var2;
	}
	function loadLooks()
	{
		var ui = this;
		var var2 = new XML();
		var2.ignoreWhite = true;
		var2.onLoad = function()
		{
			var var2 = dofus.Constants.ARTWORKS_BIG_PATH;
			var var3 = new ank.utils.();
			var var4 = new ank.utils.();
			var var5 = this.firstChild.firstChild;
			while(var5 != undefined)
			{
				var var6 = var5.attributes.name;
				var var7 = new ank.utils.();
				var var8 = var5.firstChild;
				while(var8 != undefined)
				{
					var var9 = var8.attributes.id;
					var var10 = var8.attributes.name;
					var var11 = {iconFile:var2 + var9 + ".swf",name:var10,id:var9,gfxId:var9};
					var7.push(var11);
					var4.push(var11);
					var8 = var8.nextSibling;
				}
				var3.push({label:var6,data:var7});
				var5 = var5.nextSibling;
			}
			var3.push({label:"-- ALL --",data:var4});
			ui.initData(var3);
		};
		var2.load(dofus.Constants.XML_SPRITE_LIST);
	}
	function loadMonsters(var2)
	{
		if(var2 == undefined)
		{
			var2 = "";
		}
		var var3 = this.api.lang.getMonsters();
		var var4 = dofus.Constants.ARTWORKS_BIG_PATH;
		var var5 = new ank.utils.();
		var var6 = new ank.utils.();
		var var7 = new Object();
		for(var a in var3)
		{
			var var8 = var3[a];
			var var9 = var8.b;
			var var10 = var7[var9];
			if(var10 == undefined)
			{
				var10 = {label:this.api.lang.getMonstersRaceText(var9).n,data:new ank.utils.()};
				var7[var9] = var10;
				var5.push(var10);
			}
			var var11 = a;
			var var12 = var8.n;
			var var13 = var8.g;
			var var14 = {iconFile:var4 + var13 + ".swf",name:var12,id:var11,gfxId:var13};
			var6.push(var14);
			var10.data.push(var14);
		}
		var5.push({label:"-- ALL --",data:var6});
		this.initData(var5);
	}
	function select(var2)
	{
		var var3 = var2.target.contentData;
		if(var3 != undefined)
		{
			if(this._bMonster)
			{
				this.dispatchEvent({type:"select",ui:"MonsterSelector",monsterId:var3.id});
			}
			else
			{
				this.dispatchEvent({type:"select",ui:"LookSelector",lookId:var3.id});
			}
			this.callClose();
		}
	}
	function filterResult(var2)
	{
		var var3 = this._cbType.selectedItem.data;
		var var4 = new ank.utils.();
		var var5 = 0;
		while(var5 < var3.length)
		{
			var var6 = var3[var5].name;
			if(!(var2.length && (var2 != "Recherche..." && (var2.length && var6.toUpperCase().indexOf(var2.toUpperCase()) == -1))))
			{
				var4.push(var3[var5]);
			}
			var5 = var5 + 1;
		}
		this._cg.dataProvider = var4;
	}
	function click(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			case "_btnClose":
			case "_btnCancel":
				this.dispatchEvent({type:"cancel"});
				this.callClose();
				break;
			default:
				switch(null)
				{
					case "_btnSelect":
						break loop0;
					case "_btnSearch":
						this._cbType.selectedIndex = 0;
						this.filterResult(this._tiSearch.text);
				}
		}
		this.select({target:this._cg.selectedItem});
	}
	function dblClickItem(var2)
	{
		this.select(var2);
	}
	function selectItem(var2)
	{
		var var3 = var2.target.contentData;
		if(var3 != undefined)
		{
			this._cciSprite.data = {name:var3.name,gfxFile:dofus.Constants.CLIPS_PERSOS_PATH + var3.gfxId + ".swf",title:var3.id};
			this._cciSprite.enabled = true;
		}
		else
		{
			this._cciSprite.data = undefined;
			this._cciSprite.enabled = false;
		}
	}
	function overItem(var2)
	{
		if(var2.target.contentData != undefined)
		{
			this.gapi.showTooltip(var2.target.contentData.name + " (" + var2.target.contentData.id + ", GFX: " + var2.target.contentData.gfxId + ")",var2.target,-20);
		}
	}
	function outItem(var2)
	{
		this.gapi.hideTooltip();
	}
	function itemSelected(var2)
	{
		switch(var2.target)
		{
			case this._cbType:
				var var3 = this._cbType.selectedItem.data;
				this._cg.dataProvider = var3;
				this._lblNumber.text = var3.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText(!this._bMonster?"LOOK":"MONSTER"),"m",var3.length < 2);
				break;
			case this._cbAnim:
				this._cciSprite.setAnim(this._cbAnim.selectedItem.label,true);
		}
	}
	function onShortcut(var2)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG" && this._tiSearch.focused)
		{
			this.click({target:this._btnSearch});
			return false;
		}
		return true;
	}
}
