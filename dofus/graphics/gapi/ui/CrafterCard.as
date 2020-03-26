class dofus.graphics.gapi.ui.CrafterCard extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "CrafterCard";
   function CrafterCard()
   {
      super();
      this._bInit = false;
   }
   function __set__crafter(oCrafter)
   {
      this._oCrafter = oCrafter;
      if(this._bInit)
      {
         this.updateData();
      }
      return this.__get__crafter();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.CrafterCard.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.updateData});
   }
   function initTexts()
   {
      this._winBg.title = this.api.lang.getText("CRAFTER");
      this._btnClose2.label = this.api.lang.getText("CLOSE");
      this._btnPrivateMessage.label = this.api.lang.getText("WISPER_MESSAGE");
      this._btnLocate.label = this.api.lang.getText("LOCATE");
      this._lblName.text = this.api.lang.getText("NAME_BIG");
      this._lblJob.text = this.api.lang.getText("CRAFT");
      this._lblJobLevel.text = this.api.lang.getText("JOB_LEVEL");
      this._lblLocalization.text = this.api.lang.getText("LOCALISATION");
      this._lblSubarea.text = this.api.lang.getText("SUBAREA");
      this._lblWorkshop.text = this.api.lang.getText("IN_WORKSHOP");
      this._lblCoord.text = this.api.lang.getText("COORDINATES");
      this._lblJobOptions.text = this.api.lang.getText("JOB_OPTIONS");
      this._lbNotFree.text = this.api.lang.getText("NOT_FREE");
      this._lblFreeIfFailed.text = this.api.lang.getText("FREE_IF_FAILED");
      this._lblRessourcesNeeded.text = this.api.lang.getText("CRAFT_RESSOURCES_NEEDED");
      this._lblMinSlots.text = this.api.lang.getText("MIN_ITEM_IN_RECEIPT");
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnClose2.addEventListener("click",this);
      this._btnLocate.addEventListener("click",this);
      this._btnPrivateMessage.addEventListener("click",this);
      this._ldrSprite.addEventListener("initialization",this);
   }
   function updateData()
   {
      this._bInit = true;
      var _loc2_ = true;
      if(this._oCrafter != undefined)
      {
         this._ldrSprite.forceNextLoad();
         this._ldrSprite.contentPath = this._oCrafter.gfxFile != undefined?this._oCrafter.gfxFile:"";
         this.api.colors.addSprite(this._ldrSprite,this._oCrafter);
         this._lblNameValue.text = this._oCrafter.name;
         this._lblJobValue.text = this._oCrafter.job.name;
         this._lblJobLevelValue.text = this._oCrafter.job.level.toString();
         this._lblSubareaValue.text = this._oCrafter.subarea != undefined?this._oCrafter.subarea:this.api.lang.getText("OUTSIDE_WORKSHOP");
         this._lblWorkshopValue.text = !this._oCrafter.inWorkshop?this.api.lang.getText("NO"):this.api.lang.getText("YES");
         var _loc3_ = this._oCrafter.coord;
         this._lblCoordValue.text = _loc3_ != undefined?_loc3_.x + "," + _loc3_.y:"-";
         var _loc4_ = this._oCrafter.job.options;
         this._btnNotFree.selected = _loc4_.isNotFree;
         this._btnFreeIfFailed.selected = _loc4_.isFreeIfFailed;
         this._btnRessourcesNeeded.selected = _loc4_.ressourcesNeeded;
         this._lblMinSlotsValue.text = _loc4_.minSlots.toString();
         _loc2_ = this._oCrafter.subarea != undefined;
      }
      else
      {
         this._ldrSprite.contentPath = "";
         this._lblNameValue.text = "-";
         this._lblJobValue.text = "-";
         this._lblJobLevelValue.text = "-";
         this._lblSubareaValue.text = "-";
         this._lblWorkshopValue.text = "-";
         this._lblCoordValue.text = "-";
         this._lblMinSlotsValue.text = "-";
         this._btnNotFree.selected = false;
         this._btnFreeIfFailed.selected = false;
         this._btnRessourcesNeeded.selected = false;
         this._lblMinSlotsValue.text = "-";
         _loc2_ = false;
      }
      this._btnLocate._visible = _loc2_;
   }
   function initialization(oEvent)
   {
      var _loc3_ = oEvent.target.content;
      _loc3_.attachMovie("staticF","anim",10);
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose2":
         case "_btnClose":
            this.unloadThis();
            break;
         case "_btnPrivateMessage":
            this.api.kernel.GameManager.askPrivateMessage(this._oCrafter.name);
            break;
         case "_btnLocate":
            var _loc3_ = this._oCrafter.coord;
            this.api.kernel.GameManager.updateCompass(_loc3_.x,_loc3_.y,true);
      }
   }
}
