class com.ankamagames.exceptions.InvalidOperationException extends com.ankamagames.exceptions.AbstractException
{
   function InvalidOperationException(objectErrorSource, className, methodName, msg)
   {
      super(objectErrorSource,className,methodName,msg);
   }
   function getExceptionName(Void)
   {
      return "com.ankamagames.exceptions.InvalidOperationException";
   }
}
