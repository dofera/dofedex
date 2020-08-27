class dofus.graphics.battlefield.TextOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
	function TextOverHead(var3, var4, var5, var6, var7, var8)
	{
		super();
		this.initialize(var8 != undefined);
		this.draw(var3,var4,var5,var6,var7,var8);
	}
	function initialize(var2)
	{
		super.initialize();
		this.createTextField("_txtText",30,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
		if(var3)
		{
			this.createTextField("_txtTitle",31,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
			this._txtTitle.embedFonts = true;
		}
		this._txtText.embedFonts = true;
	}
	function draw(var2, var3, var4, var5, var6, var7)
	{
		var var8 = var3 != undefined && var5 != undefined;
		if(var6 == undefined)
		{
			var6 = 0;
		}
		this._txtText.autoSize = "center";
		this._txtText.text = var2;
		this._txtText.selectable = false;
		this._txtText.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
		if(var4 != undefined)
		{
			this._txtText.textColor = var4;
		}
		if(var7)
		{
			this._txtTitle.autoSize = "center";
			this._txtTitle.text = var7.text;
			this._txtTitle.selectable = false;
			this._txtTitle.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT2);
			if(var7.color != undefined)
			{
				this._txtTitle.textColor = var7.color;
			}
			this._txtTitle._y = this._txtText._y + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + this._txtText.textHeight;
			var var9 = Math.ceil(this._txtText.textHeight + this._txtTitle.textHeight + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 3);
			var var10 = Math.ceil(Math.max(this._txtText.textWidth,this._txtTitle.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
		}
		else
		{
			var9 = Math.ceil(this._txtText.textHeight + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
			var10 = Math.ceil(this._txtText.textWidth + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
		}
		this.drawBackground(var10,var9,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
		if(var8)
		{
			this.drawGfx(var3,var5);
			this.addPvpGfxEffect(var6,var5);
		}
	}
}
