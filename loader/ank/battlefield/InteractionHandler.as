class ank.battlefield.InteractionHandler
{
	function InteractionHandler(var3, var4)
	{
		this.initialize(var2,var3);
	}
	function initialize(var2, var3)
	{
		this._mcContainer = var2;
		this._oDatacenter = var3;
		this._extraProto = new Object();
		this.setEnabled(ank.battlefield.Constants.INTERACTION_NONE);
		this._bIs8 = Number(System.capabilities.version.substr(0,1)) >= 8;
	}
	function setEnabled(var2)
	{
		if((var var0 = var2) !== ank.battlefield.Constants.INTERACTION_NONE)
		{
			if(var0 !== ank.battlefield.Constants.INTERACTION_CELL_NONE)
			{
				if(var0 !== ank.battlefield.Constants.INTERACTION_CELL_RELEASE)
				{
					if(var0 !== ank.battlefield.Constants.INTERACTION_CELL_OVER_OUT)
					{
						if(var0 !== ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT)
						{
							switch(null)
							{
								case ank.battlefield.Constants.INTERACTION_OBJECT_NONE:
									this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,false);
									this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,false);
									if(this._bIs8)
									{
										this.setEnabledObject2Release(false);
										this.setEnabledObject2OutOver(false);
									}
									break;
								case ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE:
									this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,true);
									this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,false);
									if(this._bIs8)
									{
										this.setEnabledObject2Release(true);
										this.setEnabledObject2OutOver(false);
									}
									break;
								default:
									if(var0 !== ank.battlefield.Constants.INTERACTION_OBJECT_OVER_OUT)
									{
										if(var0 !== ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT)
										{
											if(var0 !== ank.battlefield.Constants.INTERACTION_SPRITE_NONE)
											{
												if(var0 !== ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE)
												{
													switch(null)
													{
														case ank.battlefield.Constants.INTERACTION_SPRITE_OVER_OUT:
															this.setEnabledProtoRelease(ank.battlefield.mc.Sprite.prototype,false);
															this.setEnabledProtoOutOver(ank.battlefield.mc.Sprite.prototype,true);
															break;
														case ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE_OVER_OUT:
															this.setEnabledProtoAll(ank.battlefield.mc.Sprite.prototype,true);
													}
													break;
												}
												this.setEnabledProtoRelease(ank.battlefield.mc.Sprite.prototype,true);
												this.setEnabledProtoOutOver(ank.battlefield.mc.Sprite.prototype,false);
												break;
											}
											this.setEnabledProtoRelease(ank.battlefield.mc.Sprite.prototype,false);
											this.setEnabledProtoOutOver(ank.battlefield.mc.Sprite.prototype,false);
											break;
										}
										this.setEnabledProtoAll(ank.battlefield.mc.InteractiveObject.prototype,true);
										if(this._bIs8)
										{
											this.setEnabledObject2All(true);
										}
										break;
									}
									this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,false);
									this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,true);
									if(this._bIs8)
									{
										this.setEnabledObject2Release(false);
										this.setEnabledObject2OutOver(true);
									}
									break;
							}
						}
						else
						{
							this.setEnabledProtoAll(ank.battlefield.mc.Cell.prototype,true);
						}
					}
					else
					{
						this.setEnabledProtoRelease(ank.battlefield.mc.Cell.prototype,false);
						this.setEnabledProtoOutOver(ank.battlefield.mc.Cell.prototype,true);
					}
				}
				else
				{
					this.setEnabledProtoRelease(ank.battlefield.mc.Cell.prototype,true);
					this.setEnabledProtoOutOver(ank.battlefield.mc.Cell.prototype,false);
				}
			}
			else
			{
				this.setEnabledOffAllExtraProto();
				this.setEnabledProtoAll(ank.battlefield.mc.Cell.prototype,false);
			}
		}
		else
		{
			this.setEnabledOffAllExtraProto();
			this.setEnabledProtoAll(ank.battlefield.mc.Cell.prototype,false);
			this.setEnabledProtoAll(ank.battlefield.mc.InteractiveObject.prototype,false);
			this.setEnabledProtoAll(ank.battlefield.mc.Sprite.prototype,false);
		}
	}
	function setEnabledCell(var2, var3)
	{
		var var4 = this._mcContainer["cell" + var2];
		if(var4 == undefined)
		{
			ank.utils.Logger.err("[setEnabledCell] Cell inexistante");
			return undefined;
		}
		this._extraProto[var4._name] = var4;
		if((var var0 = var3) !== ank.battlefield.Constants.INTERACTION_NONE)
		{
			if(var0 !== ank.battlefield.Constants.INTERACTION_CELL_RELEASE)
			{
				switch(null)
				{
					case ank.battlefield.Constants.INTERACTION_CELL_OVER_OUT:
						this.setEnabledProtoRelease(var4,false);
						this.setEnabledProtoOutOver(var4,true);
						break;
					case ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT:
						this.setEnabledProtoAll(var4,true);
				}
			}
			else
			{
				this.setEnabledProtoRelease(var4,true);
				this.setEnabledProtoOutOver(var4,false);
			}
		}
		else
		{
			this.setEnabledProtoAll(var4,false);
		}
	}
	function setEnabledOffAllExtraProto(var2)
	{
		for(var p in this._extraProto)
		{
			var var3 = this._extraProto[p];
			this.setEnabledProtoAll(var3,false);
		}
		this._extraProto = new Array();
	}
	function setEnabledProtoAll(proto, §\x16\x18§)
	{
		if(var3)
		{
			proto.onRelease = proto._release;
		}
		else
		{
			delete proto.onRelease;
		}
		this.setEnabledProtoOutOver(proto,var3);
	}
	function setEnabledProtoRelease(proto, §\x16\x18§)
	{
		if(var3)
		{
			proto.onRelease = proto._release;
		}
		else
		{
			delete proto.onRelease;
		}
	}
	function setEnabledProtoOutOver(proto, §\x16\x18§)
	{
		if(var3)
		{
			proto.onRollOver = proto._rollOver;
			proto.onRollOut = proto._rollOut;
			proto.onRollOut = proto.onReleaseOutside = proto._rollOut;
		}
		else
		{
			delete proto.onRollOver;
			delete proto.onRollOut;
			delete proto.onReleaseOutside;
			var var4 = _global.API;
			if(var4.gfx.rollOverMcObject == proto || var4.gfx.rollOverMcSprite == proto)
			{
				proto._rollOut();
			}
		}
	}
	function setEnabledObject2All(var2)
	{
		var var3 = this._oDatacenter.Map.data;
		for(var k in var3)
		{
			var var4 = var3[k].mcObject2;
			if(var3[k].layerObject2Interactive)
			{
				if(var4 != undefined)
				{
					if(var2)
					{
						var4.onRelease = var4._release;
					}
					else
					{
						delete register4.onRelease;
					}
					this.setEnabledProtoOutOver(var4,var2);
				}
			}
		}
	}
	function setEnabledObject2Release(var2)
	{
		var var3 = this._oDatacenter.Map.data;
		for(var k in var3)
		{
			var var4 = var3[k].mcObject2;
			if(var3[k].layerObject2Interactive)
			{
				if(var4 != undefined)
				{
					if(var2)
					{
						var4.onRelease = var4._release;
					}
					else
					{
						delete register4.onRelease;
					}
				}
			}
		}
	}
	function setEnabledObject2OutOver(var2)
	{
		var var3 = this._oDatacenter.Map.data;
		for(var var4 in var3)
		{
			if(var3[k].layerObject2Interactive)
			{
				if(var4 != undefined)
				{
					this.setEnabledProtoOutOver(var4,var2);
				}
			}
		}
	}
}
