class dofus.sounds.AudioElement extends Sound implements com.ankamagames.interfaces.IDisposable
{
	static var INFINITE_LOOP = 999999;
	static var ONESHOT_SAMPLE = 1;
	static var UNLIMITED_LENGTH = 0;
	var _nVolumeBeforeMute = -1;
	function AudioElement(uniqID, §\x0f\t§, linkedClip, §\x1e\x0e\x11§)
	{
		if(uniqID == undefined)
		{
			return undefined;
		}
		if(loc4 == undefined)
		{
			return undefined;
		}
		if(linkedClip == undefined)
		{
			return undefined;
		}
		this._nUniqID = uniqID;
		this._mcLinkedClip = linkedClip;
		this._sFile = loc4;
		this._bStreaming = loc6 == undefined?false:loc6;
		super(linkedClip);
		this._bLoading = true;
		if(dofus.Constants.USING_PACKED_SOUNDS)
		{
			super.attachSound(loc4.substr(3));
			this.onLoad(true);
		}
		else
		{
			super.loadSound(loc4,this._bStreaming);
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
	function __set__volume(loc2)
	{
		if(loc3 < 0 || loc3 > 100)
		{
			return undefined;
		}
		if(!this._bMute && super.setVolume != undefined)
		{
			super.setVolume(loc3);
		}
		else if(super.setVolume != undefined)
		{
			super.setVolume(0);
			this._nVolumeBeforeMute = loc3;
		}
		return this.__get__volume();
	}
	function __get__mute()
	{
		return this._bMute;
	}
	function __set__mute(loc2)
	{
		this._bMute = loc3;
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
	function __set__loops(loc2)
	{
		if(loc2 < dofus.sounds.AudioElement.ONESHOT_SAMPLE || loc2 > dofus.sounds.AudioElement.INFINITE_LOOP)
		{
			return undefined;
		}
		this._nLoops = loc2;
		return this.__get__loops();
	}
	function __get__offset()
	{
		return this._nOffset;
	}
	function __set__offset(loc2)
	{
		if(loc2 < 0 || this._nMaxLength != null && loc2 > this._nMaxLength)
		{
			return undefined;
		}
		this._nOffset = loc2;
		return this.__get__offset();
	}
	function __get__maxLength()
	{
		return this._nMaxLength;
	}
	function __set__maxLength(loc2)
	{
		if(loc2 < 0)
		{
			return undefined;
		}
		this._nMaxLength = loc2;
		return this.__get__maxLength();
	}
	function dispose(loc2)
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
	function setVolume(loc2)
	{
		this.volume = loc2;
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
	function fadeOut(loc2, loc3)
	{
		var volume = this.volume;
		var t = volume / loc3 / dofus.Constants.AVERAGE_FRAMES_PER_SECOND;
		var myself = this._mcLinkedClip;
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
		var loc2 = "[AudioElement = " + this._nUniqID + "]\n";
		loc2 = loc2 + (" > Linked clip  : " + this._mcLinkedClip + "\n");
		loc2 = loc2 + (" > File         : " + this._sFile + "\n");
		loc2 = loc2 + (" > Loops        : " + this._nLoops + "\n");
		loc2 = loc2 + (" > Start offset : " + this._nOffset + "\n");
		loc2 = loc2 + (" > Max length   : " + this._nMaxLength + "\n");
		loc2 = loc2 + (" > Base vol.    : " + this.baseVolume + "\n");
		loc2 = loc2 + (" > Volume       : " + this.getVolume() + "\n");
		loc2 = loc2 + (" > Mute         : " + this._bMute + "\n");
		return loc2;
	}
	function onLoad(loc2)
	{
		if(!loc2)
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
