class com.ankamagames.exceptions.FileLoadException extends com.ankamagames.exceptions.AbstractException
{
	function FileLoadException(objectErrorSource, className, methodName, §\x0f\t§)
	{
		super(objectErrorSource,className,methodName,loc6 + " can\'t be loaded.");
	}
	function getExceptionName(loc2)
	{
		return "com.ankamagames.exceptions.FileLoadException";
	}
}
