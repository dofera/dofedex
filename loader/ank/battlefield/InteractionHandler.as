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
							if(var0 !== ank.battlefield.Constants.INTERACTION_OBJECT_NONE)
							{
								if(var0 !== ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE)
								{
									switch(null)
									{
										case ank.battlefield.Constants.INTERACTION_OBJECT_OVER_OUT:
											this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,false);
											this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,true);
											if(this._bIs8)
											{
												this.setEnabledObject2Release(false);
												this.setEnabledObject2OutOver(true);
											}
											break;
										case ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT:
											this.setEnabledProtoAll(ank.battlefield.mc.InteractiveObject.prototype,true);
											if(this._bIs8)
											{
												this.setEnabledObject2All(true);
											}
											break;
										default:
											if(var0 !== ank.battlefield.Constants.INTERACTION_SPRITE_NONE)
											{
												if(var0 !== ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE)
												{
													if(var0 !== ank.battlefield.Constants.INTERACTION_SPRITE_OVER_OUT)
													{
														if(var0 !== ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE_OVER_OUT)
														{
															break;
														}
														this.setEnabledProtoAll(ank.battlefield.mc.Sprite.prototype,true);
														break;
													}
													this.setEnabledProtoRelease(ank.battlefield.mc.Sprite.prototype,false);
													this.setEnabledProtoOutOver(ank.battlefield.mc.Sprite.prototype,true);
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
								}
								else
								{
									this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,true);
									this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,false);
									if(this._bIs8)
									{
										this.setEnabledObject2Release(true);
										this.setEnabledObject2OutOver(false);
									}
								}
							}
							else
							{
								this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,false);
								this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,false);
								if(this._bIs8)
								{
									this.setEnabledObject2Release(false);
									this.setEnabledObject2OutOver(false);
								}
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
		switch(var3)
		{
			case ank.battlefield.Constants.INTERACTION_NONE:
				this.setEnabledProtoAll(var4,false);
				break;
			case ank.battlefield.Constants.INTERACTION_CELL_RELEASE:
				this.setEnabledProtoRelease(var4,true);
				this.setEnabledProtoOutOver(var4,false);
				break;
			default:
				if(var0 !== ank.battlefield.Constants.INTERACTION_CELL_OVER_OUT)
				{
					if(var0 !== ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT)
					{
						break;
					}
					this.setEnabledProtoAll(var4,true);
					break;
				}
				this.setEnabledProtoRelease(var4,false);
				this.setEnabledProtoOutOver(var4,true);
				break;
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
	function setEnabledProtoAll(var2, var3)
	{
		if(var3)
		{
			var2.onRelease = var2._release;
			var2.onRollOver = var2._rollOver;
			var2.onRollOut = var2.onReleaseOutside = var2._rollOut;
		}
		else
		{
			delete register2.onRelease;
			delete register2.onRollOver;
			delete register2.onRollOut;
			delete register2.onReleaseOutside;
		}
	}
	function setEnabledProtoRelease(var2, var3)
	{
		if(var3)
		{
			var2.onRelease = var2._release;
		}
		else
		{
			delete register2.onRelease;
		}
	}
	function setEnabledProtoOutOver(var2, var3)
	{
		if(var3)
		{
			var2.onRollOver = var2._rollOver;
			var2.onRollOut = var2._rollOut;
			var2.onRollOut = var2.onReleaseOutside = var2._rollOut;
		}
		else
		{
			delete register2.onRollOver;
			delete register2.onRollOut;
			delete register2.onReleaseOutside;
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
						var4.onRollOver = var4._rollOver;
						var4.onRollOut = var4.onReleaseOutside = var4._rollOut;
					}
					else
					{
						delete register4.onRelease;
						delete register4.onRollOver;
						delete register4.onRollOut;
						delete register4.onReleaseOutside;
					}
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
		for(var k in var3)
		{
			var var4 = var3[k].mcObject2;
			if(var3[k].layerObject2Interactive)
			{
				if(var4 != undefined)
				{
					if(var2)
					{
						var4.onRollOver = var4._rollOver;
						var4.onRollOut = var4._rollOut;
						var4.onRollOut = var4.onReleaseOutside = var4._rollOut;
					}
					else
					{
						delete register4.onRollOver;
						delete register4.onRollOut;
						delete register4.onReleaseOutside;
					}
				}
			}
		}
	}
}
