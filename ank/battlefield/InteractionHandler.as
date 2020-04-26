class ank.battlefield.InteractionHandler
{
	function InteractionHandler(loc3, loc4)
	{
		this.initialize(loc2,loc3);
	}
	function initialize(loc2, loc3)
	{
		this._mcContainer = loc2;
		this._oDatacenter = loc3;
		this._extraProto = new Object();
		this.setEnabled(ank.battlefield.Constants.INTERACTION_NONE);
		this._bIs8 = Number(System.capabilities.version.substr(0,1)) >= 8;
	}
	function setEnabled(loc2)
	{
		if((var loc0 = loc2) !== ank.battlefield.Constants.INTERACTION_NONE)
		{
			if(loc0 !== ank.battlefield.Constants.INTERACTION_CELL_NONE)
			{
				if(loc0 !== ank.battlefield.Constants.INTERACTION_CELL_RELEASE)
				{
					if(loc0 !== ank.battlefield.Constants.INTERACTION_CELL_OVER_OUT)
					{
						switch(null)
						{
							case ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT:
								this.setEnabledProtoAll(ank.battlefield.mc.Cell.prototype,true);
								break;
							case ank.battlefield.Constants.INTERACTION_OBJECT_NONE:
								this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,false);
								this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,false);
								if(this._bIs8)
								{
									this.setEnabledObject2Release(false);
									this.setEnabledObject2OutOver(false);
								}
								break;
							default:
								if(loc0 !== ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE)
								{
									if(loc0 !== ank.battlefield.Constants.INTERACTION_OBJECT_OVER_OUT)
									{
										if(loc0 !== ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT)
										{
											if(loc0 !== ank.battlefield.Constants.INTERACTION_SPRITE_NONE)
											{
												if(loc0 !== ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE)
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
								this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,true);
								this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,false);
								if(this._bIs8)
								{
									this.setEnabledObject2Release(true);
									this.setEnabledObject2OutOver(false);
								}
								break;
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
	function setEnabledCell(loc2, loc3)
	{
		var loc4 = this._mcContainer["cell" + loc2];
		if(loc4 == undefined)
		{
			ank.utils.Logger.err("[setEnabledCell] Cell inexistante");
			return undefined;
		}
		this._extraProto[loc4._name] = loc4;
		if((var loc0 = loc3) !== ank.battlefield.Constants.INTERACTION_NONE)
		{
			if(loc0 !== ank.battlefield.Constants.INTERACTION_CELL_RELEASE)
			{
				if(loc0 !== ank.battlefield.Constants.INTERACTION_CELL_OVER_OUT)
				{
					if(loc0 === ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT)
					{
						this.setEnabledProtoAll(loc4,true);
					}
				}
				else
				{
					this.setEnabledProtoRelease(loc4,false);
					this.setEnabledProtoOutOver(loc4,true);
				}
			}
			else
			{
				this.setEnabledProtoRelease(loc4,true);
				this.setEnabledProtoOutOver(loc4,false);
			}
		}
		else
		{
			this.setEnabledProtoAll(loc4,false);
		}
	}
	function setEnabledOffAllExtraProto(loc2)
	{
		for(var loc3 in this._extraProto)
		{
			this.setEnabledProtoAll(loc3,false);
		}
		this._extraProto = new Array();
	}
	function setEnabledProtoAll(loc2, loc3)
	{
		if(loc3)
		{
			loc2.onRelease = loc2._release;
			loc2.onRollOver = loc2._rollOver;
			loc2.onRollOut = loc2.onReleaseOutside = loc2._rollOut;
		}
		else
		{
			delete register2.onRelease;
			delete register2.onRollOver;
			delete register2.onRollOut;
			delete register2.onReleaseOutside;
		}
	}
	function setEnabledProtoRelease(loc2, loc3)
	{
		if(loc3)
		{
			loc2.onRelease = loc2._release;
		}
		else
		{
			delete register2.onRelease;
		}
	}
	function setEnabledProtoOutOver(loc2, loc3)
	{
		if(loc3)
		{
			loc2.onRollOver = loc2._rollOver;
			loc2.onRollOut = loc2._rollOut;
			loc2.onRollOut = loc2.onReleaseOutside = loc2._rollOut;
		}
		else
		{
			delete register2.onRollOver;
			delete register2.onRollOut;
			delete register2.onReleaseOutside;
		}
	}
	function setEnabledObject2All(loc2)
	{
		var loc3 = this._oDatacenter.Map.data;
		for(var k in loc3)
		{
			var loc4 = loc3[k].mcObject2;
			if(loc3[k].layerObject2Interactive)
			{
				if(loc4 != undefined)
				{
					if(loc2)
					{
						loc4.onRelease = loc4._release;
						loc4.onRollOver = loc4._rollOver;
						loc4.onRollOut = loc4.onReleaseOutside = loc4._rollOut;
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
	function setEnabledObject2Release(loc2)
	{
		var loc3 = this._oDatacenter.Map.data;
		for(var k in loc3)
		{
			var loc4 = loc3[k].mcObject2;
			if(loc3[k].layerObject2Interactive)
			{
				if(loc4 != undefined)
				{
					if(loc2)
					{
						loc4.onRelease = loc4._release;
					}
					else
					{
						delete register4.onRelease;
					}
				}
			}
		}
	}
	function setEnabledObject2OutOver(loc2)
	{
		var loc3 = this._oDatacenter.Map.data;
		for(var loc4 in loc3)
		{
			if(loc3[k].layerObject2Interactive)
			{
				if(loc4 != undefined)
				{
					if(loc2)
					{
						loc4.onRollOver = loc4._rollOver;
						loc4.onRollOut = loc4._rollOut;
						loc4.onRollOut = loc4.onReleaseOutside = loc4._rollOut;
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
