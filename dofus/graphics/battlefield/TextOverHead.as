class dofus.graphics.battlefield.TextOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
   function TextOverHead(sText, sFile, nColor, nFrame, nPvpGain, title)
   {
      super();
      this.initialize(title != undefined);
      this.draw(sText,sFile,nColor,nFrame,nPvpGain,title);
   }
   function initialize(displayTitle)
   {
      super.initialize();
      this.createTextField("_txtText",30,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
      if(displayTitle)
      {
         this.createTextField("_txtTitle",31,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
         this._txtTitle.embedFonts = true;
      }
      this._txtText.embedFonts = true;
   }
   function draw(sText, sFile, nColor, nFrame, nPvpGain, title)
   {
      var _loc8_ = sFile != undefined && nFrame != undefined;
      if(nPvpGain == undefined)
      {
         nPvpGain = 0;
      }
      this._txtText.autoSize = "center";
      this._txtText.text = sText;
      this._txtText.selectable = false;
      this._txtText.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
      if(nColor != undefined)
      {
         this._txtText.textColor = nColor;
      }
      if(title)
      {
         this._txtTitle.autoSize = "center";
         this._txtTitle.text = title.text;
         this._txtTitle.selectable = false;
         this._txtTitle.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT2);
         if(title.color != undefined)
         {
            this._txtTitle.textColor = title.color;
         }
         this._txtTitle._y = this._txtText._y + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + this._txtText.textHeight;
         var _loc9_ = Math.ceil(this._txtText.textHeight + this._txtTitle.textHeight + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 3);
         var _loc10_ = Math.ceil(Math.max(this._txtText.textWidth,this._txtTitle.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
      }
      else
      {
         _loc9_ = Math.ceil(this._txtText.textHeight + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
         _loc10_ = Math.ceil(this._txtText.textWidth + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
      }
      this.drawBackground(_loc10_,_loc9_,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
      if(_loc8_)
      {
         this.drawGfx(sFile,nFrame);
         this.addPvpGfxEffect(nPvpGain,nFrame);
      }
   }
}
