class com.ankamagames.exceptions.ValueOutOfRangeException extends com.ankamagames.exceptions.AbstractException
{
   function ValueOutOfRangeException(objectErrorSource, className, methodName, variableName, invalidValue, minValue, maxValue)
   {
      super(objectErrorSource,className,methodName,variableName + "[" + invalidValue + ") is out of of range. The value value should be between " + minValue + " and " + maxValue + ").");
   }
   function getExceptionName(Void)
   {
      return "com.ankamagames.exceptions.ValueOutOfRangeException";
   }
}
