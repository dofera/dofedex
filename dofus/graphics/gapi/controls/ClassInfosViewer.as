class dofus.graphics.gapi.controls.ClassInfosViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ClassInfosViewer";
   function ClassInfosViewer()
   {
      super();
   }
   function __set__classID(nClassID)
   {
      this._nClassID = nClassID;
      this.addToQueue({object:this,method:this.layoutContent});
      return this.__get__classID();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ClassInfosViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
   }
   function initTexts()
   {
      this._lblClassSpells.text = this.api.lang.getText("CLASS_SPELLS");
   }
   function addListeners()
   {
      var _loc2_ = 0;
      while(_loc2_ < 20)
      {
         this["_ctr" + _loc2_].addEventListener("over",this);
         this["_ctr" + _loc2_].addEventListener("out",this);
         this["_ctr" + _loc2_].addEventListener("click",this);
         _loc2_ = _loc2_ + 1;
      }
   }
   function layoutContent()
   {
      var _loc2_ = dofus.Constants.SPELLS_ICONS_PATH;
      var _loc3_ = this.api.lang.getClassText(this._nClassID).s;
      var _loc4_ = 0;
      while(_loc4_ < 20)
      {
         var _loc5_ = this["_ctr" + _loc4_];
         _loc5_.contentPath = _loc2_ + _loc3_[_loc4_] + ".swf";
         _loc5_.params = {spellID:_loc3_[_loc4_]};
         _loc4_ = _loc4_ + 1;
      }
      this._txtDescription.text = this.api.lang.getClassText(this._nClassID).d;
      this.showSpellInfos(_loc3_[0]);
   }
   function showSpellInfos(nSpellID)
   {
      var _loc3_ = this.api.kernel.CharactersManager.getSpellObjectFromData(nSpellID + "~1~");
      if(_loc3_.name == undefined)
      {
         this._lblSpellName.text = "";
         this._lblSpellRange.text = "";
         this._lblSpellAP.text = "";
         this._txtSpellDescription.text = "";
         this._ldrSpellIcon.contentPath = "";
      }
      else if(this._lblSpellName.text != undefined)
      {
         this._lblSpellName.text = _loc3_.name;
         this._lblSpellRange.text = this.api.lang.getText("RANGEFULL") + " : " + _loc3_.rangeStr;
         this._lblSpellAP.text = this.api.lang.getText("ACTIONPOINTS") + " : " + _loc3_.apCost;
         this._txtSpellDescription.text = _loc3_.description + "\n" + _loc3_.descriptionNormalHit;
         this._ldrSpellIcon.contentPath = _loc3_.iconFile;
      }
   }
   function click(oEvent)
   {
      this.showSpellInfos(oEvent.target.params.spellID);
   }
}
