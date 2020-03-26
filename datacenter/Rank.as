class dofus.datacenter.Rank extends Object
{
   function Rank(nValue, nHonour, nDisgrace, bEnabled)
   {
      super();
      this.api = _global.API;
      this.initialize(nValue,nHonour,nDisgrace,bEnabled);
   }
   function __get__value()
   {
      return this._nValue;
   }
   function __set__value(v)
   {
      this._nValue = v;
      return this.__get__value();
   }
   function __get__honour()
   {
      return this._nHonour;
   }
   function __set__honour(v)
   {
      this._nHonour = v;
      return this.__get__honour();
   }
   function __get__disgrace()
   {
      return this._nDisgrace;
   }
   function __set__disgrace(v)
   {
      this._nDisgrace = v;
      return this.__get__disgrace();
   }
   function __get__enable()
   {
      return this._bEnabled;
   }
   function __set__enable(v)
   {
      this._bEnabled = v;
      return this.__get__enable();
   }
   function initialize(nValue, nHonour, nDisgrace, bEnabled)
   {
      this._nValue = !(_global.isNaN(nValue) || nValue == undefined)?nValue:0;
      this._nHonour = !(_global.isNaN(nHonour) || nHonour == undefined)?nHonour:0;
      this._nDisgrace = !(_global.isNaN(nDisgrace) || nDisgrace == undefined)?nDisgrace:0;
      this._bEnabled = bEnabled != undefined?bEnabled:false;
   }
   function clone()
   {
      return new dofus.datacenter.Rank(this._nValue,this._nHonour,this._nDisgrace,this._bEnabled);
   }
}
