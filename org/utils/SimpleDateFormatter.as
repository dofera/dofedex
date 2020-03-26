class org.utils.SimpleDateFormatter
{
   static var MONTH_NAMES_EN = new Array("January","February","March","April","May","June","July","August","September","October","November","December","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
   static var MONTH_NAMES_FR = new Array("Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre","Jan","Fev","Mar","Avr","Mai","Jun","Jui","Aou","Sep","Oct","Nov","Dec");
   static var MONTH_NAMES_DE = new Array("Januar","Februar","März","April","Mai","Juni","Juli","August","September","Oktober","November","Dezember","Jan","Feb","Mär","Apr","Mai","Jun","Jul","Aug","Sep","Okt","Nov","Dez");
   static var MONTH_NAMES_ES = new Array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre","Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic");
   static var MONTH_NAMES_PT = new Array("Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro","Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez");
   static var MONTH_NAMES_NL = new Array("Januari","Februari","Maart","April","Mei","Juni","Juli","Augustus","September","Oktober","November","December","Jan","Feb","Mrt","April","Mei","Juni","Juli","Aug","Sept","Okt","Nov","Dec");
   static var MONTH_NAMES_IT = new Array("Gennaio","Febbraio","Marzo","Aprile","Maggio","Giugno","Luglio","Agosto","Settembre","Ottobre","Novembre","Dicembre","Gen","Feb ","Mar","Apr","Mag","Giu ","Lug","Ago","Sett","Ott","Nov","Dic");
   static var MONTH_NAMES = {en:org.utils.SimpleDateFormatter.MONTH_NAMES_EN,fr:org.utils.SimpleDateFormatter.MONTH_NAMES_FR,de:org.utils.SimpleDateFormatter.MONTH_NAMES_DE,es:org.utils.SimpleDateFormatter.MONTH_NAMES_ES,pt:org.utils.SimpleDateFormatter.MONTH_NAMES_PT,nl:org.utils.SimpleDateFormatter.MONTH_NAMES_NL,it:org.utils.SimpleDateFormatter.MONTH_NAMES_IT};
   static var DAY_NAMES_EN = new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sun","Mon","Tue","Wed","Thu","Fri","Sat");
   static var DAY_NAMES_FR = new Array("Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi","Dim","Lun","Mar","Mer","Jeu","Ven","Sam");
   static var DAY_NAMES_DE = new Array("Sonntag","Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag","So","Mo","Di","Mi","Do","Fr","Sa");
   static var DAY_NAMES_ES = new Array("Domingo","Lunes","Martes","Miércoles","Jueves","Viernes","Sábado","Dom","Lun","Mar","Mié","Jue","Vie","Sáb");
   static var DAY_NAMES_PT = new Array("Domingo","Terça-feira","Quarta-feira","Quinta-feira","Sexta-feira","Sábado","Segunda-feira","Dom","Ter","Qua","Qui","Sex","Sáb","Seg");
   static var DAY_NAMES_NL = new Array("Zondag","Maandag","Dinsdag","Woensdag","Donderdag","Vrijdag","Zaterdag","Zo","Ma","Di","Wo","Do","Vrij","Za");
   static var DAY_NAMES_IT = new Array("Domenica","Lunedi","Martedì","Mercoledì","Giovedi","Venerdì","Sabato","Sole","Lun","Mar","Mer","Gio","Ven","Sab");
   static var DAY_NAMES = {en:org.utils.SimpleDateFormatter.DAY_NAMES_EN,fr:org.utils.SimpleDateFormatter.DAY_NAMES_FR,de:org.utils.SimpleDateFormatter.DAY_NAMES_DE,es:org.utils.SimpleDateFormatter.DAY_NAMES_ES,pt:org.utils.SimpleDateFormatter.DAY_NAMES_PT,nl:org.utils.SimpleDateFormatter.DAY_NAMES_NL,it:org.utils.SimpleDateFormatter.DAY_NAMES_IT};
   function SimpleDateFormatter()
   {
   }
   static function LZ(x)
   {
      return (!(x < 0 || x > 9)?"0":"") + x;
   }
   static function formatDate(date, format, language)
   {
      if(language == undefined)
      {
         language = "en";
      }
      format = format + "";
      var _loc5_ = "";
      var _loc6_ = 0;
      var _loc7_ = "";
      var _loc8_ = "";
      var _loc9_ = date.getYear() + "";
      var _loc10_ = date.getMonth() + 1;
      var _loc11_ = date.getDate();
      var _loc12_ = date.getDay();
      var _loc13_ = date.getHours();
      var _loc14_ = date.getMinutes();
      var _loc15_ = date.getSeconds();
      var _loc16_ = date.getMilliseconds();
      var _loc17_ = new Object();
      if(_loc9_.length < 4)
      {
         _loc9_ = "" + (_loc9_ - 0 + 1900);
      }
      _loc17_.y = "" + _loc9_;
      _loc17_.yyyy = _loc9_;
      _loc17_.yy = _loc9_.substring(2,4);
      _loc17_.M = _loc10_;
      _loc17_.MM = org.utils.SimpleDateFormatter.LZ(_loc10_);
      _loc17_.MMM = org.utils.SimpleDateFormatter.MONTH_NAMES[language][_loc10_ - 1];
      _loc17_.NNN = org.utils.SimpleDateFormatter.MONTH_NAMES[language][_loc10_ + 11];
      _loc17_.d = _loc11_;
      _loc17_.dd = org.utils.SimpleDateFormatter.LZ(_loc11_);
      _loc17_.E = org.utils.SimpleDateFormatter.DAY_NAMES[language][_loc12_ + 7];
      _loc17_.EE = org.utils.SimpleDateFormatter.DAY_NAMES[language][_loc12_];
      _loc17_.H = _loc13_;
      _loc17_.HH = org.utils.SimpleDateFormatter.LZ(_loc13_);
      if(_loc13_ == 0)
      {
         _loc17_.h = 12;
      }
      else if(_loc13_ > 12)
      {
         _loc17_.h = _loc13_ - 12;
      }
      else
      {
         _loc17_.h = _loc13_;
      }
      _loc17_.hh = org.utils.SimpleDateFormatter.LZ(_loc17_.h);
      if(_loc13_ > 11)
      {
         _loc17_.K = _loc13_ - 12;
      }
      else
      {
         _loc17_.K = _loc13_;
      }
      _loc17_.k = _loc13_ + 1;
      _loc17_.KK = org.utils.SimpleDateFormatter.LZ(_loc17_.K);
      _loc17_.kk = org.utils.SimpleDateFormatter.LZ(_loc17_.k);
      if(_loc13_ > 11)
      {
         _loc17_.a = "PM";
      }
      else
      {
         _loc17_.a = "AM";
      }
      _loc17_.m = _loc14_;
      _loc17_.mm = org.utils.SimpleDateFormatter.LZ(_loc14_);
      _loc17_.s = _loc15_;
      _loc17_.ss = org.utils.SimpleDateFormatter.LZ(_loc15_);
      _loc17_.i = _loc16_;
      _loc17_.ii = org.utils.SimpleDateFormatter.LZ(_loc16_);
      while(_loc6_ < format.length)
      {
         _loc7_ = format.charAt(_loc6_);
         _loc8_ = "";
         while(format.charAt(_loc6_) == _loc7_ && _loc6_ < format.length)
         {
            _loc6_;
            _loc8_ = _loc8_ + format.charAt(_loc6_++);
         }
         if(_loc17_[_loc8_] != null)
         {
            _loc5_ = _loc5_ + _loc17_[_loc8_];
         }
         else
         {
            _loc5_ = _loc5_ + _loc8_;
         }
      }
      return _loc5_;
   }
   static function isDate(val, format, language)
   {
      var _loc5_ = org.utils.SimpleDateFormatter.getDateFromFormat(val,format,language);
      if(_loc5_ == 0)
      {
         return false;
      }
      return true;
   }
   static function compareDates(date1, dateformat1, language1, date2, dateformat2, language2)
   {
      var _loc8_ = org.utils.SimpleDateFormatter.getDateFromFormat(date1,dateformat1,language1);
      var _loc9_ = org.utils.SimpleDateFormatter.getDateFromFormat(date2,dateformat2,language2);
      if(_loc8_ == 0 || _loc9_ == 0)
      {
         return -1;
      }
      if(_loc8_ > _loc9_)
      {
         return 1;
      }
      return 0;
   }
   static function getDateFromFormat(val, format, language)
   {
      if(language == undefined)
      {
         language = "en";
      }
      val = val + "";
      format = format + "";
      var _loc5_ = 0;
      var _loc6_ = 0;
      var _loc7_ = "";
      var _loc8_ = "";
      var _loc9_ = "";
      var _loc12_ = new Date();
      var _loc13_ = _loc12_.getYear();
      var _loc14_ = _loc12_.getMonth() + 1;
      var _loc15_ = 1;
      var _loc16_ = _loc12_.getHours();
      var _loc17_ = _loc12_.getMinutes();
      var _loc18_ = _loc12_.getSeconds();
      var _loc19_ = _loc12_.getMilliseconds();
      var _loc20_ = "";
      while(true)
      {
         if(_loc6_ < format.length)
         {
            _loc7_ = format.charAt(_loc6_);
            _loc8_ = "";
            while(format.charAt(_loc6_) == _loc7_ && _loc6_ < format.length)
            {
               _loc6_;
               _loc8_ = _loc8_ + format.charAt(_loc6_++);
            }
            if(_loc8_ == "yyyy" || (_loc8_ == "yy" || _loc8_ == "y"))
            {
               if(_loc8_ == "yyyy")
               {
                  var _loc10_ = 4;
                  var _loc11_ = 4;
               }
               if(_loc8_ == "yy")
               {
                  _loc10_ = 2;
                  _loc11_ = 2;
               }
               if(_loc8_ == "y")
               {
                  _loc10_ = 2;
                  _loc11_ = 4;
               }
               _loc13_ = org.utils.SimpleDateFormatter._getInt(val,_loc5_,_loc10_,_loc11_);
               if(_loc13_ == null)
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc13_.length;
               if(_loc13_.length == 2)
               {
                  if(_loc13_ > 70)
                  {
                     _loc13_ = 1900 + (_loc13_ - 0);
                  }
                  else
                  {
                     _loc13_ = 2000 + (_loc13_ - 0);
                  }
               }
            }
            else if(_loc8_ == "MMM" || _loc8_ == "NNN")
            {
               _loc14_ = 0;
               var _loc21_ = 0;
               while(_loc21_ < org.utils.SimpleDateFormatter.MONTH_NAMES[language].length)
               {
                  var _loc22_ = org.utils.SimpleDateFormatter.MONTH_NAMES[language][_loc21_];
                  if(val.substring(_loc5_,_loc5_ + _loc22_.length).toLowerCase() == _loc22_.toLowerCase())
                  {
                     if(_loc8_ == "MMM" || _loc8_ == "NNN" && _loc21_ > 11)
                     {
                        _loc14_ = _loc21_ + 1;
                        if(_loc14_ > 12)
                        {
                           _loc14_ = _loc14_ - 12;
                        }
                        _loc5_ = _loc5_ + _loc22_.length;
                        break;
                     }
                  }
                  _loc21_ = _loc21_ + 1;
               }
               if(_loc14_ < 1 || _loc14_ > 12)
               {
                  break;
               }
            }
            else if(_loc8_ == "EE" || _loc8_ == "E")
            {
               var _loc23_ = 0;
               while(_loc23_ < org.utils.SimpleDateFormatter.DAY_NAMES[language].length)
               {
                  var _loc24_ = org.utils.SimpleDateFormatter.DAY_NAMES[language][_loc23_];
                  if(val.substring(_loc5_,_loc5_ + _loc24_.length).toLowerCase() == _loc24_.toLowerCase())
                  {
                     _loc5_ = _loc5_ + _loc24_.length;
                     break;
                  }
                  _loc23_ = _loc23_ + 1;
               }
            }
            else if(_loc8_ == "MM" || _loc8_ == "M")
            {
               _loc14_ = org.utils.SimpleDateFormatter._getInt(val,_loc5_,_loc8_.length,2);
               if(_loc14_ == null || (_loc14_ < 1 || _loc14_ > 12))
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc14_.length;
            }
            else if(_loc8_ == "dd" || _loc8_ == "d")
            {
               _loc15_ = org.utils.SimpleDateFormatter._getInt(val,_loc5_,_loc8_.length,2);
               if(_loc15_ == null || (_loc15_ < 1 || _loc15_ > 31))
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc15_.length;
            }
            else if(_loc8_ == "hh" || _loc8_ == "h")
            {
               _loc16_ = org.utils.SimpleDateFormatter._getInt(val,_loc5_,_loc8_.length,2);
               if(_loc16_ == null || (_loc16_ < 1 || _loc16_ > 12))
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc16_.length;
            }
            else if(_loc8_ == "HH" || _loc8_ == "H")
            {
               _loc16_ = org.utils.SimpleDateFormatter._getInt(val,_loc5_,_loc8_.length,2);
               if(_loc16_ == null || (_loc16_ < 0 || _loc16_ > 23))
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc16_.length;
            }
            else if(_loc8_ == "KK" || _loc8_ == "K")
            {
               _loc16_ = org.utils.SimpleDateFormatter._getInt(val,_loc5_,_loc8_.length,2);
               if(_loc16_ == null || (_loc16_ < 0 || _loc16_ > 11))
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc16_.length;
            }
            else if(_loc8_ == "kk" || _loc8_ == "k")
            {
               _loc16_ = org.utils.SimpleDateFormatter._getInt(val,_loc5_,_loc8_.length,2);
               if(_loc16_ == null || (_loc16_ < 1 || _loc16_ > 24))
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc16_.length;
               _loc16_ = _loc16_ - 1;
            }
            else if(_loc8_ == "mm" || _loc8_ == "m")
            {
               _loc17_ = org.utils.SimpleDateFormatter._getInt(val,_loc5_,_loc8_.length,2);
               if(_loc17_ == null || (_loc17_ < 0 || _loc17_ > 59))
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc17_.length;
            }
            else if(_loc8_ == "ss" || _loc8_ == "s")
            {
               _loc18_ = org.utils.SimpleDateFormatter._getInt(val,_loc5_,_loc8_.length,2);
               if(_loc18_ == null || (_loc18_ < 0 || _loc18_ > 59))
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc18_.length;
            }
            else if(_loc8_ == "ii" || _loc8_ == "i")
            {
               _loc19_ = org.utils.SimpleDateFormatter._getInt(val,_loc5_,_loc8_.length,2);
               if(_loc19_ == null || (_loc19_ < 0 || _loc19_ > 999))
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc19_.length;
            }
            else if(_loc8_ == "a")
            {
               if(val.substring(_loc5_,_loc5_ + 2).toLowerCase() == "am")
               {
                  _loc20_ = "AM";
               }
               else if(val.substring(_loc5_,_loc5_ + 2).toLowerCase() == "pm")
               {
                  _loc20_ = "PM";
               }
               else
               {
                  return null;
               }
               _loc5_ = _loc5_ + 2;
            }
            else
            {
               if(val.substring(_loc5_,_loc5_ + _loc8_.length) != _loc8_)
               {
                  return null;
               }
               _loc5_ = _loc5_ + _loc8_.length;
            }
            continue;
         }
         if(_loc5_ != val.length)
         {
            return null;
         }
         if(_loc14_ == 2)
         {
            if(_loc13_ % 4 == 0 && _loc13_ % 100 != 0 || _loc13_ % 400 == 0)
            {
               if(_loc15_ > 29)
               {
                  return null;
               }
            }
            else if(_loc15_ > 28)
            {
               return null;
            }
         }
         if(_loc14_ == 4 || (_loc14_ == 6 || (_loc14_ == 9 || _loc14_ == 11)))
         {
            if(_loc15_ > 30)
            {
               return null;
            }
         }
         if(_loc16_ < 12 && _loc20_ == "PM")
         {
            _loc16_ = _loc16_ - 0 + 12;
         }
         else if(_loc16_ > 11 && _loc20_ == "AM")
         {
            _loc16_ = _loc16_ - 12;
         }
         var _loc25_ = new Date(_loc13_,_loc14_ - 1,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_);
         return _loc25_;
      }
      return null;
   }
   static function _isInteger(val)
   {
      var _loc3_ = "1234567890";
      var _loc4_ = 0;
      while(_loc4_ < val.length)
      {
         if(_loc3_.indexOf(val.charAt(_loc4_)) == -1)
         {
            return false;
         }
         _loc4_ = _loc4_ + 1;
      }
      return true;
   }
   static function _getInt(str, i, minlength, maxlength)
   {
      var _loc6_ = maxlength;
      while(_loc6_ >= minlength)
      {
         var _loc7_ = str.substring(i,i + _loc6_);
         if(_loc7_.length < minlength)
         {
            return null;
         }
         if(org.utils.SimpleDateFormatter._isInteger(_loc7_))
         {
            return _loc7_;
         }
         _loc6_ = _loc6_ - 1;
      }
      return null;
   }
}
