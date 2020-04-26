class dofus.utils.criterions.CriterionManager
{
	static var MAIN_TYPE_AREA = "A";
	static var TYPE_AREA_ALIGNMENT = "A";
	static var MAIN_TYPE_BASIC = "B";
	static var TYPE_BASIC_EPISOD = "E";
	function CriterionManager()
	{
	}
	static function fillingCriterions(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			var loc5 = String(loc3[loc4]).split("&");
			if(loc5.length != 0)
			{
				var loc6 = 0;
				var loc7 = 0;
				while(loc7 < loc5.length)
				{
					var loc8 = dofus.utils.criterions.CriterionManager.parseCriterion(loc5[loc7]);
					if(loc8.isFilled())
					{
						loc6 = loc6 + 1;
					}
					loc7 = loc7 + 1;
				}
				if(loc6 == loc5.length)
				{
					return true;
				}
			}
			loc4 = loc4 + 1;
		}
		return false;
	}
	static function parseCriterion(loc2)
	{
		var loc3 = loc2.charAt(0);
		var loc4 = loc2.charAt(1);
		var loc5 = loc2.charAt(2);
		var loc6 = loc2.substring(3);
		switch(loc3)
		{
			case dofus.utils.criterions.CriterionManager.MAIN_TYPE_AREA:
				if((loc0 = loc4) === dofus.utils.criterions.CriterionManager.TYPE_AREA_ALIGNMENT)
				{
					var loc7 = new dofus.utils.criterions.subareaCriterion.(loc5,Number(loc6));
				}
				break;
			case dofus.utils.criterions.CriterionManager.MAIN_TYPE_BASIC:
				if((loc0 = loc4) !== dofus.utils.criterions.CriterionManager.TYPE_BASIC_EPISOD)
				{
					break;
				}
				loc7 = new dofus.utils.criterions.basicCriterion.(loc5,Number(loc6));
				break;
		}
		if(loc7 == null || !loc7.check())
		{
			return null;
		}
		return loc7;
	}
}
