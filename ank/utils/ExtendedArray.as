class ank.utils.ExtendedArray extends Array
{
	function ExtendedArray()
	{
		super();
		this.initialize();
	}
	function removeEventListener()
	{
	}
	function addEventListener()
	{
	}
	function dispatchEvent()
	{
	}
	function dispatchQueue()
	{
	}
	function initialize(loc2)
	{
		mx.events.EventDispatcher.initialize(this);
	}
	function createFromArray(loc2)
	{
		this.splice(0,this.length);
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			this.push(loc2[loc3]);
			loc3 = loc3 + 1;
		}
	}
	function removeAll(loc2)
	{
		this.splice(0,this.length);
		this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
	}
	function push(loc2)
	{
		var loc4 = super.push(loc3);
		this.dispatchEvent({type:"modelChanged",eventName:"addItem"});
		return loc4;
	}
	function pop()
	{
		var loc3 = super.pop();
		this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
		return loc3;
	}
	function shift()
	{
		var loc3 = super.shift();
		this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
		return loc3;
	}
	function unshift(loc2)
	{
		var loc4 = super.unshift(loc3);
		this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
		return loc4;
	}
	function reverse()
	{
		super.reverse();
		this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
	}
	function replaceAll(loc2, loc3)
	{
		var loc4 = [loc2,0];
		for(var k in loc3)
		{
			loc4.push(loc3[k]);
		}
		this.splice.apply(this,loc4);
		this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
	}
	function removeItems(loc2, loc3)
	{
		this.splice(loc2,loc3);
		this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
	}
	function updateItem(loc2, loc3)
	{
		this.splice(loc2,1,loc3);
		this.dispatchEvent({type:"modelChanged",eventName:"updateOne",updateIndex:loc2});
	}
	function findFirstItem(loc2, loc3)
	{
		var loc4 = 0;
		while(loc4 < this.length)
		{
			var loc5 = this[loc4];
			if(loc5[loc2] == loc3)
			{
				return {index:loc4,item:loc5};
			}
			loc4 = loc4 + 1;
		}
		return {index:-1};
	}
	function clone()
	{
		var loc2 = new ank.utils.();
		var loc3 = 0;
		while(loc3 < this.length)
		{
			loc2.push(this[loc3].clone());
			loc3 = loc3 + 1;
		}
		return loc2;
	}
	function shuffle()
	{
		var loc2 = this.clone();
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			var loc4 = loc2[loc3];
			var loc5 = random(loc2.length);
			loc2[loc3] = loc2[loc5];
			loc2[loc5] = loc4;
			loc3 = loc3 + 1;
		}
		return loc2;
	}
	function bubbleSortOn(loc2, loc3)
	{
		if((loc3 & Array.ASCENDING) == 0 && (loc3 & Array.DESCENDING) == 0)
		{
			loc3 = loc3 | Array.ASCENDING;
		}
		while(true)
		{
			var loc4 = false;
			var loc5 = 1;
			while(loc5 < this.length)
			{
				if((loc3 & Array.ASCENDING) > 0 && this[loc5 - 1][loc2] > this[loc5][loc2] || (loc3 & Array.DESCENDING) > 0 && this[loc5 - 1][loc2] < this[loc5][loc2])
				{
					var loc6 = this[loc5 - 1];
					this[loc5 - 1] = this[loc5];
					this[loc5] = loc6;
					loc4 = true;
				}
				loc5 = loc5 + 1;
			}
			if(loc4)
			{
				continue;
			}
			break;
		}
	}
	function concat(loc2)
	{
		var loc4 = super.concat(loc3);
		var loc5 = new ank.utils.();
		loc5.createFromArray(loc4);
		return loc5;
	}
}
