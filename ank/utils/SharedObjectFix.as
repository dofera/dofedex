class ank.utils.SharedObjectFix extends Object
{
   static var _oLocalCache = new Object();
   static var _oRemoteCache = new Object();
   function SharedObjectFix(oParams)
   {
      super();
      this._so = !!oParams.persistence?SharedObject.getRemote(oParams.name,oParams.remotePath,oParams.persistence,oParams.secure):SharedObject.getLocal(oParams.name,oParams.localPath,oParams.secure);
      if(this._so.data._Data == undefined)
      {
         this._so.data._Data = new Object();
      }
      this.data = this._so.data._Data;
      this._so.onStatus = function(infoObject)
      {
         if(this.onStatus)
         {
            this.onStatus(infoObject);
         }
      };
      this._so.onSync = function(objArray)
      {
         if(this.onSync)
         {
            this.onSync(objArray);
         }
      };
   }
   function clear()
   {
      this.data = new Object();
      this._so.clear();
   }
   function close()
   {
      this._so.data._Data = this.data;
      this._so.close();
   }
   function flush(minDiskSpace)
   {
      this._so.data._Data = this.data;
      return this._so.flush(minDiskSpace);
   }
   function getSize()
   {
      this._so.data._Data = this.data;
      return this._so.getSize;
   }
   function connect(myConnection)
   {
      this._so.data._Data = this.data;
      return this._so.connect(myConnection);
   }
   function send(handlerName)
   {
      this._so.data._Data = this.data;
      this._so.send(handlerName);
   }
   function setFps(updatesPerSecond)
   {
      this._so.data._Data = this.data;
      return this._so.setFps(updatesPerSecond);
   }
   static function getLocal(name, localPath, secure)
   {
      if(!ank.utils.SharedObjectFix._oLocalCache[name])
      {
         ank.utils.SharedObjectFix._oLocalCache[name] = new ank.utils.SharedObjectFix({name:name,localPath:localPath,secure:secure});
      }
      return ank.utils.SharedObjectFix._oLocalCache[name];
   }
   static function getRemote(name, remotePath, persistence, secure)
   {
      if(!ank.utils.SharedObjectFix._oRemoteCache[name])
      {
         ank.utils.SharedObjectFix._oRemoteCache[name] = new ank.utils.SharedObjectFix({name:name,remotePath:remotePath,persistence:persistence,secure:secure});
      }
      return ank.utils.SharedObjectFix._oRemoteCache[name];
   }
   static function deleteAll(url)
   {
      SharedObject.deleteAll();
   }
   static function getDiskUsage(url)
   {
      return SharedObject.getDiskUsage(url);
   }
}
