class dofus.datacenter.Title
{
   function Title(id, param)
   {
      this.api = _global.API;
      this._id = id;
      switch(this.api.lang.getTitle(id).pt)
      {
         case 1:
            var _loc4_ = this.api.lang.getTitle(id).t.split("%1").join(this.api.lang.getMonsters()[_global.parseInt(param)].n);
            break;
         case 0:
         default:
            _loc4_ = this.api.lang.getTitle(id).t.split("%1").join(param);
      }
      this._text = "« " + _loc4_ + " »";
      this._color = this.api.lang.getTitle(id).c;
   }
   function __get__color()
   {
      return this._color;
   }
   function __get__text()
   {
      return this._text;
   }
}
