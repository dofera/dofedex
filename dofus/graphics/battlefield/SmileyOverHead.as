class dofus.graphics.battlefield.SmileyOverHead extends MovieClip
{
   function SmileyOverHead(nSmileyID)
   {
      super();
      this.draw(nSmileyID);
   }
   function __get__height()
   {
      return 20;
   }
   function __get__width()
   {
      return 20;
   }
   function draw(nSmileyID)
   {
      this.attachMovie("Loader","_ldrSmiley",10,{_x:-10,_width:20,_height:20,scaleContent:true,contentPath:dofus.Constants.SMILEYS_ICONS_PATH + nSmileyID + ".swf"});
   }
}
