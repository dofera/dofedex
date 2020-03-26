class dofus.graphics.battlefield.GuildOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
   function GuildOverHead(sText, sSpriteName, oEmblem, sFile, nFrame, nPvpGain, title)
   {
      super();
      this.initialize(title != undefined);
      this.draw(sText,sSpriteName,oEmblem,sFile,nFrame,nPvpGain,title);
   }
   function initialize(displayTitle)
   {
      super.initialize();
      this.createTextField("_txtGuildName",30,0,-2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
      this.createTextField("_txtSpriteName",40,0,13 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
      if(displayTitle)
      {
         this.createTextField("_txtTitle",31,0,-2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,0,0);
         this._txtTitle.embedFonts = true;
      }
   }
   function draw(sGuildName, sSpriteName, oEmblem, sFile, nFrame, nPvpGain, title)
   {
      var _loc9_ = sFile != undefined && nFrame != undefined;
      if(nPvpGain == undefined)
      {
         nPvpGain = 0;
      }
      this._txtGuildName.embedFonts = true;
      this._txtGuildName.autoSize = "left";
      this._txtGuildName.text = sGuildName;
      this._txtGuildName.selectable = false;
      this._txtGuildName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_SMALL_FORMAT);
      this._txtSpriteName.embedFonts = true;
      this._txtSpriteName.autoSize = "left";
      this._txtSpriteName.text = sSpriteName;
      this._txtSpriteName.selectable = false;
      this._txtSpriteName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
      var _loc12_ = 0;
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
         var _loc10_ = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 3 + this._txtTitle.textHeight);
         var _loc13_ = Math.ceil(Math.max(this._txtGuildName.textWidth,this._txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
         var _loc11_ = Math.ceil(Math.max(_loc13_,this._txtTitle.textWidth + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2));
         _loc12_ = dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + this._txtTitle.textHeight;
         this._txtGuildName._x = this._txtSpriteName._x = (- _loc11_) / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
         this._txtTitle._y = 27 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2;
      }
      else
      {
         _loc10_ = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
         _loc11_ = Math.ceil(Math.max(this._txtGuildName.textWidth,this._txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
         this._txtGuildName._x = this._txtSpriteName._x = (- _loc11_) / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
      }
      this.drawBackground(_loc11_,_loc10_,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
      this.attachMovie("Emblem","_eEmblem",100,{_x:Math.ceil((- _loc11_) / 2) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER,_y:dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER,_height:30,_width:30,data:oEmblem,shadow:true});
      if(_loc9_)
      {
         this.drawGfx(sFile,nFrame);
         this.addPvpGfxEffect(nPvpGain,nFrame);
      }
   }
}
