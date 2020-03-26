class dofus.graphics.gapi.ui.chooseserver.ChooseServerListItem extends ank.gapi.core.UIBasicComponent
{
   function ChooseServerListItem()
   {
      super();
   }
   function __set__list(mcList)
   {
      this._mcList = mcList;
      return this.__get__list();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      var _loc5_ = this._mcList._parent._parent.api;
      if(bUsed)
      {
         this._oItem = oItem;
         oItem.sortFlag = oItem.language;
         oItem.sortName = oItem.label;
         oItem.sortType = oItem.type;
         oItem.sortOnline = oItem.stateStrShort;
         oItem.sortCommunity = oItem.communityStr;
         oItem.sortPopulation = oItem.population;
         var _loc6_ = new String();
         switch(oItem.community)
         {
            case 0:
               _loc6_ = "fr";
               break;
            case 1:
               _loc6_ = "en";
               break;
            case 3:
               _loc6_ = "de";
               break;
            case 4:
               _loc6_ = "es";
               break;
            case 5:
               _loc6_ = "ru";
               break;
            case 6:
               _loc6_ = "pt";
               break;
            case 7:
               _loc6_ = "nl";
               break;
            case 8:
               _loc6_ = "jp";
               break;
            case 9:
               _loc6_ = "it";
               break;
            case 2:
            default:
               _loc6_ = "us";
         }
         this._ldrFlag.contentPath = "Flag_" + _loc6_;
         this._lblName.text = oItem.sortName;
         this._lblCommunity.text = oItem.sortCommunity;
         switch(oItem.state)
         {
            case dofus.datacenter.Server.SERVER_OFFLINE:
               this._lblOnline.styleName = "RedCenterSmallLabel";
               break;
            case dofus.datacenter.Server.SERVER_ONLINE:
               this._lblOnline.styleName = "GreenCenterSmallLabel";
               break;
            default:
               this._lblOnline.styleName = "BrownCenterSmallLabel";
         }
         this._lblOnline.text = oItem.sortOnline;
         switch(oItem.sortPopulation)
         {
            case 0:
               this._lblPopulation.styleName = "GreenCenterSmallLabel";
               break;
            case 1:
               this._lblPopulation.styleName = "BlueCenterSmallLabel";
               break;
            case 2:
               this._lblPopulation.styleName = "RedCenterSmallLabel";
               break;
            default:
               this._lblPopulation.styleName = "BrownCenterSmallLabel";
         }
         this._lblPopulation.text = oItem.populationStr;
         this._lblType.text = oItem.type;
         if(oItem.typeNum == dofus.datacenter.Server.SERVER_HARDCORE)
         {
            this._lblName.styleName = "RedLeftSmallLabel";
            this._lblType.styleName = "RedCenterSmallLabel";
            this._mcHeroic._visible = true;
         }
         else
         {
            this._lblName.styleName = "BrownLeftSmallLabel";
            this._lblType.styleName = "BrownCenterSmallLabel";
            this._mcHeroic._visible = false;
         }
      }
      else if(this._lblName.text != undefined)
      {
         this._ldrFlag.contentPath = "";
         this._lblName.text = "";
         this._lblType.text = "";
         this._lblOnline.text = "";
         this._lblCommunity.text = "";
         this._lblPopulation.text = "";
         this._mcHeroic._visible = false;
      }
   }
   function init()
   {
      super.init(false);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
   }
   function over()
   {
      if(!this._oItem.friendCharactersCount)
      {
         return undefined;
      }
      var _loc2_ = this._mcList.gapi.api;
      var _loc3_ = ank.utils.PatternDecoder.combine(_loc2_.lang.getText("A_POSSESS_CHARACTER",[this._oItem.search,this._oItem.friendCharactersCount]),null,this._oItem.friendCharactersCount == 1);
      _loc2_.ui.showTooltip(_loc3_,this._mcOver,-20);
   }
   function out(oEvent)
   {
      this._mcList.gapi.api.ui.hideTooltip();
   }
}
