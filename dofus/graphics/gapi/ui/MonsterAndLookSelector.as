class dofus.graphics.gapi.ui.MonsterAndLookSelector extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MonsterAndLookSelector";
	static var ANIM_LIST = ["static","walk","run","hit","bonus","anim0","anim1","anim2","anim3","anim4","anim5","anim6","anim7","anim8","anim9","anim10","anim11","anim12","anim12","anim13","anim14","anim15","anim16","anim17","anim18","anim111","anim112","anim113","anim114","anim115","anim116","anim117","emote1","emote2","emote3","emote4","emote5","emote6","emote7","emote8","emote9","emote10","emote11","emote12","emote13","emote14","emote15","emote16","emote17","emote18","emote19","emote20","emote21","emoteStatic1","emoteStatic14","emoteStatic15","emoteStatic16","emoteStatic19","emoteStatic20","emoteStatic21","die"];
	function MonsterAndLookSelector()
	{
		super();
	}
	function __set__monster(loc2)
	{
		this._bMonster = loc2;
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
		var loc2 = new Object();
		loc2.onSetFocus = function(loc2, loc3)
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
		Selection.addListener(loc2);
	}
	function initAnimList(loc2)
	{
		var loc3 = new ank.utils.();
		var loc4 = 0;
		while(loc4 < dofus.graphics.gapi.ui.MonsterAndLookSelector.ANIM_LIST.length)
		{
			loc3.push({label:dofus.graphics.gapi.ui.MonsterAndLookSelector.ANIM_LIST[loc4]});
			loc4 = loc4 + 1;
		}
		this._cbAnim.dataProvider = loc3;
	}
	function initData(loc2)
	{
		this._cciSprite.deleteButton = false;
		this._eaTypes = loc2;
		loc2.sortOn("label");
		this._cbType.dataProvider = loc2;
	}
	function loadLooks()
	{
		var loc2 = new XML();
		loc2.ignoreWhite = true;
		loc2.onLoad = function()
		{
			var loc2 = dofus.Constants.ARTWORKS_BIG_PATH;
			var loc3 = new ank.utils.();
			var loc4 = new ank.utils.();
			var loc5 = this.firstChild.firstChild;
			while(loc5 != undefined)
			{
				var loc6 = loc5.attributes.name;
				var loc7 = new ank.utils.();
				var loc8 = loc5.firstChild;
				while(loc8 != undefined)
				{
					var loc9 = loc8.attributes.id;
					var loc10 = loc8.attributes.name;
					var loc11 = {iconFile:loc2 + loc9 + ".swf",name:loc10,id:loc9,gfxId:loc9};
					loc7.push(loc11);
					loc4.push(loc11);
					loc8 = loc8.nextSibling;
				}
				loc3.push({label:loc6,data:loc7});
				loc5 = loc5.nextSibling;
			}
			loc3.push({label:"-- ALL --",data:loc4});
			ui.initData(loc3);
		};
		loc2.load(dofus.Constants.XML_SPRITE_LIST);
	}
	function loadMonsters(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = "";
		}
		var loc3 = this.api.lang.getMonsters();
		var loc4 = dofus.Constants.ARTWORKS_BIG_PATH;
		var loc5 = new ank.utils.();
		var loc6 = new ank.utils.();
		var loc7 = new Object();
		for(var a in loc3)
		{
			var loc8 = loc3[a];
			var loc9 = loc8.b;
			var loc10 = loc7[loc9];
			if(loc10 == undefined)
			{
				loc10 = {label:this.api.lang.getMonstersRaceText(loc9).n,data:new ank.utils.()};
				loc7[loc9] = loc10;
				loc5.push(loc10);
			}
			var loc11 = a;
			var loc12 = loc8.n;
			var loc13 = loc8.g;
			var loc14 = {iconFile:loc4 + loc13 + ".swf",name:loc12,id:loc11,gfxId:loc13};
			loc6.push(loc14);
			loc10.data.push(loc14);
		}
		loc5.push({label:"-- ALL --",data:loc6});
		this.initData(loc5);
	}
	function select(loc2)
	{
		var loc3 = loc2.target.contentData;
		if(loc3 != undefined)
		{
			if(this._bMonster)
			{
				this.dispatchEvent({type:"select",ui:"MonsterSelector",monsterId:loc3.id});
			}
			else
			{
				this.dispatchEvent({type:"select",ui:"LookSelector",lookId:loc3.id});
			}
			this.callClose();
		}
	}
	function filterResult(loc2)
	{
		var loc3 = this._cbType.selectedItem.data;
		var loc4 = new ank.utils.();
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			var loc6 = loc3[loc5].name;
			if(!(loc2.length && (loc2 != "Recherche..." && (loc2.length && loc6.toUpperCase().indexOf(loc2.toUpperCase()) == -1))))
			{
				loc4.push(loc3[loc5]);
			}
			loc5 = loc5 + 1;
		}
		this._cg.dataProvider = loc4;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
			case "_btnCancel":
				this.dispatchEvent({type:"cancel"});
				this.callClose();
			case "_btnSelect":
				this.select({target:this._cg.selectedItem});
				break;
			default:
				if(loc0 !== "_btnSearch")
				{
					break;
				}
				this._cbType.selectedIndex = 0;
				this.filterResult(this._tiSearch.text);
				break;
		}
	}
	function dblClickItem(loc2)
	{
		this.select(loc2);
	}
	function selectItem(loc2)
	{
		var loc3 = loc2.target.contentData;
		if(loc3 != undefined)
		{
			this._cciSprite.data = {name:loc3.name,gfxFile:dofus.Constants.CLIPS_PERSOS_PATH + loc3.gfxId + ".swf",title:loc3.id};
			this._cciSprite.enabled = true;
		}
		else
		{
			this._cciSprite.data = undefined;
			this._cciSprite.enabled = false;
		}
	}
	function overItem(loc2)
	{
		if(loc2.target.contentData != undefined)
		{
			this.gapi.showTooltip(loc2.target.contentData.name + " (" + loc2.target.contentData.id + ", GFX: " + loc2.target.contentData.gfxId + ")",loc2.target,-20);
		}
	}
	function outItem(loc2)
	{
		this.gapi.hideTooltip();
	}
	function itemSelected(loc2)
	{
		switch(loc2.target)
		{
			case this._cbType:
				var loc3 = this._cbType.selectedItem.data;
				this._cg.dataProvider = loc3;
				this._lblNumber.text = loc3.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText(!this._bMonster?"LOOK":"MONSTER"),"m",loc3.length < 2);
				break;
			case this._cbAnim:
				this._cciSprite.setAnim(this._cbAnim.selectedItem.label,true);
		}
	}
	function onShortcut(loc2)
	{
		if(loc2 == "ACCEPT_CURRENT_DIALOG" && this._tiSearch.focused)
		{
			this.click({target:this._btnSearch});
			return false;
		}
		return true;
	}
}
