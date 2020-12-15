class dofus.graphics.battlefield.GuildOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
	function GuildOverHead(var3, var4, var5, var6, var7, var8, var9)
	{
		super();
		this.initialize(var9 != undefined);
		this.draw(var3,var4,var5,var6,var7,var8,var9);
	}
	function initialize(var2)
	{
		super.initialize();
		this.createTextField("_txtGuildName",30,0,-2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
		this.createTextField("_txtSpriteName",40,0,13 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
		if(var3)
		{
			this.createTextField("_txtTitle",31,0,-2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
			this._txtTitle.embedFonts = true;
		}
	}
	function draw(var2, var3, var4, var5, var6, var7, var8)
	{
		var var9 = var5 != undefined && var6 != undefined;
		if(var7 == undefined)
		{
			var7 = 0;
		}
		this._txtGuildName.embedFonts = true;
		this._txtGuildName.autoSize = "left";
		this._txtGuildName.text = var2;
		this._txtGuildName.selectable = false;
		this._txtGuildName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_SMALL_FORMAT);
		this._txtSpriteName.embedFonts = true;
		this._txtSpriteName.autoSize = "left";
		this._txtSpriteName.text = var3;
		this._txtSpriteName.selectable = false;
		this._txtSpriteName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
		var var12 = 0;
		if(var8)
		{
			this._txtTitle.autoSize = "center";
			this._txtTitle.text = var8.text;
			this._txtTitle.selectable = false;
			this._txtTitle.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT2);
			if(var8.color != undefined)
			{
				this._txtTitle.textColor = var8.color;
			}
			var var10 = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 3 + this._txtTitle.textHeight);
			var var13 = Math.ceil(Math.max(this._txtGuildName.textWidth,this._txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
			var var11 = Math.ceil(Math.max(var13,this._txtTitle.textWidth + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2));
			var12 = dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + this._txtTitle.textHeight;
			this._txtGuildName._x = this._txtSpriteName._x = (- var11) / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
			this._txtTitle._y = 27 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2;
		}
		else
		{
			var10 = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
			var11 = Math.ceil(Math.max(this._txtGuildName.textWidth,this._txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
			this._txtGuildName._x = this._txtSpriteName._x = (- var11) / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
		}
		this.drawBackground(var11,var10,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
		this.attachMovie("Emblem","_eEmblem",100,{_x:Math.ceil((- var11) / 2) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER,_y:dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,_height:30,_width:30,data:var4,shadow:true});
		if(var9)
		{
			this.drawGfx(var5,var6);
			this.addPvpGfxEffect(var7,var6);
		}
	}
}
