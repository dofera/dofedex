class dofus.graphics.gapi.ui.Subway extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Subway";
   static var SUBWAY_TYPE_SUBWAY = 1;
   static var SUBWAY_TYPE_PRISM = 2;
   var _nCurrentCategory = 0;
   var _nType = dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY;
   function Subway()
   {
      super();
   }
   function __set__data(eaData)
   {
      this.addToQueue({object:this,method:function(d)
      {
         this._eaData = d;
         if(this.initialized)
         {
            this.initData();
         }
      },params:[eaData]});
      return this.__get__data();
   }
   function __set__type(type)
   {
      this._nType = type;
      return this.__get__type();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Subway.CLASS_NAME);
   }
   function callClose()
   {
      switch(this._nType)
      {
         case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY:
            this.api.network.Subway.leave();
            break;
         case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM:
            this.api.network.Subway.prismLeave();
      }
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
   }
   function initTexts()
   {
      switch(this._nType)
      {
         case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY:
            this._winBg.title = this.api.lang.getText("SUBWAY_LIST");
            this._lblPrismNotice._visible = false;
            this._lblDescription._visible = true;
            break;
         case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM:
            this._winBg.title = this.api.lang.getText("PRISM_LIST");
            this._lblPrismNotice._visible = true;
            this._lblDescription._visible = false;
            this._lblPrismNotice.text = this.api.lang.getText("PRISM_NOTICE");
      }
      this._lblCoords.text = this.api.lang.getText("COORDINATES_SMALL");
      this._lblName.text = this.api.lang.getText("PLACE");
      this._lblCost.text = this.api.lang.getText("COST");
      this._lblDescription.text = this.api.lang.getText("CLICK_ON_WAYPOINT");
      this._btnClose2.label = this.api.lang.getText("CLOSE");
      switch(this._nType)
      {
         case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY:
            for(var a in this._eaData)
            {
               var _loc2_ = new Object();
               _loc2_._y = this._mcTabPlacer._y;
               _loc2_._height = 20;
               _loc2_.backgroundDown = "ButtonTabDown";
               _loc2_.backgroundUp = "ButtonTabUp";
               _loc2_.styleName = "BrownTabButton";
               _loc2_.toggle = true;
               _loc2_.selected = true;
               _loc2_.enabled = true;
               _loc2_.label = " " + this._eaData[a][0].category + " ";
               var _loc3_ = (ank.gapi.controls.Button)this.attachMovie("Button","_btnTab" + a,this.getNextHighestDepth(),_loc2_);
               _loc3_.addEventListener("click",this);
            }
            this.setCurrentTab(0);
            break;
         case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM:
            this._lstSubway.dataProvider = this._eaData;
      }
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnClose2.addEventListener("click",this);
      this._lstSubway.addEventListener("itemSelected",this);
   }
   function initData()
   {
      if(this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
      {
         return undefined;
      }
      if(this._eaData != undefined && this._eaData.length > 0)
      {
         for(var a in this._eaData)
         {
            this.setCurrentTab(Number(a));
            return undefined;
            
            break;
         }
      }
   }
   function updateCurrentTabInformations()
   {
      if(this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
      {
         return undefined;
      }
      this._eaData[this._nCurrentCategory].sortOn("fieldToSort",Array.CASEINSENSITIVE);
      this._lstSubway.dataProvider = this._eaData[this._nCurrentCategory];
   }
   function setCurrentTab(nCategoryID)
   {
      if(this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
      {
         return undefined;
      }
      var _loc3_ = this["_btnTab" + this._nCurrentCategory];
      var _loc4_ = this["_btnTab" + nCategoryID];
      _loc3_.selected = true;
      _loc3_.enabled = true;
      _loc4_.selected = false;
      _loc4_.enabled = false;
      this._nCurrentCategory = nCategoryID;
      this.updateCurrentTabInformations();
      this.setTabsPreferedSize();
   }
   function setTabsPreferedSize()
   {
      if(this._nType != dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY)
      {
         return undefined;
      }
      var _loc2_ = this._mcTabPlacer._x;
      for(var a in this._eaData)
      {
         var _loc3_ = (ank.gapi.controls.Button)this["_btnTab" + a];
         _loc3_._x = _loc2_;
         _loc3_.setPreferedSize();
         _loc2_ = _loc2_ + _loc3_.width;
      }
   }
   function click(oEvent)
   {
      var _loc3_ = oEvent.target._name;
      switch(_loc3_)
      {
         case "_btnClose":
         case "_btnClose2":
            this.callClose();
            break;
         default:
            this.setCurrentTab(Number(_loc3_.substr(7)));
      }
   }
   function itemSelected(oEvent)
   {
      var _loc3_ = oEvent.row.item;
      var _loc4_ = _loc3_.cost;
      if(this.api.datacenter.Player.Kama < _loc4_)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGH_RICH"),"ERROR_BOX");
      }
      else
      {
         switch(this._nType)
         {
            case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_SUBWAY:
               this.api.network.Subway.use(_loc3_.mapID);
               break;
            case dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM:
               this.api.network.Subway.prismUse(_loc3_.mapID);
         }
      }
   }
}
