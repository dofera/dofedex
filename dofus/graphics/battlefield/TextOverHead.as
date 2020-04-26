class dofus.graphics.battlefield.TextOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
	function TextOverHead(loc3, loc4, loc5, loc6, loc7, loc8)
	{
		super();
		this.initialize(loc8 != undefined);
		this.draw(loc3,loc4,loc5,loc6,loc7,loc8);
	}
	function initialize(loc2)
	{
		super.initialize();
		this.createTextField("_txtText",30,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
		if(loc3)
		{
			this.createTextField("_txtTitle",31,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
			this._txtTitle.embedFonts = true;
		}
		this._txtText.embedFonts = true;
	}
	function draw(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		var loc8 = loc3 != undefined && loc5 != undefined;
		if(loc6 == undefined)
		{
			loc6 = 0;
		}
		this._txtText.autoSize = "center";
		this._txtText.text = loc2;
		this._txtText.selectable = false;
		this._txtText.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
		if(loc4 != undefined)
		{
			this._txtText.textColor = loc4;
		}
		if(loc7)
		{
			this._txtTitle.autoSize = "center";
			this._txtTitle.text = loc7.text;
			this._txtTitle.selectable = false;
			this._txtTitle.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT2);
			if(loc7.color != undefined)
			{
				this._txtTitle.textColor = loc7.color;
			}
			this._txtTitle._y = this._txtText._y + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + this._txtText.textHeight;
			var loc9 = Math.ceil(this._txtText.textHeight + this._txtTitle.textHeight + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 3);
			var loc10 = Math.ceil(Math.max(this._txtText.textWidth,this._txtTitle.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
		}
		else
		{
			loc9 = Math.ceil(this._txtText.textHeight + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
			loc10 = Math.ceil(this._txtText.textWidth + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
		}
		this.drawBackground(loc10,loc9,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
		if(loc8)
		{
			this.drawGfx(loc3,loc5);
			this.addPvpGfxEffect(loc6,loc5);
		}
	}
}
