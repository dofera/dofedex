class com.ankamagames.exceptions.AbstractException extends Error
{
	function AbstractException(objectErrorSource, className, methodName, §\n\x15§)
	{
		super(loc6);
		this._className = className;
		this._methodName = methodName;
		this._objectErrorSource = objectErrorSource;
	}
	function getSource(loc2)
	{
		return this._objectErrorSource;
	}
	function getMessage(loc2)
	{
		return !!super.message?super.toString():null;
	}
	function getExceptionName(loc2)
	{
		return "com.ankamagames.exceptions.AbstractException";
	}
	function getClassName(loc2)
	{
		return this._className;
	}
	function getMethodName(loc2)
	{
		return !!this._methodName?this._methodName:null;
	}
	function toString(loc2)
	{
		var loc3 = this.getExceptionName() + " in " + this.getClassName() + (this.getMethodName() == null?"":"." + this.getMethodName());
		var loc4 = this.getMessage();
		if(!loc4)
		{
			return loc3;
		}
		return "[EXCEPTION] " + loc3 + " :\r\n\t" + loc4;
	}
}
