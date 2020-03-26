class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTree extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "AlignmentViewerTree";
   function AlignmentViewerTree()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTree.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
   }
   function initTexts()
   {
      this._lblInfos.text = this.api.lang.getText("ALL_SPECIALIZATIONS");
      this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL");
   }
   function addListeners()
   {
      this._lstTree.addEventListener("itemRollOver",this);
      this._lstTree.addEventListener("itemRollOut",this);
      this._lstTree.addEventListener("itemSelected",this);
   }
   function initData()
   {
      var _loc2_ = this.api.datacenter.Player.specialization;
      var _loc3_ = _loc2_.alignment.index;
      var _loc4_ = _loc2_.index;
      var _loc5_ = _loc2_.order.index;
      var _loc6_ = new Array();
      var _loc7_ = this.api.lang.getAlignmentSpecializations();
      for(var k in _loc7_)
      {
         var _loc8_ = new dofus.datacenter.Specialization(Number(k));
         if(_loc8_.order.index == _loc5_)
         {
            if(_loc8_.description != "null")
            {
               var _loc9_ = _loc8_.alignment;
               var _loc10_ = _loc8_.order;
               var _loc11_ = _loc6_[_loc3_ != _loc9_.index?_loc9_.index + 1:0];
               if(_loc11_ == undefined)
               {
                  _loc11_ = new Array({data:_loc9_,depth:0});
                  _loc6_[_loc3_ != _loc9_.index?_loc9_.index + 1:0] = _loc11_;
               }
               var _loc12_ = _loc11_[_loc10_.index];
               if(_loc12_ == undefined)
               {
                  _loc12_ = new Array({data:_loc10_,depth:1,sortField:-1});
                  _loc11_[_loc10_.index] = _loc12_;
               }
               _loc12_.push({data:_loc8_,depth:2,sortField:_loc9_.value});
            }
         }
      }
      var _loc13_ = new ank.utils.ExtendedArray();
      var _loc14_ = 0;
      while(_loc14_ < _loc6_.length)
      {
         if(_loc6_[_loc14_] != undefined)
         {
            var _loc15_ = new ank.utils.ExtendedArray();
            var _loc16_ = 0;
            while(_loc16_ < _loc6_[_loc14_].length)
            {
               if(_loc6_[_loc14_][_loc16_] != undefined)
               {
                  _loc6_[_loc14_][_loc16_].sortOn("sortField",Array.NUMERIC);
                  _loc15_ = _loc15_.concat(_loc6_[_loc14_][_loc16_]);
               }
               _loc16_ = _loc16_ + 1;
            }
            _loc13_ = _loc13_.concat(_loc15_);
         }
         _loc14_ = _loc14_ + 1;
      }
      this._lstTree.dataProvider = _loc13_;
      if(_loc4_ != undefined)
      {
         var _loc17_ = -1;
         for(var k in _loc13_)
         {
            var _loc18_ = _loc13_[k].data;
            if(_loc18_ instanceof dofus.datacenter.Specialization)
            {
               if(_loc18_.index == _loc4_)
               {
                  _loc17_ = Number(k);
                  break;
               }
            }
         }
         this._lstTree.selectedIndex = _loc17_;
      }
   }
   function itemSelected(oEvent)
   {
      this.gapi.hideTooltip();
      if(oEvent.row.item.data instanceof dofus.datacenter.Specialization)
      {
         this.dispatchEvent({type:"specializationSelected",specialization:oEvent.row.item.data});
      }
      else if(oEvent.row.item.data instanceof dofus.datacenter.Order)
      {
         this.dispatchEvent({type:"orderSelected",order:oEvent.row.item.data});
      }
      else if(oEvent.row.item.data instanceof dofus.datacenter.Alignment)
      {
         this.dispatchEvent({type:"alignementSelected",alignement:oEvent.row.item.data});
      }
      else
      {
         this._lstTree.selectedIndex = -1;
         this.dispatchEvent({type:"itemSelected"});
      }
   }
   function itemRollOver(oEvent)
   {
      var _loc3_ = oEvent.target.item.data;
      if(_loc3_ instanceof dofus.datacenter.Specialization)
      {
         this.gapi.showTooltip(_loc3_.description,this,this.__height + 30);
      }
   }
   function itemRollOut(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
