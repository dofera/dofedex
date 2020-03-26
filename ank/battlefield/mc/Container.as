class ank.battlefield.mc.Container extends MovieClip
{
   function Container(b, d, ofile)
   {
      super();
      if(b != undefined)
      {
         this.initialize(b,d,ofile);
      }
   }
   function initialize(b, d, ofile)
   {
      if(d == undefined)
      {
         ank.utils.Logger.err("pas de _oDatacenter !");
      }
      this._mcBattlefield = b;
      this._oDatacenter = d;
      this._sObjectsFile = ofile;
      this.clear(true);
   }
   function clear(bForceReload)
   {
      this.maxDepth = 0;
      this.minDepth = -1000;
      this.zoom(100);
      if(this.ExternalContainer == undefined || bForceReload)
      {
         this.createEmptyMovieClip("ExternalContainer",100);
         var _loc3_ = new MovieClipLoader();
         _loc3_.addListener(this._parent);
         if(bForceReload)
         {
            this.ExternalContainer.clear();
         }
         _loc3_.loadClip(this._sObjectsFile,this.ExternalContainer);
      }
      else
      {
         this.ExternalContainer.clear();
      }
      this.SpriteInfos.removeMovieClip();
      this.createEmptyMovieClip("SpriteInfos",200);
      this.Points.removeMovieClip();
      this.createEmptyMovieClip("Points",300);
      this.Text.removeMovieClip();
      this.createEmptyMovieClip("Text",400);
      this.OverHead.removeMovieClip();
      this.createEmptyMovieClip("OverHead",500);
      if(!this.LoadManager)
      {
         this.createEmptyMovieClip("LoadManager",600);
      }
   }
   function applyMask(bFilled)
   {
      var _loc3_ = this._oDatacenter.Map.width - 1;
      var _loc4_ = this._oDatacenter.Map.height - 1;
      if(bFilled == undefined)
      {
         bFilled = true;
      }
      this.createEmptyMovieClip("_mcMask",10);
      if(bFilled)
      {
         this._mcMask.beginFill(0);
         this._mcMask.moveTo(0,0);
         this._mcMask.lineTo(_loc3_ * ank.battlefield.Constants.CELL_WIDTH,0);
         this._mcMask.lineTo(_loc3_ * ank.battlefield.Constants.CELL_WIDTH,_loc4_ * ank.battlefield.Constants.CELL_HEIGHT);
         this._mcMask.lineTo(0,_loc4_ * ank.battlefield.Constants.CELL_HEIGHT);
         this._mcMask.lineTo(0,0);
         this._mcMask.endFill();
      }
      else
      {
         this._mcMask.beginFill(0);
         this._mcMask.moveTo(-1000,-1000);
         this._mcMask.lineTo(-1000,-999);
         this._mcMask.lineTo(-999,-999);
         this._mcMask.lineTo(-999,-1000);
         this._mcMask.lineTo(-1000,-1000);
         this._mcMask.endFill();
      }
      this.setMask(this._mcMask);
   }
   function adjusteMap(Void)
   {
      this.zoomMap();
      this.center();
   }
   function setColor(oTransform)
   {
      if(oTransform == undefined)
      {
         oTransform = new Object();
         oTransform.ra = 100;
         oTransform.rb = 0;
         oTransform.ga = 100;
         oTransform.gb = 0;
         oTransform.ba = 100;
         oTransform.bb = 0;
      }
      var _loc3_ = new Color(this);
      _loc3_.setTransform(oTransform);
   }
   function zoom(zFactor)
   {
      this._xscale = zFactor;
      this._yscale = zFactor;
   }
   function getZoom()
   {
      return this._xscale;
   }
   function setXY(x, y)
   {
      this._x = x;
      this._y = y;
   }
   function center(Void)
   {
      var _loc3_ = this._xscale / 100;
      var _loc4_ = this._yscale / 100;
      var _loc5_ = (this._mcBattlefield.screenWidth - ank.battlefield.Constants.CELL_WIDTH * _loc3_ * (this._oDatacenter.Map.width - 1)) / 2;
      var _loc6_ = (this._mcBattlefield.screenHeight - ank.battlefield.Constants.CELL_HEIGHT * _loc4_ * (this._oDatacenter.Map.height - 1)) / 2;
      this.setXY(_loc5_,_loc6_);
   }
   function zoomMap(Void)
   {
      var _loc3_ = this.getZoomFactor();
      if(_loc3_ == 100)
      {
         return false;
      }
      this.zoom(_loc3_,false);
      return true;
   }
   function getZoomFactor(Void)
   {
      var _loc3_ = this._oDatacenter.Map.width;
      var _loc4_ = this._oDatacenter.Map.height;
      var _loc5_ = 0;
      if(_loc3_ <= ank.battlefield.Constants.DEFAULT_MAP_WIDTH)
      {
         return 100;
      }
      if(_loc4_ <= ank.battlefield.Constants.DEFAULT_MAP_HEIGHT)
      {
         return 100;
      }
      if(_loc4_ > _loc3_)
      {
         _loc5_ = this._mcBattlefield.screenWidth / (ank.battlefield.Constants.CELL_WIDTH * (_loc3_ - 1)) * 100;
      }
      else
      {
         _loc5_ = this._mcBattlefield.screenHeight / (ank.battlefield.Constants.CELL_HEIGHT * (_loc4_ - 1)) * 100;
      }
      return _loc5_;
   }
}
