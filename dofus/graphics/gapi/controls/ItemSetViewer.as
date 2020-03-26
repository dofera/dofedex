class dofus.graphics.gapi.controls.ItemSetViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ItemSetViewer";
   static var NO_TRANSFORM = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
   static var INACTIVE_TRANSFORM = {ra:50,rb:0,ga:50,gb:0,ba:50,bb:0};
   function ItemSetViewer()
   {
      super();
   }
   function __set__itemSet(oItemSet)
   {
      this.addToQueue({object:this,method:function(oSet)
      {
         this._oItemSet = oSet;
         if(this.initialized)
         {
            this.updateData();
         }
      },params:[oItemSet]});
      return this.__get__itemSet();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ItemSetViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.updateData});
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      var _loc2_ = 1;
      while(_loc2_ <= 8)
      {
         var _loc3_ = this["_ctr" + _loc2_];
         _loc3_.addEventListener("over",this);
         _loc3_.addEventListener("out",this);
         _loc2_ = _loc2_ + 1;
      }
   }
   function initTexts()
   {
      this._lblEffects.text = this.api.lang.getText("ITEMSET_EFFECTS");
      this._lblItems.text = this.api.lang.getText("ITEMSET_EQUIPED_ITEMS");
   }
   function updateData()
   {
      if(this._oItemSet != undefined)
      {
         var _loc2_ = this._oItemSet.items;
         this._winBg.title = this._oItemSet.name;
         var _loc3_ = this._oItemSet.itemCount != undefined?this._oItemSet.itemCount:8;
         var _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var _loc5_ = _loc2_[_loc4_];
            var _loc6_ = this["_ctr" + (_loc4_ + 1)];
            _loc6_._visible = true;
            _loc6_.contentData = _loc5_.item;
            _loc6_.borderRenderer = !_loc5_.isEquiped?"ItemSetViewerItemBorder":"ItemSetViewerItemBorderNone";
            _loc4_ = _loc4_ + 1;
         }
         this._lstEffects.dataProvider = this._oItemSet.effects;
         var _loc7_ = _loc3_ + 1;
         while(_loc7_ <= 8)
         {
            var _loc8_ = this["_ctr" + _loc7_];
            _loc8_._visible = false;
            _loc7_ = _loc7_ + 1;
         }
         this._visible = true;
      }
      else
      {
         ank.utils.Logger.err("[ItemSetViewer] le set n\'est pas défini");
         this._visible = false;
      }
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_btnClose")
      {
         this.dispatchEvent({type:"close"});
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_ctr1":
         case "_ctr2":
         case "_ctr3":
         case "_ctr4":
         case "_ctr5":
         case "_ctr6":
         case "_ctr7":
         case "_ctr8":
            var _loc3_ = oEvent.target.contentData;
            this.gapi.showTooltip(_loc3_.name,oEvent.target,-20,undefined,_loc3_.style + "ToolTip");
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
