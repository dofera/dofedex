class dofus.graphics.battlefield.GuildOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
	function GuildOverHead(loc3, loc4, loc5, loc6, loc7, loc8, loc9)
	{
		super();
		this.initialize(loc9 != undefined);
		this.draw(loc3,loc4,loc5,loc6,loc7,loc8,loc9);
	}
	function initialize(loc2)
	{
		super.initialize();
		this.createTextField("_txtGuildName",30,0,-2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
		this.createTextField("_txtSpriteName",40,0,13 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
		if(loc3)
		{
			this.createTextField("_txtTitle",31,0,-2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
			this._txtTitle.embedFonts = true;
		}
	}
	function draw(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		var loc9 = loc5 != undefined && loc6 != undefined;
		if(loc7 == undefined)
		{
			loc7 = 0;
		}
		this._txtGuildName.embedFonts = true;
		this._txtGuildName.autoSize = "left";
		this._txtGuildName.text = loc2;
		this._txtGuildName.selectable = false;
		this._txtGuildName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_SMALL_FORMAT);
		this._txtSpriteName.embedFonts = true;
		this._txtSpriteName.autoSize = "left";
		this._txtSpriteName.text = loc3;
		this._txtSpriteName.selectable = false;
		this._txtSpriteName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
		var loc12 = 0;
		if(loc8)
		{
			this._txtTitle.autoSize = "center";
			this._txtTitle.text = loc8.text;
			this._txtTitle.selectable = false;
			this._txtTitle.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT2);
			if(loc8.color != undefined)
			{
				this._txtTitle.textColor = loc8.color;
			}
			var loc10 = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 3 + this._txtTitle.textHeight);
			var loc13 = Math.ceil(Math.max(this._txtGuildName.textWidth,this._txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
			var loc11 = Math.ceil(Math.max(loc13,this._txtTitle.textWidth + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2));
			loc12 = dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + this._txtTitle.textHeight;
			this._txtGuildName._x = this._txtSpriteName._x = (- loc11) / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
			this._txtTitle._y = 27 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2;
		}
		else
		{
			loc10 = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
			loc11 = Math.ceil(Math.max(this._txtGuildName.textWidth,this._txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
			this._txtGuildName._x = this._txtSpriteName._x = (- loc11) / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
		}
		this.drawBackground(loc11,loc10,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
		this.attachMovie("Emblem","_eEmblem",100,{_x:Math.ceil((- loc11) / 2) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER,_y:dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,_height:30,_width:30,data:loc4,shadow:true});
		if(loc9)
		{
			this.drawGfx(loc5,loc6);
			this.addPvpGfxEffect(loc7,loc6);
		}
	}
}
