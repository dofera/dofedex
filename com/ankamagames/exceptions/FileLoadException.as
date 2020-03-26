class com.ankamagames.exceptions.FileLoadException extends com.ankamagames.exceptions.AbstractException
{
   function FileLoadException(objectErrorSource, className, methodName, file)
   {
      super(objectErrorSource,className,methodName,file + " can\'t be loaded.");
   }
   function getExceptionName(Void)
   {
      return "com.ankamagames.exceptions.FileLoadException";
   }
}
