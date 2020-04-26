class eval("\x1e\x19\x13").utils.SimpleDateFormatter
{
	static var MONTH_NAMES_EN = new Array("January","February","March","April","May","June","July","August","September","October","November","December","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
	static var MONTH_NAMES_FR = new Array("Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre","Jan","Fev","Mar","Avr","Mai","Jun","Jui","Aou","Sep","Oct","Nov","Dec");
	static var MONTH_NAMES_DE = new Array("Januar","Februar","März","April","Mai","Juni","Juli","August","September","Oktober","November","Dezember","Jan","Feb","Mär","Apr","Mai","Jun","Jul","Aug","Sep","Okt","Nov","Dez");
	static var MONTH_NAMES_ES = new Array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre","Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic");
	static var MONTH_NAMES_PT = new Array("Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro","Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez");
	static var MONTH_NAMES_NL = new Array("Januari","Februari","Maart","April","Mei","Juni","Juli","Augustus","September","Oktober","November","December","Jan","Feb","Mrt","April","Mei","Juni","Juli","Aug","Sept","Okt","Nov","Dec");
	static var MONTH_NAMES_IT = new Array("Gennaio","Febbraio","Marzo","Aprile","Maggio","Giugno","Luglio","Agosto","Settembre","Ottobre","Novembre","Dicembre","Gen","Feb ","Mar","Apr","Mag","Giu ","Lug","Ago","Sett","Ott","Nov","Dic");
	static var MONTH_NAMES = {en:eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES_EN,fr:eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES_FR,de:eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES_DE,es:eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES_ES,pt:eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES_PT,nl:eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES_NL,it:eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES_IT};
	static var DAY_NAMES_EN = new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sun","Mon","Tue","Wed","Thu","Fri","Sat");
	static var DAY_NAMES_FR = new Array("Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi","Dim","Lun","Mar","Mer","Jeu","Ven","Sam");
	static var DAY_NAMES_DE = new Array("Sonntag","Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag","So","Mo","Di","Mi","Do","Fr","Sa");
	static var DAY_NAMES_ES = new Array("Domingo","Lunes","Martes","Miércoles","Jueves","Viernes","Sábado","Dom","Lun","Mar","Mié","Jue","Vie","Sáb");
	static var DAY_NAMES_PT = new Array("Domingo","Terça-feira","Quarta-feira","Quinta-feira","Sexta-feira","Sábado","Segunda-feira","Dom","Ter","Qua","Qui","Sex","Sáb","Seg");
	static var DAY_NAMES_NL = new Array("Zondag","Maandag","Dinsdag","Woensdag","Donderdag","Vrijdag","Zaterdag","Zo","Ma","Di","Wo","Do","Vrij","Za");
	static var DAY_NAMES_IT = new Array("Domenica","Lunedi","Martedì","Mercoledì","Giovedi","Venerdì","Sabato","Sole","Lun","Mar","Mer","Gio","Ven","Sab");
	static var DAY_NAMES = {en:eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES_EN,fr:eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES_FR,de:eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES_DE,es:eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES_ES,pt:eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES_PT,nl:eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES_NL,it:eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES_IT};
	function SimpleDateFormatter()
	{
	}
	static function LZ(loc2)
	{
		return (!(loc2 < 0 || loc2 > 9)?"0":"") + loc2;
	}
	static function formatDate(date, §\x0f\x06§, §\f\x1c§)
	{
		if(loc4 == undefined)
		{
			loc4 = "en";
		}
		loc3 = loc3 + "";
		var loc5 = "";
		var loc6 = 0;
		var loc7 = "";
		var loc8 = "";
		var loc9 = date.getYear() + "";
		var loc10 = date.getMonth() + 1;
		var loc11 = date.getDate();
		var loc12 = date.getDay();
		var loc13 = date.getHours();
		var loc14 = date.getMinutes();
		var loc15 = date.getSeconds();
		var loc16 = date.getMilliseconds();
		var loc17 = new Object();
		if(loc9.length < 4)
		{
			loc9 = "" + (loc9 - 0 + 1900);
		}
		loc17.y = "" + loc9;
		loc17.yyyy = loc9;
		loc17.yy = loc9.substring(2,4);
		loc17.M = loc10;
		loc17.MM = eval("\x1e\x19\x13").utils.SimpleDateFormatter.LZ(loc10);
		loc17.MMM = eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES[loc4][loc10 - 1];
		loc17.NNN = eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES[loc4][loc10 + 11];
		loc17.d = loc11;
		loc17.dd = eval("\x1e\x19\x13").utils.SimpleDateFormatter.LZ(loc11);
		loc17.E = eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES[loc4][loc12 + 7];
		loc17.EE = eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES[loc4][loc12];
		loc17.H = loc13;
		loc17.HH = eval("\x1e\x19\x13").utils.SimpleDateFormatter.LZ(loc13);
		if(loc13 == 0)
		{
			loc17.h = 12;
		}
		else if(loc13 > 12)
		{
			loc17.h = loc13 - 12;
		}
		else
		{
			loc17.h = loc13;
		}
		loc17.hh = eval("\x1e\x19\x13").utils.SimpleDateFormatter.LZ(loc17.h);
		if(loc13 > 11)
		{
			loc17.K = loc13 - 12;
		}
		else
		{
			loc17.K = loc13;
		}
		loc17.k = loc13 + 1;
		loc17.KK = eval("\x1e\x19\x13").utils.SimpleDateFormatter.LZ(loc17.K);
		loc17.kk = eval("\x1e\x19\x13").utils.SimpleDateFormatter.LZ(loc17.k);
		if(loc13 > 11)
		{
			loc17.a = "PM";
		}
		else
		{
			loc17.a = "AM";
		}
		loc17.m = loc14;
		loc17.mm = eval("\x1e\x19\x13").utils.SimpleDateFormatter.LZ(loc14);
		loc17.s = loc15;
		loc17.ss = eval("\x1e\x19\x13").utils.SimpleDateFormatter.LZ(loc15);
		loc17.i = loc16;
		loc17.ii = eval("\x1e\x19\x13").utils.SimpleDateFormatter.LZ(loc16);
		while(loc6 < loc3.length)
		{
			loc7 = loc3.charAt(loc6);
			loc8 = "";
			while(loc3.charAt(loc6) == loc7 && loc6 < loc3.length)
			{
				loc6;
				loc8 = loc8 + loc3.charAt(loc6++);
			}
			if(loc17[loc8] != null)
			{
				loc5 = loc5 + loc17[loc8];
			}
			else
			{
				loc5 = loc5 + loc8;
			}
		}
		return loc5;
	}
	static function isDate(loc2, loc3, loc4)
	{
		var loc5 = eval("\x1e\x19\x13").utils.SimpleDateFormatter.getDateFromFormat(loc2,loc3,loc4);
		if(loc5 == 0)
		{
			return false;
		}
		return true;
	}
	static function compareDates(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		var loc8 = eval("\x1e\x19\x13").utils.SimpleDateFormatter.getDateFromFormat(loc2,loc3,loc4);
		var loc9 = eval("\x1e\x19\x13").utils.SimpleDateFormatter.getDateFromFormat(loc5,loc6,loc7);
		if(loc8 == 0 || loc9 == 0)
		{
			return -1;
		}
		if(loc8 > loc9)
		{
			return 1;
		}
		return 0;
	}
	static function getDateFromFormat(loc2, loc3, loc4)
	{
		if(loc4 == undefined)
		{
			loc4 = "en";
		}
		loc2 = loc2 + "";
		loc3 = loc3 + "";
		var loc5 = 0;
		var loc6 = 0;
		var loc7 = "";
		var loc8 = "";
		var loc9 = "";
		var loc12 = new Date();
		var loc13 = loc12.getYear();
		var loc14 = loc12.getMonth() + 1;
		var loc15 = 1;
		var loc16 = loc12.getHours();
		var loc17 = loc12.getMinutes();
		var loc18 = loc12.getSeconds();
		var loc19 = loc12.getMilliseconds();
		var loc20 = "";
		while(true)
		{
			if(loc6 < loc3.length)
			{
				loc7 = loc3.charAt(loc6);
				loc8 = "";
				while(loc3.charAt(loc6) == loc7 && loc6 < loc3.length)
				{
					loc6;
					loc8 = loc8 + loc3.charAt(loc6++);
				}
				if(loc8 == "yyyy" || (loc8 == "yy" || loc8 == "y"))
				{
					if(loc8 == "yyyy")
					{
						var loc10 = 4;
						var loc11 = 4;
					}
					if(loc8 == "yy")
					{
						loc10 = 2;
						loc11 = 2;
					}
					if(loc8 == "y")
					{
						loc10 = 2;
						loc11 = 4;
					}
					loc13 = eval("\x1e\x19\x13").utils.SimpleDateFormatter._getInt(loc2,loc5,loc10,loc11);
					if(loc13 == null)
					{
						return null;
					}
					loc5 = loc5 + loc13.length;
					if(loc13.length == 2)
					{
						if(loc13 > 70)
						{
							loc13 = 1900 + (loc13 - 0);
						}
						else
						{
							loc13 = 2000 + (loc13 - 0);
						}
					}
				}
				else if(loc8 == "MMM" || loc8 == "NNN")
				{
					loc14 = 0;
					var loc21 = 0;
					while(loc21 < eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES[loc4].length)
					{
						var loc22 = eval("\x1e\x19\x13").utils.SimpleDateFormatter.MONTH_NAMES[loc4][loc21];
						if(loc2.substring(loc5,loc5 + loc22.length).toLowerCase() == loc22.toLowerCase())
						{
							if(loc8 == "MMM" || loc8 == "NNN" && loc21 > 11)
							{
								loc14 = loc21 + 1;
								if(loc14 > 12)
								{
									loc14 = loc14 - 12;
								}
								loc5 = loc5 + loc22.length;
								break;
							}
						}
						loc21 = loc21 + 1;
					}
					if(loc14 < 1 || loc14 > 12)
					{
						break;
					}
				}
				else if(loc8 == "EE" || loc8 == "E")
				{
					var loc23 = 0;
					while(loc23 < eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES[loc4].length)
					{
						var loc24 = eval("\x1e\x19\x13").utils.SimpleDateFormatter.DAY_NAMES[loc4][loc23];
						if(loc2.substring(loc5,loc5 + loc24.length).toLowerCase() == loc24.toLowerCase())
						{
							loc5 = loc5 + loc24.length;
							break;
						}
						loc23 = loc23 + 1;
					}
				}
				else if(loc8 == "MM" || loc8 == "M")
				{
					loc14 = eval("\x1e\x19\x13").utils.SimpleDateFormatter._getInt(loc2,loc5,loc8.length,2);
					if(loc14 == null || (loc14 < 1 || loc14 > 12))
					{
						return null;
					}
					loc5 = loc5 + loc14.length;
				}
				else if(loc8 == "dd" || loc8 == "d")
				{
					loc15 = eval("\x1e\x19\x13").utils.SimpleDateFormatter._getInt(loc2,loc5,loc8.length,2);
					if(loc15 == null || (loc15 < 1 || loc15 > 31))
					{
						return null;
					}
					loc5 = loc5 + loc15.length;
				}
				else if(loc8 == "hh" || loc8 == "h")
				{
					loc16 = eval("\x1e\x19\x13").utils.SimpleDateFormatter._getInt(loc2,loc5,loc8.length,2);
					if(loc16 == null || (loc16 < 1 || loc16 > 12))
					{
						return null;
					}
					loc5 = loc5 + loc16.length;
				}
				else if(loc8 == "HH" || loc8 == "H")
				{
					loc16 = eval("\x1e\x19\x13").utils.SimpleDateFormatter._getInt(loc2,loc5,loc8.length,2);
					if(loc16 == null || (loc16 < 0 || loc16 > 23))
					{
						return null;
					}
					loc5 = loc5 + loc16.length;
				}
				else if(loc8 == "KK" || loc8 == "K")
				{
					loc16 = eval("\x1e\x19\x13").utils.SimpleDateFormatter._getInt(loc2,loc5,loc8.length,2);
					if(loc16 == null || (loc16 < 0 || loc16 > 11))
					{
						return null;
					}
					loc5 = loc5 + loc16.length;
				}
				else if(loc8 == "kk" || loc8 == "k")
				{
					loc16 = eval("\x1e\x19\x13").utils.SimpleDateFormatter._getInt(loc2,loc5,loc8.length,2);
					if(loc16 == null || (loc16 < 1 || loc16 > 24))
					{
						return null;
					}
					loc5 = loc5 + loc16.length;
					loc16 = loc16 - 1;
				}
				else if(loc8 == "mm" || loc8 == "m")
				{
					loc17 = eval("\x1e\x19\x13").utils.SimpleDateFormatter._getInt(loc2,loc5,loc8.length,2);
					if(loc17 == null || (loc17 < 0 || loc17 > 59))
					{
						return null;
					}
					loc5 = loc5 + loc17.length;
				}
				else if(loc8 == "ss" || loc8 == "s")
				{
					loc18 = eval("\x1e\x19\x13").utils.SimpleDateFormatter._getInt(loc2,loc5,loc8.length,2);
					if(loc18 == null || (loc18 < 0 || loc18 > 59))
					{
						return null;
					}
					loc5 = loc5 + loc18.length;
				}
				else if(loc8 == "ii" || loc8 == "i")
				{
					loc19 = eval("\x1e\x19\x13").utils.SimpleDateFormatter._getInt(loc2,loc5,loc8.length,2);
					if(loc19 == null || (loc19 < 0 || loc19 > 999))
					{
						return null;
					}
					loc5 = loc5 + loc19.length;
				}
				else if(loc8 == "a")
				{
					if(loc2.substring(loc5,loc5 + 2).toLowerCase() == "am")
					{
						loc20 = "AM";
					}
					else if(loc2.substring(loc5,loc5 + 2).toLowerCase() == "pm")
					{
						loc20 = "PM";
					}
					else
					{
						return null;
					}
					loc5 = loc5 + 2;
				}
				else
				{
					if(loc2.substring(loc5,loc5 + loc8.length) != loc8)
					{
						return null;
					}
					loc5 = loc5 + loc8.length;
				}
				continue;
			}
			if(loc5 != loc2.length)
			{
				return null;
			}
			if(loc14 == 2)
			{
				if(loc13 % 4 == 0 && loc13 % 100 != 0 || loc13 % 400 == 0)
				{
					if(loc15 > 29)
					{
						return null;
					}
				}
				else if(loc15 > 28)
				{
					return null;
				}
			}
			if(loc14 == 4 || (loc14 == 6 || (loc14 == 9 || loc14 == 11)))
			{
				if(loc15 > 30)
				{
					return null;
				}
			}
			if(loc16 < 12 && loc20 == "PM")
			{
				loc16 = loc16 - 0 + 12;
			}
			else if(loc16 > 11 && loc20 == "AM")
			{
				loc16 = loc16 - 12;
			}
			var loc25 = new Date(loc13,loc14 - 1,loc15,loc16,loc17,loc18,loc19);
			return loc25;
		}
		return null;
	}
	static function _isInteger(loc2)
	{
		var loc3 = "1234567890";
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			if(loc3.indexOf(loc2.charAt(loc4)) == -1)
			{
				return false;
			}
			loc4 = loc4 + 1;
		}
		return true;
	}
	static function _getInt(loc2, loc3, loc4, loc5)
	{
		var loc6 = loc5;
		while(loc6 >= loc4)
		{
			var loc7 = loc2.substring(loc3,loc3 + loc6);
			if(loc7.length < loc4)
			{
				return null;
			}
			if(eval("\x1e\x19\x13").utils.SimpleDateFormatter._isInteger(loc7))
			{
				return loc7;
			}
			loc6 = loc6 - 1;
		}
		return null;
	}
}
