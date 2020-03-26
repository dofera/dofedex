class dofus.sounds.AudioElement extends Sound implements com.ankamagames.interfaces.IDisposable
{
   static var INFINITE_LOOP = 999999;
   static var ONESHOT_SAMPLE = 1;
   static var UNLIMITED_LENGTH = 0;
   var _nVolumeBeforeMute = -1;
   function AudioElement(uniqID, file, linkedClip, streaming)
   {
      if(uniqID == undefined)
      {
         return undefined;
      }
      if(file == undefined)
      {
         return undefined;
      }
      if(linkedClip == undefined)
      {
         return undefined;
      }
      this._nUniqID = uniqID;
      this._mcLinkedClip = linkedClip;
      this._sFile = file;
      this._bStreaming = streaming == undefined?false:streaming;
      super(linkedClip);
      this._bLoading = true;
      if(dofus.Constants.USING_PACKED_SOUNDS)
      {
         super.attachSound(file.substr(3));
         this.onLoad(true);
      }
      else
      {
         super.loadSound(file,this._bStreaming);
      }
   }
   function __get__uniqID()
   {
      return this._nUniqID;
   }
   function __get__linkedClip()
   {
      return this._mcLinkedClip;
   }
   function __get__file()
   {
      return this._sFile;
   }
   function __get__streaming()
   {
      return this._bStreaming;
   }
   function __get__volume()
   {
      return super.getVolume();
   }
   function __set__volume(nValue)
   {
      if(nValue < 0 || nValue > 100)
      {
         return undefined;
      }
      if(!this._bMute && super.setVolume != undefined)
      {
         super.setVolume(nValue);
      }
      else if(super.setVolume != undefined)
      {
         super.setVolume(0);
         this._nVolumeBeforeMute = nValue;
      }
      return this.__get__volume();
   }
   function __get__mute()
   {
      return this._bMute;
   }
   function __set__mute(bValue)
   {
      this._bMute = bValue;
      if(this._bMute && super.setVolume != undefined)
      {
         this._nVolumeBeforeMute = this.volume;
         super.setVolume(0);
      }
      else if(super.setVolume != undefined)
      {
         if(this._nVolumeBeforeMute > 0)
         {
            super.setVolume(this._nVolumeBeforeMute);
         }
      }
      return this.__get__mute();
   }
   function __get__loops()
   {
      return this._nLoops;
   }
   function __set__loops(nValue)
   {
      if(nValue < dofus.sounds.AudioElement.ONESHOT_SAMPLE || nValue > dofus.sounds.AudioElement.INFINITE_LOOP)
      {
         return undefined;
      }
      this._nLoops = nValue;
      return this.__get__loops();
   }
   function __get__offset()
   {
      return this._nOffset;
   }
   function __set__offset(nValue)
   {
      if(nValue < 0 || this._nMaxLength != null && nValue > this._nMaxLength)
      {
         return undefined;
      }
      this._nOffset = nValue;
      return this.__get__offset();
   }
   function __get__maxLength()
   {
      return this._nMaxLength;
   }
   function __set__maxLength(nValue)
   {
      if(nValue < 0)
      {
         return undefined;
      }
      this._nMaxLength = nValue;
      return this.__get__maxLength();
   }
   function dispose(Void)
   {
      this.onKill();
      this._mcLinkedClip.onEnterFrame = null;
      delete this._mcLinkedClip.onEnterFrame;
      this._mcLinkedClip.unloadMovie();
      this._mcLinkedClip.removeMovieClip();
      delete this._mcLinkedClip;
   }
   function getVolume()
   {
      return this.volume;
   }
   function setVolume(nVolume)
   {
      this.volume = nVolume;
   }
   function startElement()
   {
      if(this._bStreaming && !this._bLoading || !this._bStreaming && !this._bLoaded)
      {
         this._bStartWhenLoaded = true;
      }
      else
      {
         if(this._nMaxLength != dofus.sounds.AudioElement.UNLIMITED_LENGTH)
         {
            _global.clearInterval(this._nKillTimer);
            this._nKillTimer = _global.setInterval(this,this.onKill,this._nMaxLength * 1000);
         }
         super.start(this._nOffset,this._nLoops);
      }
   }
   function stop()
   {
      super.stop();
   }
   function fadeOut(nDuration, bAutoDestroy)
   {
      var volume = this.volume;
      var t = volume / nDuration / dofus.Constants.AVERAGE_FRAMES_PER_SECOND;
      var parentElement = this;
      var parent = super;
      var myself = this._mcLinkedClip;
      var destroy = bAutoDestroy;
      this._mcLinkedClip.onEnterFrame = function()
      {
         volume = volume - t;
         parent.setVolume(volume);
         if(volume <= 0)
         {
            parentElement.stop();
            myself.onEnterFrame = undefined;
            delete myself.onEnterFrame;
            if(destroy)
            {
               parentElement.dispose();
            }
         }
      };
   }
   function toString()
   {
      var _loc2_ = "[AudioElement = " + this._nUniqID + "]\n";
      _loc2_ = _loc2_ + (" > Linked clip  : " + this._mcLinkedClip + "\n");
      _loc2_ = _loc2_ + (" > File         : " + this._sFile + "\n");
      _loc2_ = _loc2_ + (" > Loops        : " + this._nLoops + "\n");
      _loc2_ = _loc2_ + (" > Start offset : " + this._nOffset + "\n");
      _loc2_ = _loc2_ + (" > Max length   : " + this._nMaxLength + "\n");
      _loc2_ = _loc2_ + (" > Base vol.    : " + this.baseVolume + "\n");
      _loc2_ = _loc2_ + (" > Volume       : " + this.getVolume() + "\n");
      _loc2_ = _loc2_ + (" > Mute         : " + this._bMute + "\n");
      return _loc2_;
   }
   function onLoad(bSuccess)
   {
      if(!bSuccess)
      {
         return undefined;
      }
      this._bLoaded = true;
      if(this._bStartWhenLoaded)
      {
         this.startElement();
      }
   }
   function onSoundComplete()
   {
      this.dispose();
   }
   function onKill()
   {
      _global.clearInterval(this._nKillTimer);
      this.stop();
   }
}
