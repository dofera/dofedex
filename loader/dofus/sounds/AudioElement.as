class dofus.sounds.AudioElement extends Sound implements com.ankamagames.interfaces.IDisposable
{
	static var INFINITE_LOOP = 999999;
	static var ONESHOT_SAMPLE = 1;
	static var UNLIMITED_LENGTH = 0;
	var _nVolumeBeforeMute = -1;
	function AudioElement(uniqID, §\x0e\x12§, linkedClip, §\x1e\f\x16§)
	{
		if(uniqID == undefined)
		{
			org.flashdevelop.utils.FlashConnect.mtrace(new com.ankamagames.exceptions.NullPointerException(this,"AudioElement","","uniqID"),"dofus.sounds.AudioElement::AudioElement","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/sounds/AudioElement.as",245);
			return undefined;
		}
		if(var4 == undefined)
		{
			org.flashdevelop.utils.FlashConnect.mtrace(new com.ankamagames.exceptions.NullPointerException(this,"AudioElement","","file"),"dofus.sounds.AudioElement::AudioElement","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/sounds/AudioElement.as",250);
			return undefined;
		}
		if(linkedClip == undefined)
		{
			org.flashdevelop.utils.FlashConnect.mtrace(new com.ankamagames.exceptions.NullPointerException(this,"AudioElement","","linkedClip"),"dofus.sounds.AudioElement::AudioElement","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/sounds/AudioElement.as",255);
			return undefined;
		}
		this._nUniqID = uniqID;
		this._mcLinkedClip = linkedClip;
		this._sFile = var4;
		this._bStreaming = var6 == undefined?false:var6;
		super(linkedClip);
		this._bLoading = true;
		if(dofus.Constants.USING_PACKED_SOUNDS)
		{
			super.attachSound(var4.substr(3));
			this.onLoad(true);
		}
		else
		{
			super.loadSound(var4,this._bStreaming);
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
	function __set__volume(§\x1e\x1b\x17§)
	{
		if(var3 < 0 || var3 > 100)
		{
			org.flashdevelop.utils.FlashConnect.mtrace(new com.ankamagames.exceptions.ValueOutOfRangeException(this,"AudioElement","set volume","nValue",var3,0,100),"dofus.sounds.AudioElement::volume","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/sounds/AudioElement.as",115);
			return undefined;
		}
		if(!this._bMute && super.setVolume != undefined)
		{
			super.setVolume(var3);
		}
		else if(super.setVolume != undefined)
		{
			super.setVolume(0);
			this._nVolumeBeforeMute = var3;
		}
		return this.__get__volume();
	}
	function __get__mute()
	{
		return this._bMute;
	}
	function __set__mute(§\x14\x03§)
	{
		this._bMute = var3;
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
	function __set__loops(§\x1e\x1b\x17§)
	{
		if(var2 < dofus.sounds.AudioElement.ONESHOT_SAMPLE || var2 > dofus.sounds.AudioElement.INFINITE_LOOP)
		{
			org.flashdevelop.utils.FlashConnect.mtrace(new com.ankamagames.exceptions.ValueOutOfRangeException(this,"AudioElement","set loops","nValue",var2,dofus.sounds.AudioElement.ONESHOT_SAMPLE,dofus.sounds.AudioElement.INFINITE_LOOP),"dofus.sounds.AudioElement::loops","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/sounds/AudioElement.as",172);
			return undefined;
		}
		this._nLoops = var2;
		return this.__get__loops();
	}
	function __get__offset()
	{
		return this._nOffset;
	}
	function __set__offset(§\x1e\x1b\x17§)
	{
		if(var2 < 0 || this._nMaxLength != null && var2 > this._nMaxLength)
		{
			org.flashdevelop.utils.FlashConnect.mtrace(new com.ankamagames.exceptions.ValueOutOfRangeException(this,"AudioElement","set offset","nValue",var2,0,this._nMaxLength != null?this._nMaxLength:Number.POSITIVE_INFINITY),"dofus.sounds.AudioElement::offset","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/sounds/AudioElement.as",197);
			return undefined;
		}
		this._nOffset = var2;
		return this.__get__offset();
	}
	function __get__maxLength()
	{
		return this._nMaxLength;
	}
	function __set__maxLength(§\x1e\x1b\x17§)
	{
		if(var2 < 0)
		{
			org.flashdevelop.utils.FlashConnect.mtrace(new com.ankamagames.exceptions.ValueOutOfRangeException(this,"AudioElement","set maxLength","nValue",var2,0,Number.POSITIVE_INFINITY),"dofus.sounds.AudioElement::maxLength","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/sounds/AudioElement.as",222);
			return undefined;
		}
		this._nMaxLength = var2;
		return this.__get__maxLength();
	}
	function dispose(§\x1e\n\f§)
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
	function setVolume(§\x1e\x1b\x12§)
	{
		this.volume = var2;
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
	function fadeOut(§\x06\t§, §\x1c\r§)
	{
		var volume = this.volume;
		var t = volume / var3 / dofus.Constants.AVERAGE_FRAMES_PER_SECOND;
		var parentElement = this;
		var parent = super;
		var myself = this._mcLinkedClip;
		var destroy = var4;
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
		var var2 = "[AudioElement = " + this._nUniqID + "]\n";
		var2 = var2 + (" > Linked clip  : " + this._mcLinkedClip + "\n");
		var2 = var2 + (" > File         : " + this._sFile + "\n");
		var2 = var2 + (" > Loops        : " + this._nLoops + "\n");
		var2 = var2 + (" > Start offset : " + this._nOffset + "\n");
		var2 = var2 + (" > Max length   : " + this._nMaxLength + "\n");
		var2 = var2 + (" > Base vol.    : " + this.baseVolume + "\n");
		var2 = var2 + (" > Volume       : " + this.getVolume() + "\n");
		var2 = var2 + (" > Mute         : " + this._bMute + "\n");
		return var2;
	}
	function onLoad(§\x14\x1b§)
	{
		if(!var2)
		{
			org.flashdevelop.utils.FlashConnect.mtrace(new com.ankamagames.exceptions.FileLoadException(this,"AudioElement","onLoad",this._sFile),"dofus.sounds.AudioElement::onLoad","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/sounds/AudioElement.as",429);
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
