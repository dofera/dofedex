class ank.gapi.styles.StylesManager extends Object
{
   static var _styles = new Object();
   function StylesManager()
   {
      super();
   }
   static function setStyle(sStyleName, oStyle)
   {
      if(!(oStyle instanceof Object))
      {
         return undefined;
      }
      if(sStyleName == undefined)
      {
         return undefined;
      }
      if(oStyle == undefined)
      {
         return undefined;
      }
      ank.gapi.styles.StylesManager._styles[sStyleName] = oStyle;
   }
   static function getStyle(sStyleName)
   {
      return ank.gapi.styles.StylesManager._styles[sStyleName];
   }
   static function loadStylePackage(oPackage)
   {
      for(var k in oPackage)
      {
         ank.gapi.styles.StylesManager.setStyle(k,oPackage[k]);
      }
   }
}
