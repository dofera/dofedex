class com.ankamagames.exceptions.AbstractException extends Error
{
   function AbstractException(objectErrorSource, className, methodName, msg)
   {
      super(msg);
      this._className = className;
      this._methodName = methodName;
      this._objectErrorSource = objectErrorSource;
   }
   function getSource(Void)
   {
      return this._objectErrorSource;
   }
   function getMessage(Void)
   {
      return !!super.message?super.toString():null;
   }
   function getExceptionName(Void)
   {
      return "com.ankamagames.exceptions.AbstractException";
   }
   function getClassName(Void)
   {
      return this._className;
   }
   function getMethodName(Void)
   {
      return !!this._methodName?this._methodName:null;
   }
   function toString(Void)
   {
      var _loc3_ = this.getExceptionName() + " in " + this.getClassName() + (this.getMethodName() == null?"":"." + this.getMethodName());
      var _loc4_ = this.getMessage();
      if(!_loc4_)
      {
         return _loc3_;
      }
      return "[EXCEPTION] " + _loc3_ + " :\r\n\t" + _loc4_;
   }
}
