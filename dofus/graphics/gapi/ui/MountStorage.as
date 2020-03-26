class dofus.graphics.gapi.ui.MountStorage extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "MountStorage";
   static var FROM_SHED = 0;
   static var FROM_MOUNTPARK = 1;
   static var FROM_CERTIFICATE = 2;
   static var FROM_INVENTORY = 3;
   function MountStorage()
   {
      super();
   }
   function __set__mounts(eaMount)
   {
      this._eaMount.removeEventListener("modelChanged",this);
      this._eaMount = eaMount;
      this._eaMount.addEventListener("modelChanged",this);
      if(this.initialized)
      {
         this.modelChanged({target:this._eaMount});
      }
      return this.__get__mounts();
   }
   function __get__mounts()
   {
      return this._eaMount;
   }
   function __set__parkMounts(eaMount)
   {
      this._eaParkMounts.removeEventListener("modelChanged",this);
      this._eaParkMounts = eaMount;
      this._eaParkMounts.addEventListener("modelChanged",this);
      if(this.initialized)
      {
         this.modelChanged({target:this._eaParkMounts});
      }
      return this.__get__parkMounts();
   }
   function __get__parkMounts()
   {
      return this._eaParkMounts;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.MountStorage.CLASS_NAME);
   }
   function callClose()
   {
      this.api.network.Exchange.leave();
      return true;
   }
   function createChildren()
   {
      this.hideViewersAndButtons();
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.initData});
      this.gapi.unloadLastUIAutoHideComponent();
   }
   function addListeners()
   {
      this.api.datacenter.Player.addEventListener("mountChanged",this);
      this.api.datacenter.Player.Inventory.addEventListener("modelChanged",this);
      this.api.datacenter.Player.mount.addEventListener("nameChanged",this);
      this._cbFilterShed.addEventListener("itemSelected",this);
      this._cbFilterPark.addEventListener("itemSelected",this);
      this._lstCertificate.addEventListener("itemSelected",this);
      this._lstCertificate.addEventListener("itemRollOver",this);
      this._lstCertificate.addEventListener("itemRollOut",this);
      this._lstMountPark.addEventListener("itemSelected",this);
      this._lstMountPark.addEventListener("itemRollOver",this);
      this._lstMountPark.addEventListener("itemRollOut",this);
      this._lstShed.addEventListener("itemSelected",this);
      this._lstShed.addEventListener("itemRollOver",this);
      this._lstShed.addEventListener("itemRollOut",this);
      this._btnClose.addEventListener("click",this);
      this._btnShed.addEventListener("click",this);
      this._btnMountPark.addEventListener("click",this);
      this._btnCertificate.addEventListener("click",this);
      this._btnInventory.addEventListener("click",this);
      this._ldrSprite.addEventListener("initialization",this);
      this._mcRectanglePreview.onRelease = function()
      {
         this._parent.click({target:this._parent._btnInventoryMount});
      };
   }
   function initTexts()
   {
      this._winCertificate.title = this.api.lang.getText("MOUNT_CERTIFICATES");
      this._winMountPark.title = this.api.lang.getText("MOUNT_PARK");
      this._winInventory.title = this.api.lang.getText("MOUNT_INVENTORY");
      this._winShed.title = this.api.lang.getText("MOUNT_SHED");
      this._btnShed.label = this.api.lang.getText("MOUNT_SHED_ACTION");
      this._btnMountPark.label = this.api.lang.getText("MOUNT_PARK_ACTION");
      this._btnCertificate.label = this.api.lang.getText("MOUNT_CERTIFICATE_ACTION");
      this._btnInventory.label = this.api.lang.getText("MOUNT_INVENTORY_ACTION");
      this._lblTitle.text = this.api.lang.getText("MOUNT_MANAGER");
      this._lblInventoryNoMount.text = this.api.lang.getText("MOUNT_NO_EQUIP");
      this.fillTypeCombobox(this._cbFilterShed,this.mounts.concat(this.parkMounts));
      this.fillTypeCombobox(this._cbFilterPark,this.mounts.concat(this.parkMounts));
   }
   function initData()
   {
      this.modelChanged({target:this._eaMount});
      this.modelChanged({target:this._eaParkMounts});
      this.modelChanged({target:this.api.datacenter.Player.Inventory});
      this.mountChanged();
   }
   function createCertificateArray()
   {
      var _loc2_ = new ank.utils.ExtendedArray();
      var _loc3_ = this.api.datacenter.Player.Inventory;
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = _loc3_[_loc4_];
         if(_loc5_.type == 97)
         {
            _loc2_.push(_loc5_);
         }
         _loc4_ = _loc4_ + 1;
      }
      return _loc2_;
   }
   function hideShedButton(bHide)
   {
      this._mcArrowShed._visible = !bHide;
      this._btnShed._visible = !bHide;
   }
   function hideMountParkButton(bHide)
   {
      this._mcArrowMountPark._visible = !bHide;
      this._btnMountPark._visible = !bHide;
   }
   function hideCertificateButton(bHide)
   {
      this._mcArrowCertificate._visible = !bHide;
      this._btnCertificate._visible = !bHide;
   }
   function hideInventoryButton(bHide)
   {
      this._mcArrowInventory._visible = !bHide;
      this._btnInventory._visible = !bHide;
   }
   function hideMountViewer(bHide)
   {
      this._winMountViewer._visible = !bHide;
      this._mvMountViewer._visible = !bHide;
      if(!bHide)
      {
         this.moveTopButtons(0);
         this.moveBottomButtons(0);
      }
   }
   function hideItemViewer(bHide)
   {
      this._winItemViewer._visible = !bHide;
      this._itvItemViewer._visible = !bHide;
      if(!bHide)
      {
         this.moveTopButtons(14);
         this.moveBottomButtons(-13);
      }
   }
   function moveTopButtons(y)
   {
      this._btnInventory._y = 146 + y;
      this._btnShed._y = 146 + y;
   }
   function moveBottomButtons(y)
   {
      this._btnCertificate._y = 383 + y;
      this._btnMountPark._y = 383 + y;
   }
   function hideAllButtons(bHide)
   {
      this.hideShedButton(bHide);
      this.hideMountParkButton(bHide);
      this.hideCertificateButton(bHide);
      this.hideInventoryButton(bHide);
   }
   function hideViewersAndButtons()
   {
      this.hideAllButtons(true);
      this.hideMountViewer(true);
      this.hideItemViewer(true);
   }
   function fillTypeCombobox(cb, eaSrc)
   {
      var _loc4_ = cb.selectedItem.id;
      var _loc5_ = cb.selectedItem.modelID;
      var _loc6_ = !cb.dataProvider.length?new ank.utils.ExtendedArray():cb.dataProvider;
      if(!cb.dataProvider.length)
      {
         _loc6_.push({label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
         _loc6_.push({label:this.api.lang.getText("MOUNT_FILTER_MAN"),id:1});
         _loc6_.push({label:this.api.lang.getText("MOUNT_FILTER_WOMAN"),id:2});
         _loc6_.push({label:this.api.lang.getText("MOUNT_FILTER_FECONDABLE"),id:3});
         _loc6_.push({label:this.api.lang.getText("MOUNT_FILTER_FECONDEE"),id:4});
         _loc6_.push({label:this.api.lang.getText("MOUNT_FILTER_MOUNTABLE"),id:5});
         _loc6_.push({label:this.api.lang.getText("MOUNT_FILTER_NONAME"),id:6});
         _loc6_.push({label:this.api.lang.getText("MOUNT_FILTER_CAPACITY"),id:7});
         _loc6_.push({label:this.api.lang.getText("MOUNT_FILTER_MUSTXP"),id:8});
         _loc6_.push({label:this.api.lang.getText("MOUNT_FILTER_TIRED"),id:9});
         _loc6_.push({label:this.api.lang.getText("MOUNT_FILTER_NOTIRED"),id:10});
      }
      eaSrc.sortOn("modelID");
      for(var i in eaSrc)
      {
         var _loc7_ = false;
         for(var j in _loc6_)
         {
            if(_loc6_[j].modelID == eaSrc[i].modelID)
            {
               _loc7_ = true;
               break;
            }
         }
         if(!_loc7_)
         {
            _loc6_.push({label:eaSrc[i].modelName,id:11,modelID:eaSrc[i].modelID});
         }
      }
      _loc6_.sortOn(["id","modelName"],Array.NUMERIC);
      var _loc8_ = -1;
      for(var i in _loc6_)
      {
         if(_loc6_[i].id == _loc4_ && _loc6_[i].modelID == _loc5_)
         {
            _loc8_ = _global.parseInt(i);
         }
      }
      cb.dataProvider = _loc6_;
      cb.selectedIndex = _loc8_ == -1?0:_loc8_;
   }
   function makeDataProvider(eaSrc, cbFilter)
   {
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = cbFilter.selectedItem.id;
      switch(_loc5_)
      {
         case 0:
            _loc4_ = eaSrc;
            break;
         case 1:
            for(var i in eaSrc)
            {
               if(!eaSrc[i].sex)
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
            break;
         case 2:
            for(var i in eaSrc)
            {
               if(eaSrc[i].sex)
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
            break;
         case 3:
            for(var i in eaSrc)
            {
               if(eaSrc[i].fecondable && eaSrc[i].fecondation == -1)
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
            break;
         case 4:
            for(var i in eaSrc)
            {
               if(eaSrc[i].fecondation > 0)
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
            break;
         case 5:
            for(var i in eaSrc)
            {
               if(eaSrc[i].mountable)
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
            break;
         case 6:
            for(var i in eaSrc)
            {
               if(eaSrc[i].name == this.api.lang.getText("NO_NAME"))
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
            break;
         case 7:
            for(var i in eaSrc)
            {
               if(eaSrc[i].capacities.length > 0)
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
            break;
         case 8:
            for(var i in eaSrc)
            {
               if(eaSrc[i].mountable && eaSrc[i].level < 5)
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
            break;
         case 9:
            for(var i in eaSrc)
            {
               if(eaSrc[i].tired == eaSrc[i].tiredMax)
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
            break;
         case 10:
            for(var i in eaSrc)
            {
               if(eaSrc[i].tired < eaSrc[i].tiredMax)
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
            break;
         case 11:
            for(var i in eaSrc)
            {
               if(eaSrc[i].modelID == cbFilter.selectedItem.modelID)
               {
                  _loc4_.push(eaSrc[i]);
               }
            }
      }
      return _loc4_;
   }
   function initialization(oEvent)
   {
      var _loc3_ = oEvent.target.content;
      _loc3_.attachMovie("staticR_front","anim_front",11);
      _loc3_.attachMovie("staticR_back","anim_back",10);
   }
   function mountChanged(oEvent)
   {
      this.hideViewersAndButtons();
      var _loc3_ = this.api.datacenter.Player.mount;
      var _loc4_ = _loc3_ != undefined;
      if(_loc4_)
      {
         this._lblInventoryMountModel.text = _loc3_.modelName;
         this._lblInventoryMountName.text = _loc3_.name;
         this._ldrSprite.forceNextLoad();
         this._ldrSprite.contentPath = _loc3_.gfxFile;
         var _loc5_ = new ank.battlefield.datacenter.Sprite("-1",undefined,"",0,0);
         _loc5_.mount = _loc3_;
         this.api.colors.addSprite(this._ldrSprite,_loc5_);
      }
      this._lblInventoryNoMount._visible = !_loc4_;
      this._lblInventoryMountModel._visible = _loc4_;
      this._lblInventoryMountName._visible = _loc4_;
      this._ldrSprite._visible = _loc4_;
      this._mcRectanglePreview._visible = _loc4_;
   }
   function modelChanged(oEvent)
   {
      this.hideViewersAndButtons();
      switch(oEvent.target)
      {
         case this._eaMount:
            this._lstShed.dataProvider = this.makeDataProvider(this._eaMount,this._cbFilterShed);
            this._lstShed.sortOn("modelID");
            this.fillTypeCombobox(this._cbFilterShed,this.mounts.concat(this.parkMounts));
            this.fillTypeCombobox(this._cbFilterPark,this.mounts.concat(this.parkMounts));
            break;
         case this._eaParkMounts:
            this._lstMountPark.dataProvider = this.makeDataProvider(this._eaParkMounts,this._cbFilterPark);
            this._lstShed.sortOn("modelID");
            this.fillTypeCombobox(this._cbFilterShed,this.mounts.concat(this.parkMounts));
            this.fillTypeCombobox(this._cbFilterPark,this.mounts.concat(this.parkMounts));
            break;
         case this.api.datacenter.Player.Inventory:
            this._lstCertificate.dataProvider = this.createCertificateArray();
      }
   }
   function click(oEvent)
   {
      var _loc3_ = this.api.network.Exchange;
      switch(oEvent.target)
      {
         case this._btnClose:
            this.callClose();
            break;
         case this._btnInventoryMount:
            this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY;
            this._mvMountViewer.mount = this.api.datacenter.Player.mount;
            this.hideAllButtons(false);
            this.hideItemViewer(true);
            this.hideMountViewer(false);
            this.hideInventoryButton(true);
            break;
         case this._btnShed:
            switch(this._nSelectFrom)
            {
               case dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE:
                  _loc3_.putInShedFromCertificate(this._itvItemViewer.itemData.ID);
                  break;
               case dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK:
                  _loc3_.putInShedFromMountPark(this._mvMountViewer.mount.ID);
                  break;
               case dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY:
                  _loc3_.putInShedFromInventory(this.api.datacenter.Player.mount.ID);
            }
            break;
         case this._btnInventory:
            switch(this._nSelectFrom)
            {
               case dofus.graphics.gapi.ui.MountStorage.FROM_SHED:
                  _loc3_.putInInventoryFromShed(this._mvMountViewer.mount.ID);
                  break;
               case dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK:
                  _loc3_.putInShedFromMountPark(this._mvMountViewer.mount.ID);
                  _loc3_.putInInventoryFromShed(this._mvMountViewer.mount.ID);
                  break;
               case dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE:
            }
            break;
         case this._btnMountPark:
            switch(this._nSelectFrom)
            {
               case dofus.graphics.gapi.ui.MountStorage.FROM_SHED:
                  _loc3_.putInMountParkFromShed(this._mvMountViewer.mount.ID);
                  break;
               case dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE:
                  break;
               case dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY:
                  _loc3_.putInShedFromInventory(this._mvMountViewer.mount.ID);
                  _loc3_.putInMountParkFromShed(this._mvMountViewer.mount.ID);
            }
            break;
         case this._btnCertificate:
            switch(this._nSelectFrom)
            {
               case dofus.graphics.gapi.ui.MountStorage.FROM_SHED:
                  _loc3_.putInCertificateFromShed(this._mvMountViewer.mount.ID);
                  break;
               case dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK:
                  _loc3_.putInShedFromMountPark(this._mvMountViewer.mount.ID);
                  _loc3_.putInCertificateFromShed(this._mvMountViewer.mount.ID);
                  break;
               case dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY:
                  _loc3_.putInShedFromInventory(this._mvMountViewer.mount.ID);
                  _loc3_.putInCertificateFromShed(this._mvMountViewer.mount.ID);
            }
      }
   }
   function itemSelected(oEvent)
   {
      this.hideAllButtons(false);
      switch(oEvent.target)
      {
         case this._lstShed:
            this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_SHED;
            this._mvMountViewer.mount = oEvent.row.item;
            this.hideItemViewer(true);
            this.hideShedButton(true);
            this.hideMountViewer(false);
            break;
         case this._lstMountPark:
            this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK;
            this._mvMountViewer.mount = oEvent.row.item;
            this.hideItemViewer(true);
            this.hideMountParkButton(true);
            this.hideMountViewer(false);
            break;
         case this._lstCertificate:
            this.hideMountParkButton(true);
            this.hideInventoryButton(true);
            this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE;
            this._itvItemViewer.itemData = oEvent.row.item;
            this.hideCertificateButton(true);
            this.hideMountViewer(true);
            this.hideItemViewer(false);
            break;
         case this._cbFilterShed:
            this._lstShed.dataProvider = this.makeDataProvider(this._eaMount,this._cbFilterShed);
            this.hideViewersAndButtons();
            break;
         case this._cbFilterPark:
            this._lstMountPark.dataProvider = this.makeDataProvider(this._eaParkMounts,this._cbFilterPark);
            this.hideViewersAndButtons();
            break;
         default:
            this.hideViewersAndButtons();
      }
   }
   function itemRollOver(oEvent)
   {
      switch(oEvent.target)
      {
         case this._lstCertificate:
            break;
         case this._lstMountPark:
         case this._lstShed:
            this.gapi.showTooltip(oEvent.row.item.getToolTip(),oEvent.target,20,{bXLimit:true,bYLimit:false});
      }
   }
   function itemRollOut(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function nameChanged(oEvent)
   {
      this._lblInventoryMountName.text = oEvent.name;
   }
}
