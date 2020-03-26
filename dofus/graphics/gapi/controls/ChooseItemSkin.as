class dofus.graphics.gapi.controls.ChooseItemSkin extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ChooseItemSkin";
   function ChooseItemSkin()
   {
      super();
   }
   function __set__item(oItem)
   {
      this._oItem = oItem;
      return this.__get__item();
   }
   function __get__selectedItem()
   {
      return this._oSelectedItem;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ChooseItemSkin.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
   }
   function addListeners()
   {
      this._cgGrid.addEventListener("dblClickItem",this._parent);
      this._cgGrid.addEventListener("selectItem",this);
   }
   function initData()
   {
      var _loc2_ = new ank.utils.ExtendedArray();
      var _loc3_ = 0;
      while(_loc3_ < this._oItem.maxSkin)
      {
         if(this._oItem.isAssociate)
         {
            _loc2_.push(new dofus.datacenter.Item(-1,this._oItem.realUnicId,1,0,"",0,_loc3_,1));
         }
         else
         {
            _loc2_.push(new dofus.datacenter.Item(-1,this._oItem.unicID,1,0,"",0,_loc3_,1));
         }
         _loc3_ = _loc3_ + 1;
      }
      this._cgGrid.dataProvider = _loc2_;
   }
   function selectItem(oEvent)
   {
      this._oSelectedItem = oEvent.target.contentData;
   }
}
