class dofus.graphics.gapi.ui.gameresult.GameResultPlayer extends ank.gapi.core.UIBasicComponent
{
   function GameResultPlayer()
   {
      super();
   }
   function __set__list(mcList)
   {
      this._mcList = mcList;
      return this.__get__list();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      this._oItems = oItem;
      if(bUsed)
      {
         switch(oItem.type)
         {
            case "monster":
            case "taxcollector":
            case "player":
               this._lblName.text = oItem.name;
               if(_global.isNaN(oItem.xp))
               {
                  this._pbXP._visible = false;
               }
               else
               {
                  this._pbXP._visible = true;
                  this._pbXP.minimum = oItem.minxp;
                  this._pbXP.maximum = oItem.maxxp;
                  this._pbXP.value = oItem.xp;
               }
               this._lblWinXP.text = !_global.isNaN(oItem.winxp)?oItem.winxp:"";
               this._lblGuildXP.text = !_global.isNaN(oItem.guildxp)?oItem.guildxp:"";
               this._lblMountXP.text = !_global.isNaN(oItem.mountxp)?oItem.mountxp:"";
               this._lblKama.text = !_global.isNaN(oItem.kama)?oItem.kama:"";
               this._lblLevel.text = oItem.level;
               this._mcDeadHead._visible = oItem.bDead;
               this.createEmptyMovieClip("_mcItems",10);
               var _loc5_ = false;
               oItem.items.sortOn(["_itemLevel","_itemName"],Array.DESCENDING | Array.NUMERIC);
               var _loc6_ = oItem.items.length;
               while((_loc6_ = _loc6_ - 1) >= 0)
               {
                  var _loc7_ = this._mcItemPlacer._x + 24 * _loc6_;
                  if(_loc7_ < this._mcItemPlacer._x + this._mcItemPlacer._width)
                  {
                     var _loc8_ = oItem.items[_loc6_];
                     var _loc9_ = this._mcItems.attachMovie("Container","_ctrItem" + _loc6_,_loc6_,{_x:_loc7_,_y:this._mcItemPlacer._y + 1});
                     _loc9_.setSize(18,18);
                     _loc9_.addEventListener("over",this);
                     _loc9_.addEventListener("out",this);
                     _loc9_.addEventListener("click",this);
                     _loc9_.enabled = true;
                     _loc9_.margin = 0;
                     _loc9_.contentData = _loc8_;
                  }
                  else
                  {
                     _loc5_ = true;
                  }
               }
               this._ldrAllDrop._visible = _loc5_;
         }
      }
      else if(this._lblName.text != undefined)
      {
         this._pbXP._visible = false;
         this._lblName.text = "";
         this._pbXP.minimum = 0;
         this._pbXP.maximum = 100;
         this._pbXP.value = random(99);
         this._lblWinXP.text = "";
         this._lblKama.text = "";
         this._mcDeadHead._visible = false;
         this._mcItems.removeMovieClip();
         this._ldrAllDrop._visible = false;
      }
   }
   function init()
   {
      super.init(false);
      this._mcItemPlacer._alpha = 0;
      this._mcDeadHead._visible = false;
      this.addToQueue({object:this,method:this.addListeners});
   }
   function size()
   {
      super.size();
   }
   function addListeners()
   {
      var _loc2_ = this;
      this._ldrAllDrop.onRollOver = function()
      {
         this._parent.over({target:this});
      };
      this._ldrAllDrop.onRollOut = function()
      {
         this._parent.out({target:this});
      };
      this._pbXP.enabled = true;
      this._pbXP.addEventListener("over",this);
      this._pbXP.addEventListener("out",this);
   }
   function over(oEvent)
   {
      switch(oEvent.target)
      {
         case this._ldrAllDrop:
            var _loc3_ = this._oItems.items;
            var _loc4_ = "";
            var _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               var _loc6_ = _loc3_[_loc5_];
               if(_loc5_ > 0)
               {
                  _loc4_ = _loc4_ + "\n";
               }
               _loc4_ = _loc4_ + (_loc6_.Quantity + " x " + _loc6_.name);
               _loc5_ = _loc5_ + 1;
            }
            if(_loc4_ != "")
            {
               this._mcList.gapi.showTooltip(_loc4_,oEvent.target,30);
            }
            break;
         case this._pbXP:
            this._mcList.gapi.showTooltip(this._oItems.xp + " / " + this._oItems.maxxp,oEvent.target,20);
            break;
         default:
            var _loc7_ = oEvent.target.contentData;
            var _loc8_ = _loc7_.style + "ToolTip";
            this._mcList.gapi.showTooltip(_loc7_.Quantity + " x " + _loc7_.name,oEvent.target,20,undefined,_loc8_);
      }
   }
   function out(oEvent)
   {
      this._mcList.gapi.hideTooltip();
   }
   function click(oEvent)
   {
      var _loc3_ = oEvent.target.contentData;
      if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && _loc3_ != undefined)
      {
         this._mcList._parent.gapi.api.kernel.GameManager.insertItemInChat(_loc3_);
      }
   }
}
