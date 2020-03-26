class dofus.graphics.gapi.controls.ClassCustomize extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ClassCustomize";
   static var SPRITE_ANIMS = ["StaticF","StaticR","StaticL","WalkF","RunF","Anim2R","Anim2L"];
   static var NAME_GENERATION_DELAY = 500;
   var _nSpriteAnimIndex = 0;
   var _nLastRegenerateTimer = 0;
   function ClassCustomize()
   {
      super();
   }
   function __set__classID(nClassID)
   {
      this._nClassID = nClassID;
      this.addToQueue({object:this,method:this.layoutContent});
      return this.__get__classID();
   }
   function __set__sex(nSex)
   {
      this._nSex = nSex;
      this.addToQueue({object:this,method:this.layoutContent});
      return this.__get__sex();
   }
   function __set__colors(aColors)
   {
      this.addToQueue({object:this,method:this.applyColor,params:[aColors[0],1]});
      this.addToQueue({object:this,method:this.applyColor,params:[aColors[1],2]});
      this.addToQueue({object:this,method:this.applyColor,params:[aColors[2],3]});
      this.addToQueue({object:this,method:this.updateSprite});
      return this.__get__colors();
   }
   function __set__name(sName)
   {
      this.addToQueue({object:this,method:function()
      {
         if(this._itCharacterName.text != undefined)
         {
            this._itCharacterName.text = sName;
            this._itCharacterName.setFocus();
            Selection.setSelection(sName.length,sName.length);
         }
      }});
      return this.__get__name();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ClassCustomize.CLASS_NAME);
      this._mcRegenerateNickName._visible = false;
   }
   function createChildren()
   {
      this._visible = false;
      this._oColors = {color1:-1,color2:-1,color3:-1};
      this._oBakColors = {color1:-1,color2:-1,color3:-1};
      this.addToQueue({object:this,method:function()
      {
         this.setupRestriction();
      }});
      this.addToQueue({object:this,method:this.checkFeaturesAvailability});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
      this.api.colors.addSprite(this._ldrSprite,this._oColors);
      this.addToQueue({object:this,method:this.setColorIndex,params:[1]});
      this.addToQueue({object:this,method:function()
      {
         this._itCharacterName.setFocus();
      }});
      this.addToQueue({object:this,method:function()
      {
         this._visible = true;
      }});
   }
   function setupRestriction()
   {
      if(this.api.datacenter.Player.isAuthorized)
      {
         this._itCharacterName.restrict = "a-zA-Z\\-\\[\\]";
      }
      else
      {
         this._itCharacterName.restrict = "a-zA-Z\\-";
      }
   }
   function checkFeaturesAvailability()
   {
      if(this.api.lang.getConfigText("GENERATE_RANDOM_NAME") && this.api.datacenter.Basics.aks_can_generate_names !== false)
      {
         this._mcRegenerateNickName._visible = true;
      }
   }
   function addListeners()
   {
      this._cpColorPicker.addEventListener("change",this);
      this._ldrSprite.addEventListener("initialization",this);
      this._btnNextAnim.addEventListener("click",this);
      this._btnPreviousAnim.addEventListener("click",this);
      this._btnReset1.addEventListener("click",this);
      this._btnReset2.addEventListener("click",this);
      this._btnReset3.addEventListener("click",this);
      this._btnColor1.addEventListener("click",this);
      this._btnColor2.addEventListener("click",this);
      this._btnColor3.addEventListener("click",this);
      this._btnColor1.addEventListener("over",this);
      this._btnColor2.addEventListener("over",this);
      this._btnColor3.addEventListener("over",this);
      this._btnColor1.addEventListener("out",this);
      this._btnColor2.addEventListener("out",this);
      this._btnColor3.addEventListener("out",this);
      this._itCharacterName.addEventListener("change",this);
      var ref = this;
      this._mcRegenerateNickName.onRelease = function()
      {
         ref.click({target:this});
      };
      this._mcRegenerateNickName.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcRegenerateNickName.onRollOut = function()
      {
         ref.out({target:this});
      };
   }
   function initTexts()
   {
      this._lblCharacterColors.text = this.api.lang.getText("SPRITE_COLORS");
      this._lblCharacterName.text = this.api.lang.getText("CREATE_CHARACTER_NAME");
   }
   function layoutContent()
   {
      if(this._nClassID == undefined || this._nSex == undefined)
      {
         return undefined;
      }
      this._ldrSprite.contentPath = dofus.Constants.CLIPS_PERSOS_PATH + this._nClassID + this._nSex + ".swf";
   }
   function applyColor(nColor, nIndex)
   {
      if(nIndex == undefined)
      {
         nIndex = this._nSelectedColorIndex;
      }
      var _loc4_ = {ColoredButton:{bgcolor:(nColor != -1?nColor:16711680),highlightcolor:(nColor != -1?nColor:16777215),bgdowncolor:(nColor != -1?nColor:16711680),highlightdowncolor:(nColor != -1?nColor:16777215)}};
      ank.gapi.styles.StylesManager.loadStylePackage(_loc4_);
      this["_btnColor" + nIndex].styleName = "ColoredButton";
      this._oColors["color" + nIndex] = nColor;
      this._oBakColors["color" + nIndex] = nColor;
      this.updateSprite();
   }
   function setColorIndex(nIndex)
   {
      var _loc3_ = this["_btnColor" + this._nSelectedColorIndex];
      var _loc4_ = this["_btnColor" + nIndex];
      _loc3_.selected = false;
      _loc4_.selected = true;
      this._nSelectedColorIndex = nIndex;
   }
   function showColorPosition(nIndex)
   {
      var bWhite = true;
      this.onEnterFrame = function()
      {
         this._oColors["color" + nIndex] = !bWhite?16746632:16733525;
         this.updateSprite();
         bWhite = !bWhite;
      };
   }
   function hideColorPosition(nIndex)
   {
      delete this.onEnterFrame;
      this._oColors.color1 = this._oBakColors.color1;
      this._oColors.color2 = this._oBakColors.color2;
      this._oColors.color3 = this._oBakColors.color3;
      this.updateSprite();
   }
   function updateSprite()
   {
      var _loc2_ = this._ldrSprite.content;
      _loc2_.mcAnim.removeMovieClip();
      _loc2_.attachMovie(dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS[this._nSpriteAnimIndex],"mcAnim",10);
      _loc2_._xscale = _loc2_._yscale = 200;
   }
   function hideGenerateRandomName()
   {
      this._mcRegenerateNickName._visible = false;
   }
   function change(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_itCharacterName":
            var _loc3_ = this._itCharacterName.text;
            if(!this.api.datacenter.Player.isAuthorized)
            {
               _loc3_ = _loc3_.substr(0,1).toUpperCase() + _loc3_.substr(1);
               var _loc4_ = _loc3_.substr(0,1);
               var _loc5_ = 1;
               while(_loc5_ < _loc3_.length)
               {
                  if(_loc3_.substr(_loc5_ - 1,1) != "-")
                  {
                     _loc4_ = _loc4_ + _loc3_.substr(_loc5_,1).toLowerCase();
                  }
                  else
                  {
                     _loc4_ = _loc4_ + _loc3_.substr(_loc5_,1);
                  }
                  _loc5_ = _loc5_ + 1;
               }
               this._itCharacterName.removeEventListener("change",this);
               this._itCharacterName.text = _loc4_;
               this._itCharacterName.addEventListener("change",this);
            }
            this.dispatchEvent({type:"nameChange",value:this._itCharacterName.text});
            break;
         case "_cpColorPicker":
            this.applyColor(oEvent.value);
            this.dispatchEvent({type:"colorsChange",value:this._oColors});
      }
   }
   function initialization(oEvent)
   {
      this.updateSprite();
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnNextAnim":
            this._nSpriteAnimIndex = this._nSpriteAnimIndex + 1;
            if(this._nSpriteAnimIndex >= dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS.length)
            {
               this._nSpriteAnimIndex = 0;
            }
            this.updateSprite();
            break;
         case "_btnPreviousAnim":
            this._nSpriteAnimIndex = this._nSpriteAnimIndex - 1;
            if(this._nSpriteAnimIndex < 0)
            {
               this._nSpriteAnimIndex = dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS.length - 1;
            }
            this.updateSprite();
            break;
         case "_btnColor1":
         case "_btnColor2":
         case "_btnColor3":
            var _loc3_ = Number(oEvent.target._name.substr(9));
            var _loc4_ = this._oBakColors["color" + _loc3_];
            if(_loc4_ != -1)
            {
               this._cpColorPicker.setColor(_loc4_);
            }
            this.setColorIndex(_loc3_);
            break;
         case "_btnReset1":
         case "_btnReset2":
         case "_btnReset3":
            var _loc5_ = Number(oEvent.target._name.substr(9));
            this.applyColor(-1,_loc5_);
            this.dispatchEvent({type:"colorsChange",value:this._oColors});
            break;
         case "_mcRegenerateNickName":
            if(this._nLastRegenerateTimer + dofus.graphics.gapi.controls.ClassCustomize.NAME_GENERATION_DELAY < getTimer())
            {
               this.api.network.Account.getRandomCharacterName();
               this._nLastRegenerateTimer = dofus.graphics.gapi.controls.ClassCustomize.NAME_GENERATION_DELAY;
            }
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnColor1":
         case "_btnColor2":
         case "_btnColor3":
            var _loc3_ = Number(oEvent.target._name.substr(9));
            this.showColorPosition(_loc3_);
            break;
         case "_mcRegenerateNickName":
            var _loc4_ = {x:this._mcRegenerateNickName._x,y:this._mcRegenerateNickName._y};
            this._mcRegenerateNickName.localToGlobal(_loc4_);
            this.gapi.showTooltip(this.api.lang.getText("RANDOM_NICKNAME"),_loc4_.x + this._x,_loc4_.y + this._y - 20);
      }
   }
   function out(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnColor1":
         case "_btnColor2":
         case "_btnColor3":
            this.hideColorPosition();
            break;
         default:
            this.gapi.hideTooltip();
      }
   }
}
