class dofus.graphics.gapi.ui.gameresult.GameResultPlayerPVP extends ank.gapi.core.UIBasicComponent
{
   function GameResultPlayerPVP()
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
      oItem.items.sortOn("_itemLevel",Array.DESCENDING | Array.NUMERIC);
      this._oItems = oItem;
      var _loc5_ = this._mcList._parent.api;
      if(bUsed)
      {
         switch(oItem.type)
         {
            case "monster":
            case "taxcollector":
            case "player":
               this._lblName.text = oItem.name;
               if(oItem.rank == 0 && !_loc5_.datacenter.Basics.aks_current_server.isHardcore())
               {
                  this._pbHonour._visible = false;
                  this._lblWinHonour._visible = false;
                  this._pbDisgrace._visible = false;
                  this._lblWinDisgrace._visible = false;
                  this._lblRank._visible = false;
               }
               else
               {
                  this._pbHonour._visible = true;
                  this._pbDisgrace._visible = true;
                  this._lblWinDisgrace._visible = true;
                  this._lblWinHonour._visible = true;
                  this._lblRank._visible = true;
                  if(_loc5_.datacenter.Basics.aks_current_server.isHardcore())
                  {
                     if(_global.isNaN(oItem.minxp))
                     {
                        this._pbDisgrace._visible = false;
                     }
                     this._pbDisgrace.minimum = oItem.minxp;
                     this._pbDisgrace.maximum = oItem.maxxp;
                     this._pbDisgrace.value = oItem.xp;
                  }
                  else
                  {
                     this._pbDisgrace.minimum = oItem.mindisgrace;
                     this._pbDisgrace.maximum = oItem.maxdisgrace;
                     this._pbDisgrace.value = oItem.disgrace;
                  }
                  this._pbHonour.minimum = oItem.minhonour;
                  this._pbHonour.maximum = oItem.maxhonour;
                  this._pbHonour.value = oItem.honour;
               }
               this._lblWinHonour.text = !_global.isNaN(oItem.winhonour)?oItem.winhonour:"";
               if(!_loc5_.datacenter.Basics.aks_current_server.isHardcore())
               {
                  this._lblWinDisgrace.text = !_global.isNaN(oItem.windisgrace)?oItem.windisgrace:"";
               }
               else
               {
                  this._lblWinDisgrace.text = !_global.isNaN(oItem.winxp)?oItem.winxp:"";
               }
               this._lblRank.text = !_global.isNaN(oItem.rank)?oItem.rank:"";
               this._lblKama.text = !_global.isNaN(oItem.kama)?oItem.kama:"";
               this._lblLevel.text = oItem.level;
               this._mcDeadHead._visible = oItem.bDead;
               this.createEmptyMovieClip("_mcItems",10);
               var _loc6_ = false;
               var _loc7_ = oItem.items.length;
               while((_loc7_ = _loc7_ - 1) >= 0)
               {
                  var _loc8_ = this._mcItemPlacer._x + 24 * _loc7_;
                  if(_loc8_ < this._mcItemPlacer._x + this._mcItemPlacer._width)
                  {
                     var _loc9_ = oItem.items[_loc7_];
                     var _loc10_ = this._mcItems.attachMovie("Container","_ctrItem" + _loc7_,_loc7_,{_x:_loc8_,_y:this._mcItemPlacer._y + 1});
                     _loc10_.setSize(18,18);
                     _loc10_.addEventListener("over",this);
                     _loc10_.addEventListener("out",this);
                     _loc10_.addEventListener("click",this);
                     _loc10_.enabled = true;
                     _loc10_.margin = 0;
                     _loc10_.contentData = _loc9_;
                  }
                  else
                  {
                     _loc6_ = true;
                  }
               }
               this._ldrAllDrop._visible = _loc6_;
         }
      }
      else if(this._lblName.text != undefined)
      {
         this._pbHonour._visible = false;
         this._lblName.text = "";
         this._pbHonour.minimum = 0;
         this._pbHonour.maximum = 100;
         this._pbHonour.value = 0;
         this._pbDisgrace.minimum = 0;
         this._pbDisgrace.maximum = 100;
         this._pbDisgrace.value = 0;
         this._lblWinHonour.text = "";
         this._lblWinDisgrace.text = "";
         this._lblKama.text = "";
         this._mcDeadHead._visible = false;
         this._mcItems.removeMovieClip();
      }
   }
   function init()
   {
      super.init(false);
      this._mcItemPlacer._visible = false;
      this._pbHonour._visible = false;
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
      this._pbHonour.enabled = true;
      this._pbHonour.addEventListener("over",this);
      this._pbHonour.addEventListener("out",this);
      this._pbDisgrace.enabled = true;
      this._pbDisgrace.addEventListener("over",this);
      this._pbDisgrace.addEventListener("out",this);
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
         case this._pbHonour:
         case this._pbDisgrace:
            this._mcList.gapi.showTooltip(oEvent.target.value + " / " + oEvent.target.maximum,oEvent.target,20);
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
