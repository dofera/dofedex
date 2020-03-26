class dofus.graphics.gapi.core.DofusAdvancedComponent extends ank.gapi.core.UIAdvancedComponent
{
   function DofusAdvancedComponent()
   {
      super();
   }
   function __get__api()
   {
      return _global.API;
   }
   function __set__api(a)
   {
      super.__set__api(a);
      return this.__get__api();
   }
   function init(bDontHideBoundingBox, sClassName)
   {
      super.init(bDontHideBoundingBox,sClassName);
   }
}
