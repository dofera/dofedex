class dofus.graphics.gapi.controls.SpellInfosViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "SpellInfosViewer";
   function SpellInfosViewer()
   {
      super();
   }
   function __set__spell(oSpell)
   {
      if(oSpell == this._oSpell)
      {
         return undefined;
      }
      this._oSpell = oSpell;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__spell();
   }
   function __get__spell()
   {
      return this._oSpell;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.SpellInfosViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function initData()
   {
      this.updateData();
   }
   function initTexts()
   {
      this._lblEffectsTitle.text = this.api.lang.getText("EFFECTS") + " :";
      this._lblCriticalHitTitle.text = this.api.lang.getText("CRITICAL_HIT") + " :";
      this._lblHelp.text = this.api.lang.getText("HOW_GET_DETAILS");
   }
   function updateData()
   {
      if(this._oSpell != undefined)
      {
         this._lblCriticalHitTitle._visible = this._oSpell.descriptionCriticalHit != undefined;
         this._lblName.text = this._oSpell.name;
         this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oSpell.level;
         this._lblRange.text = (this._oSpell.rangeMin == 0?"":this._oSpell.rangeMin + "-") + this._oSpell.rangeMax + " " + this.api.lang.getText("RANGE");
         this._lblAP.text = this._oSpell.apCost + " " + this.api.lang.getText("AP");
         this._txtDescription.text = this._oSpell.description;
         this._txtEffects.text = this._oSpell.descriptionNormalHit;
         this._txtCriticalHit.text = this._oSpell.descriptionCriticalHit == undefined?"":this._oSpell.descriptionCriticalHit;
         this._ldrIcon.contentPath = this._oSpell.iconFile;
      }
      else if(this._lblName.text != undefined)
      {
         this._lblCriticalHitTitle._visible = false;
         this._lblName.text = "";
         this._lblLevel.text = "";
         this._lblRange.text = "";
         this._lblAP.text = "";
         this._txtDescription.text = "";
         this._txtEffects.text = "";
         this._txtCriticalHit.text = "";
         this._ldrIcon.contentPath = "";
      }
   }
}
