class dofus.graphics.gapi.controls.CraftViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "CraftViewer";
   function CraftViewer()
   {
      super();
   }
   function __set__job(oJob)
   {
      this._oJob = oJob;
      this.addToQueue({object:this,method:this.layoutContent});
      return this.__get__job();
   }
   function __set__skill(oSkill)
   {
      var _loc3_ = new ank.utils.ExtendedArray();
      _loc3_.push(oSkill);
      this.job = new dofus.datacenter.Job(-1,_loc3_);
      return this.__get__skill();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.CraftViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this._lstCrafts._visible = false;
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function addListeners()
   {
      this._btnSlot0.addEventListener("click",this);
      this._btnSlot1.addEventListener("click",this);
      this._btnSlot2.addEventListener("click",this);
      this._btnSlot3.addEventListener("click",this);
      this._btnSlot4.addEventListener("click",this);
      this._btnSlot5.addEventListener("click",this);
      this._btnSlot6.addEventListener("click",this);
      this._btnSlot7.addEventListener("click",this);
      this._btnSlot0.addEventListener("over",this);
      this._btnSlot1.addEventListener("over",this);
      this._btnSlot2.addEventListener("over",this);
      this._btnSlot3.addEventListener("over",this);
      this._btnSlot4.addEventListener("over",this);
      this._btnSlot5.addEventListener("over",this);
      this._btnSlot6.addEventListener("over",this);
      this._btnSlot7.addEventListener("over",this);
      this._btnSlot0.addEventListener("out",this);
      this._btnSlot1.addEventListener("out",this);
      this._btnSlot2.addEventListener("out",this);
      this._btnSlot3.addEventListener("out",this);
      this._btnSlot4.addEventListener("out",this);
      this._btnSlot5.addEventListener("out",this);
      this._btnSlot6.addEventListener("out",this);
      this._btnSlot7.addEventListener("out",this);
   }
   function initTexts()
   {
      this._lblCrafts.text = this.api.lang.getText("RECEIPTS");
      this._lblFilter.text = this.api.lang.getText("FILTER");
   }
   function layoutContent()
   {
      var _loc2_ = this.api.datacenter.Basics.craftViewer_filter;
      this._btnSlot0.selected = _loc2_[0];
      this._btnSlot1.selected = _loc2_[1];
      this._btnSlot2.selected = _loc2_[2];
      this._btnSlot3.selected = _loc2_[3];
      this._btnSlot4.selected = _loc2_[4];
      this._btnSlot5.selected = _loc2_[5];
      this._btnSlot6.selected = _loc2_[6];
      this._btnSlot7.selected = _loc2_[7];
      if(this._oJob == undefined)
      {
         return undefined;
      }
      var _loc3_ = this._oJob.crafts;
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         var _loc6_ = _loc3_[_loc5_];
         if(_loc2_[_loc6_.itemsCount - 1])
         {
            _loc4_.push(_loc6_);
         }
         _loc5_ = _loc5_ + 1;
      }
      if(_loc4_.length != 0)
      {
         this._lstCrafts._visible = true;
         _loc4_.bubbleSortOn("itemsCount",Array.DESCENDING);
         this._lstCrafts.dataProvider = _loc4_;
         this._lblNoCraft.text = "";
      }
      else
      {
         this._lstCrafts._visible = false;
         this._lblNoCraft.text = this.api.lang.getText("NO_CRAFT_AVAILABLE");
      }
   }
   function craftItem(oItem)
   {
      this._parent.addCraft(oItem.unicID);
   }
   function click(oEvent)
   {
      var _loc3_ = this.api.datacenter.Basics.craftViewer_filter;
      var _loc4_ = Number(oEvent.target._name.substr(8));
      _loc3_[_loc4_] = oEvent.target.selected;
      this.layoutContent();
   }
   function over(oEvent)
   {
      var _loc3_ = Number(oEvent.target._name.substr(8)) + 1;
      this.gapi.showTooltip(this.api.lang.getText("CRAFT_SLOT_FILTER",[_loc3_]),oEvent.target,-20);
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
