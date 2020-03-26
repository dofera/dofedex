class dofus.graphics.gapi.controls.SpellBoostViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "SpellBoostViewer";
   function SpellBoostViewer()
   {
      super();
   }
   function __set__spell(oSpell)
   {
      this._oSpell = oSpell;
      if(this.initialized)
      {
         this.initData();
      }
      return this.__get__spell();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.SpellBoostViewer.CLASS_NAME);
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
      this._lblNew.text = this.api.lang.getText("NEW_CHARACTERISTICS");
   }
   function updateData()
   {
      if(this._oSpell != undefined)
      {
         this._ldrIcon.contentPath = this._oSpell.iconFile;
         this._lblName.text = this._oSpell.name;
         this._lblLevel1.text = this.api.lang.getText("LEVEL") + " " + this._oSpell.level;
         this._lblAP1.text = this._oSpell.apCost + " " + this.api.lang.getText("AP");
         this._lblRange1.text = this._oSpell.rangeStr + " " + this.api.lang.getText("RANGE");
         this._txtDamages1.text = this._oSpell.descriptionNormalHit;
         this._txtCritical1.text = this._oSpell.descriptionCriticalHit != undefined?this._oSpell.descriptionCriticalHit:"";
         this._mcArrowCritical._visible = this._oSpell.descriptionCriticalHit != undefined;
         this._oSpell.level = this._oSpell.level + 1;
         this._lblLevel2.text = this.api.lang.getText("LEVEL") + " " + this._oSpell.level;
         this._lblAP2.text = this._oSpell.apCost + " " + this.api.lang.getText("AP");
         this._lblRange2.text = this._oSpell.rangeStr + " " + this.api.lang.getText("RANGE");
         this._txtDamages2.text = this._oSpell.descriptionNormalHit;
         this._txtCritical2.text = this._oSpell.descriptionCriticalHit != undefined?this._oSpell.descriptionCriticalHit:"";
         this._oSpell.level = this._oSpell.level - 1;
      }
   }
}
