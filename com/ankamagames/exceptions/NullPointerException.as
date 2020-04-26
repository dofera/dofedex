class com.ankamagames.exceptions.NullPointerException extends com.ankamagames.exceptions.AbstractException
{
	function NullPointerException(objectErrorSource, className, methodName, variableName)
	{
		super(objectErrorSource,className,methodName,variableName + " is NULL!");
	}
	function getExceptionName(loc2)
	{
		return "com.ankamagames.exceptions.NullPointerException";
	}
}
