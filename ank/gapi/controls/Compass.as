class ank.gapi.controls.Compass extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "Compass";
   var _bUpdateOnLoad = true;
   var _sBackground = "CompassNormalBackground";
   var _sArrow = "CompassNormalArrow";
   var _sNoArrow = "CompassNormalNoArrow";
   function Compass()
   {
      super();
   }
   function __set__updateOnLoad(bUpdateOnLoad)
   {
      this._bUpdateOnLoad = bUpdateOnLoad;
      return this.__get__updateOnLoad();
   }
   function __get__updateOnLoad()
   {
      return this._bUpdateOnLoad;
   }
   function __set__background(sBackground)
   {
      this._sBackground = sBackground;
      return this.__get__background();
   }
   function __get__background()
   {
      return this._sBackground;
   }
   function __set__arrow(sArrow)
   {
      this._sArrow = sArrow;
      return this.__get__arrow();
   }
   function __get__arrow()
   {
      return this._sArrow;
   }
   function __set__noArrow(sNoArrow)
   {
      this._sNoArrow = sNoArrow;
      return this.__get__noArrow();
   }
   function __get__noArrow()
   {
      return this._sNoArrow;
   }
   function __set__currentCoords(aCurrentCoords)
   {
      this._aCurrentCoords = aCurrentCoords;
      if(this.initialized)
      {
         this.layoutContent();
      }
      return this.__get__currentCoords();
   }
   function __set__targetCoords(aTargetCoords)
   {
      this._aTargetCoords = aTargetCoords;
      if(this.initialized)
      {
         this.layoutContent();
      }
      return this.__get__targetCoords();
   }
   function __get__targetCoords()
   {
      return this._aTargetCoords;
   }
   function __set__allCoords(oAllCoords)
   {
      this._aTargetCoords = oAllCoords.targetCoords;
      this._aCurrentCoords = oAllCoords.currentCoords;
      if(this.initialized)
      {
         this.addToQueue({object:this,method:this.layoutContent});
      }
      return this.__get__allCoords();
   }
   function init()
   {
      super.init(false,ank.gapi.controls.Compass.CLASS_NAME);
   }
   function createChildren()
   {
      this.attachMovie("Loader","_ldrBack",10,{contentPath:this._sBackground,centerContent:false,scaleContent:true});
      this.createEmptyMovieClip("_mcArrow",20);
      this._mcArrow.attachMovie("Loader","_ldrArrow",10,{contentPath:this._sNoArrow,centerContent:false,scaleContent:true});
      if(this._bUpdateOnLoad)
      {
         this.addToQueue({object:this,method:this.layoutContent});
      }
   }
   function size()
   {
      super.size();
      this.arrange();
   }
   function arrange()
   {
      this._ldrBack.setSize(this.__width,this.__height);
      this._mcArrow._x = this.__width / 2;
      this._mcArrow._y = this.__height / 2;
      this._mcArrow._ldrArrow.setSize(this.__width,this.__height);
      this._mcArrow._ldrArrow._x = (- this.__width) / 2;
      this._mcArrow._ldrArrow._y = (- this.__height) / 2;
   }
   function layoutContent()
   {
      if(this._aCurrentCoords == undefined)
      {
         return undefined;
      }
      if(this._aCurrentCoords.length == 0)
      {
         return undefined;
      }
      if(this._aTargetCoords == undefined)
      {
         return undefined;
      }
      if(this._aTargetCoords.length == 0)
      {
         return undefined;
      }
      ank.utils.Timer.removeTimer(this,"compass");
      var _loc2_ = this._aTargetCoords[0] - this._aCurrentCoords[0];
      var _loc3_ = this._aTargetCoords[1] - this._aCurrentCoords[1];
      if(_loc2_ == 0 && _loc3_ == 0)
      {
         this._mcArrow._ldrArrow.contentPath = this._sNoArrow;
         this._mcArrow._ldrArrow.content._rotation = this._mcArrow._rotation;
         this._mcArrow._rotation = 0;
         this.smoothRotation(0,1);
      }
      else
      {
         var _loc4_ = Math.atan2(_loc3_,_loc2_) * (180 / Math.PI);
         this._mcArrow._ldrArrow.contentPath = this._sArrow;
         this._mcArrow._ldrArrow.content._rotation = this._mcArrow._rotation - _loc4_;
         this._mcArrow._rotation = _loc4_;
         this.smoothRotation(_loc4_,1);
      }
   }
   function smoothRotation(nMaxAngle, nSpeed)
   {
      this._mcArrow._ldrArrow.content._rotation = this._mcArrow._ldrArrow.content._rotation + nSpeed;
      nSpeed = (- this._mcArrow._ldrArrow.content._rotation) * 0.2 + nSpeed * 0.7;
      if(Math.abs(nSpeed) > 0.01)
      {
         ank.utils.Timer.setTimer(this,"compass",this,this.smoothRotation,50,[nMaxAngle,nSpeed]);
      }
      else
      {
         this._mcArrow._ldrArrow.content._rotation = 0;
      }
   }
   function onRelease()
   {
      this.dispatchEvent({type:"click"});
   }
   function onReleaseOutside()
   {
      this.onRollOut();
   }
   function onRollOver()
   {
      this.dispatchEvent({type:"over"});
   }
   function onRollOut()
   {
      this.dispatchEvent({type:"out"});
   }
}
