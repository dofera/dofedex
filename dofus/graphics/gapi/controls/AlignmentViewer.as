class dofus.graphics.gapi.controls.AlignmentViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "AlignmentViewer";
   var _sCurrentTab = "Specialization";
   function AlignmentViewer()
   {
      super();
   }
   function __set__enable(b)
   {
      this._lblAlignment._visible = b;
      this._pbAlignment._visible = b;
      this._mcAlignment._visible = b;
      return this.__get__enable();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.AlignmentViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this._pbAlignment._visible = false;
      this._lblAlignment._visible = false;
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
   }
   function initTexts()
   {
      this._lblTitle.text = this.api.lang.getText("ALIGNMENT");
      this._lblAlignment.text = this.api.lang.getText("LEVEL");
   }
   function addListeners()
   {
      this.api.datacenter.Player.addEventListener("alignmentChanged",this);
   }
   function initData()
   {
      this._sCurrentTab = "Specialization";
      this.alignmentChanged({alignment:this.api.datacenter.Player.alignment});
   }
   function updateCurrentTabInformations()
   {
      this._mcTab.removeMovieClip();
      switch(this._sCurrentTab)
      {
         case "Specialization":
            this.attachMovie("SpecializationViewer","_mcTab",this.getNextHighestDepth(),{_x:this._mcTabPlacer._x,_y:this._mcTabPlacer._y});
            break;
         case "Rank":
            this.attachMovie("RankViewer","_mcTab",this.getNextHighestDepth(),{_x:this._mcTabPlacer._x,_y:this._mcTabPlacer._y});
      }
   }
   function setCurrentTab(sNewTab)
   {
      var _loc3_ = this["_btnTab" + this._sCurrentTab];
      var _loc4_ = this["_btnTab" + sNewTab];
      _loc3_.selected = true;
      _loc3_.enabled = true;
      _loc4_.selected = false;
      _loc4_.enabled = false;
      this._sCurrentTab = sNewTab;
      this.updateCurrentTabInformations();
   }
   function alignmentChanged(oEvent)
   {
      this._mcTab.removeMovieClip();
      this._ldrIcon.contentPath = oEvent.alignment.iconFile;
      this._lblTitle.text = this.api.lang.getText("ALIGNMENT") + " " + oEvent.alignment.name;
      if(this.api.datacenter.Player.alignment.index != 0)
      {
         this.enable = true;
         this._lblNoAlignement.text = "";
         this._pbAlignment.value = oEvent.alignment.value;
         this._mcAlignment.onRollOver = function()
         {
            this._parent.gapi.showTooltip(new ank.utils.ExtendedString(oEvent.alignment.value).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.ExtendedString(this._parent._pbAlignment.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
         };
         this._mcAlignment.onRollOut = function()
         {
            this._parent.gapi.hideTooltip();
         };
         this.setCurrentTab(this._sCurrentTab);
      }
      else if(this._lblNoAlignement.text != undefined)
      {
         this.enable = false;
         this._lblNoAlignement.text = this.api.lang.getText("NO_ALIGNEMENT");
      }
   }
}
