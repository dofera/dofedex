if(!dofus.aks.Mount)
{
	if(!dofus)
	{
		_global.dofus = new Object();
	}
	if(!dofus.aks)
	{
		_global.dofus.aks = new Object();
	}
	dofus.aks.Mount = function(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	} extends dofus.aks.Handler;
	var var1 = dofus.aks.Mount = function(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	}.prototype;
	var1.rename = function rename(var2)
	{
		this.aks.send("Rn" + var2,true);
	};
	var1.kill = function kill()
	{
		this.aks.send("Rf");
	};
	var1.setXP = function setXP(var2)
	{
		this.aks.send("Rx" + var2,true);
	};
	var1.ride = function ride()
	{
		this.aks.send("Rr",false);
	};
	var1.data = function data(var2, var3)
	{
		this.aks.send("Rd" + var2 + "|" + var3,true);
	};
	var1.parkMountData = function parkMountData(var2)
	{
		this.aks.send("Rp" + var2,true);
	};
	var1.removeObjectInPark = function removeObjectInPark(var2)
	{
		this.aks.send("Ro" + var2,true);
	};
	var1.mountParkSell = function mountParkSell(var2)
	{
		this.aks.send("Rs" + var2,true);
	};
	var1.mountParkBuy = function mountParkBuy(var2)
	{
		this.aks.send("Rb" + var2,true);
	};
	var1.leave = function leave()
	{
		this.aks.send("Rv");
	};
	var1.castrate = function castrate()
	{
		this.aks.send("Rc");
	};
	var1.onEquip = function onEquip(var2)
	{
		var var3 = var2.charAt(0);
		switch(var3)
		{
			case "+":
				this.api.datacenter.Player.mount = this.createMount(var2.substr(1));
				break;
			case "-":
				this.unequipMount();
				break;
			default:
				if(var0 !== "E")
				{
					break;
				}
				this.equipError(var2.charAt(1));
				break;
		}
	};
	var1.onXP = function onXP(var2)
	{
		var var3 = Number(var2);
		if(!_global.isNaN(var3))
		{
			this.api.datacenter.Player.mountXPPercent = var3;
		}
	};
	var1.onName = function onName(var2)
	{
		this.api.datacenter.Player.mount.name = var2;
	};
	var1.onData = function onData(var2)
	{
		var var3 = this.createMount(var2);
		this.api.ui.loadUIComponent("MountViewer","MountViewer",{mount:var3});
	};
	var1.onMountPark = function onMountPark(var2)
	{
		var var3 = var2.split(";");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = Number(var3[2]);
		var var7 = Number(var3[3]);
		var var8 = var3[4];
		var var9 = var3[5];
		var var10 = this.api.kernel.CharactersManager.createGuildEmblem(var9);
		this.api.datacenter.Map.mountPark = new dofus.datacenter.	(var4,var5,var6,var7,var8,var10);
	};
	var1.onRidingState = function onRidingState(var2)
	{
		var var3 = var2.charAt(0);
		switch(var3)
		{
			case "+":
			default:
				this.api.datacenter.Player.isRiding = true;
				break;
			case "-":
				this.api.datacenter.Player.isRiding = false;
		}
	};
	var1.onMountParkBuy = function onMountParkBuy(var2)
	{
		var var3 = var2["�\x0b"]("\x01");
		this["\b\x03\x1c�\t"][""]("\x05\x01�\x02","\x05\x01�\x02",{2�:Number(var3[1])});
	};
	var1[§§constant(68)] = function §\§\§constant(68)§()
	{
		this[§§constant(37)][§§constant(52)][§§constant(69)](§§constant(67));
	};
	var1.equipError = function equipError(var2)
	{
		switch(var2)
		{
			case AbstractTextOverHead:
				var var3 = this["\b\x03\x1c�\t"]["\x03)"]["\x02\x01\x07"]("\x01");
				break;
			case "�\x06+\x1c\x12\x12�\x02":
				var3 = this["\b\x03\x1c�\t"]["\x03)"]["\x02\x01\x07"]("\x1e");
				break;
			case "":
				var3 = this["\b\x03\x1c�\t"]["\x03)"]["\x02\x01\x07"]("�\x06");
		}
		this["\b\x03\x1c�\t"]["\b\x1d\x07\x01"]["\x07\x02"](undefined,var3,"\x05\x01\b\x19\x04\x02G�\t");
	};
	var1["\b\x04@O�\x02"] = function §\b\x04@O�\x02§()
	{
		this["\b\x03\x1c�\t"]["\b"]["\x07"][""] = undefined;
	};
	var1[§§constant(42)] = function §\§\§constant(42)§(§\x1e\x0f\x06§, newBorn)
	{
		var var4 = var2[§§constant(56)](§§constant(78));
		var var5 = Number(var4[1]);
		var var6 = new eval("\x1c_")[§§constant(38)].§§constant(2)(var5,undefined,newBorn);
		var6[§§constant(79)] = var4[0];
		var6[§§constant(80)] = var4[2][§§constant(56)](§§constant(81));
		var var7 = var4[3][§§constant(56)](§§constant(81));
		var6[§§constant(82)] = new eval(§§constant(83))[§§constant(84)].§§constant(85)();
		var var8 = 0;
		while(var8 < var7[§§constant(86)])
		{
			var var9 = Number(var7[var8]);
			if(var9 != 0 && !eval(§§constant(3))[§§constant(46)](var9))
			{
				var6[§§constant(82)][§§constant(90)]({§§constant(87):this[§§constant(37)][§§constant(72)][§§constant(88)](var9)[§§constant(89)],§§constant(17):var9});
			}
			var8 = var8 + 1;
		}
		var6[§§constant(49)] = var4[4] != §§constant(91)?var4[4]:this[§§constant(37)][§§constant(72)][§§constant(73)](§§constant(92));
		var6[§§constant(93)] = Number(var4[5]);
		var var10 = var4[6][§§constant(56)](§§constant(81));
		var6[§§constant(94)] = Number(var10[0]);
		var6[§§constant(95)] = Number(var10[1]);
		var6[§§constant(96)] = Number(var10[2]);
		var6[§§constant(97)] = Number(var4[7]);
		var6[§§constant(98)] = !!Number(var4[8]);
		var6[§§constant(99)] = Number(var4[9]);
		var6[§§constant(100)] = !!Number(var4[10]);
		var var11 = var4[11][§§constant(56)](§§constant(81));
		var6[§§constant(101)] = Number(var11[0]);
		var6[§§constant(102)] = Number(var11[1]);
		var var12 = var4[12][§§constant(56)](§§constant(81));
		var6[§§constant(103)] = Number(var12[0]);
		var6[§§constant(104)] = Number(var12[1]);
		var var13 = var4[13][§§constant(56)](§§constant(81));
		var6[§§constant(105)] = Number(var13[0]);
		var6[§§constant(106)] = Number(var13[1]);
		var var14 = var4[14][§§constant(56)](§§constant(81));
		var6[§§constant(107)] = Number(var14[0]);
		var6[§§constant(108)] = Number(var14[1]);
		var6[§§constant(109)] = Number(var14[2]);
		var var15 = var4[15][§§constant(56)](§§constant(81));
		var6[§§constant(110)] = Number(var15[0]);
		var6[§§constant(111)] = Number(var15[1]);
		var6[§§constant(112)] = Number(var4[16]);
		var6[§§constant(113)] = !!Number(var4[17]);
		var6[§§constant(114)](var4[18]);
		var var16 = var4[19][§§constant(56)](§§constant(81));
		var6[§§constant(115)] = Number(var16[0]);
		var6[§§constant(116)] = Number(var16[1]);
		var var17 = var4[20][§§constant(56)](§§constant(81));
		var6[§§constant(117)] = Number(var17[0]);
		var6[§§constant(118)] = Number(var17[1]);
		return var6;
	};
	eval("\x04\x01\b\x01N�\x02")(var1,null,1);
}
