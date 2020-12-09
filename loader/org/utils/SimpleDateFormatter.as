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
	static function LZ(§\x1e\n\x04§)
	{
		return (!(var2 < 0 || var2 > 9)?"0":"") + var2;
	}
	static function formatDate(date, §\x0e\f§, §\f\n§)
	{
		if(var4 == undefined)
		{
			var4 = "en";
		}
		var3 = var3 + "";
		var var5 = "";
		var var6 = 0;
		var var7 = "";
		var var8 = "";
		var var9 = date.getYear() + "";
		var var10 = date.getMonth() + 1;
		var var11 = date.getDate();
		var var12 = date.getDay();
		var var13 = date.getHours();
		var var14 = date.getMinutes();
		var var15 = date.getSeconds();
		var var16 = date.getMilliseconds();
		var var17 = new Object();
		if(var9.length < 4)
		{
			var9 = "" + (var9 - 0 + 1900);
		}
		var17.y = "" + var9;
		var17.yyyy = var9;
		var17.yy = var9.substring(2,4);
		var17.M = var10;
		var17.MM = org.utils.SimpleDateFormatter.LZ(var10);
		var17.MMM = org.utils.SimpleDateFormatter.MONTH_NAMES[var4][var10 - 1];
		var17.NNN = org.utils.SimpleDateFormatter.MONTH_NAMES[var4][var10 + 11];
		var17.d = var11;
		var17.dd = org.utils.SimpleDateFormatter.LZ(var11);
		var17.E = org.utils.SimpleDateFormatter.DAY_NAMES[var4][var12 + 7];
		var17.EE = org.utils.SimpleDateFormatter.DAY_NAMES[var4][var12];
		var17.H = var13;
		var17.HH = org.utils.SimpleDateFormatter.LZ(var13);
		if(var13 == 0)
		{
			var17.h = 12;
		}
		else if(var13 > 12)
		{
			var17.h = var13 - 12;
		}
		else
		{
			var17.h = var13;
		}
		var17.hh = org.utils.SimpleDateFormatter.LZ(var17.h);
		if(var13 > 11)
		{
			var17.K = var13 - 12;
		}
		else
		{
			var17.K = var13;
		}
		var17.k = var13 + 1;
		var17.KK = org.utils.SimpleDateFormatter.LZ(var17.K);
		var17.kk = org.utils.SimpleDateFormatter.LZ(var17.k);
		if(var13 > 11)
		{
			var17.a = "PM";
		}
		else
		{
			var17.a = "AM";
		}
		var17.m = var14;
		var17.mm = org.utils.SimpleDateFormatter.LZ(var14);
		var17.s = var15;
		var17.ss = org.utils.SimpleDateFormatter.LZ(var15);
		var17.i = var16;
		var17.ii = org.utils.SimpleDateFormatter.LZ(var16);
		while(var6 < var3.length)
		{
			var7 = var3.charAt(var6);
			var8 = "";
			while(var3.charAt(var6) == var7 && var6 < var3.length)
			{
				var6;
				var8 = var8 + var3.charAt(var6++);
			}
			if(var17[var8] != null)
			{
				var5 = var5 + var17[var8];
			}
			else
			{
				var5 = var5 + var8;
			}
		}
		return var5;
	}
	static function isDate(§\x1e\n\x10§, §\x0e\f§, §\f\n§)
	{
		var var5 = org.utils.SimpleDateFormatter.getDateFromFormat(var2,var3,var4);
		if(var5 == 0)
		{
			return false;
		}
		return true;
	}
	static function compareDates(§\x11\x13§, §\x11\x11§, §\f\t§, §\x11\x12§, §\x11\x10§, §\f\b§)
	{
		var var8 = org.utils.SimpleDateFormatter.getDateFromFormat(var2,var3,var4);
		var var9 = org.utils.SimpleDateFormatter.getDateFromFormat(var5,var6,var7);
		if(var8 == 0 || var9 == 0)
		{
			return -1;
		}
		if(var8 > var9)
		{
			return 1;
		}
		return 0;
	}
	static function getDateFromFormat(§\x1e\n\x10§, §\x0e\f§, §\f\n§)
	{
		if(var4 == undefined)
		{
			var4 = "en";
		}
		var2 = var2 + "";
		var3 = var3 + "";
		var var5 = 0;
		var var6 = 0;
		var var7 = "";
		var var8 = "";
		var var9 = "";
		var var12 = new Date();
		var var13 = var12.getYear();
		var var14 = var12.getMonth() + 1;
		var var15 = 1;
		var var16 = var12.getHours();
		var var17 = var12.getMinutes();
		var var18 = var12.getSeconds();
		var var19 = var12.getMilliseconds();
		var var20 = "";
		while(true)
		{
			if(var6 < var3.length)
			{
				var7 = var3.charAt(var6);
				var8 = "";
				while(var3.charAt(var6) == var7 && var6 < var3.length)
				{
					var6;
					var8 = var8 + var3.charAt(var6++);
				}
				if(var8 == "yyyy" || (var8 == "yy" || var8 == "y"))
				{
					if(var8 == "yyyy")
					{
						var var10 = 4;
						var var11 = 4;
					}
					if(var8 == "yy")
					{
						var10 = 2;
						var11 = 2;
					}
					if(var8 == "y")
					{
						var10 = 2;
						var11 = 4;
					}
					var13 = org.utils.SimpleDateFormatter._getInt(var2,var5,var10,var11);
					if(var13 == null)
					{
						return null;
					}
					var5 = var5 + var13.length;
					if(var13.length == 2)
					{
						if(var13 > 70)
						{
							var13 = 1900 + (var13 - 0);
						}
						else
						{
							var13 = 2000 + (var13 - 0);
						}
					}
				}
				else if(var8 == "MMM" || var8 == "NNN")
				{
					var14 = 0;
					var var21 = 0;
					while(var21 < org.utils.SimpleDateFormatter.MONTH_NAMES[var4].length)
					{
						var var22 = org.utils.SimpleDateFormatter.MONTH_NAMES[var4][var21];
						if(var2.substring(var5,var5 + var22.length).toLowerCase() == var22.toLowerCase())
						{
							if(var8 == "MMM" || var8 == "NNN" && var21 > 11)
							{
								var14 = var21 + 1;
								if(var14 > 12)
								{
									var14 = var14 - 12;
								}
								var5 = var5 + var22.length;
								break;
							}
						}
						var21 = var21 + 1;
					}
					if(var14 < 1 || var14 > 12)
					{
						break;
					}
				}
				else if(var8 == "EE" || var8 == "E")
				{
					var var23 = 0;
					while(var23 < org.utils.SimpleDateFormatter.DAY_NAMES[var4].length)
					{
						var var24 = org.utils.SimpleDateFormatter.DAY_NAMES[var4][var23];
						if(var2.substring(var5,var5 + var24.length).toLowerCase() == var24.toLowerCase())
						{
							var5 = var5 + var24.length;
							break;
						}
						var23 = var23 + 1;
					}
				}
				else if(var8 == "MM" || var8 == "M")
				{
					var14 = org.utils.SimpleDateFormatter._getInt(var2,var5,var8.length,2);
					if(var14 == null || (var14 < 1 || var14 > 12))
					{
						return null;
					}
					var5 = var5 + var14.length;
				}
				else if(var8 == "dd" || var8 == "d")
				{
					var15 = org.utils.SimpleDateFormatter._getInt(var2,var5,var8.length,2);
					if(var15 == null || (var15 < 1 || var15 > 31))
					{
						return null;
					}
					var5 = var5 + var15.length;
				}
				else if(var8 == "hh" || var8 == "h")
				{
					var16 = org.utils.SimpleDateFormatter._getInt(var2,var5,var8.length,2);
					if(var16 == null || (var16 < 1 || var16 > 12))
					{
						return null;
					}
					var5 = var5 + var16.length;
				}
				else if(var8 == "HH" || var8 == "H")
				{
					var16 = org.utils.SimpleDateFormatter._getInt(var2,var5,var8.length,2);
					if(var16 == null || (var16 < 0 || var16 > 23))
					{
						return null;
					}
					var5 = var5 + var16.length;
				}
				else if(var8 == "KK" || var8 == "K")
				{
					var16 = org.utils.SimpleDateFormatter._getInt(var2,var5,var8.length,2);
					if(var16 == null || (var16 < 0 || var16 > 11))
					{
						return null;
					}
					var5 = var5 + var16.length;
				}
				else if(var8 == "kk" || var8 == "k")
				{
					var16 = org.utils.SimpleDateFormatter._getInt(var2,var5,var8.length,2);
					if(var16 == null || (var16 < 1 || var16 > 24))
					{
						return null;
					}
					var5 = var5 + var16.length;
					var16 = var16 - 1;
				}
				else if(var8 == "mm" || var8 == "m")
				{
					var17 = org.utils.SimpleDateFormatter._getInt(var2,var5,var8.length,2);
					if(var17 == null || (var17 < 0 || var17 > 59))
					{
						return null;
					}
					var5 = var5 + var17.length;
				}
				else if(var8 == "ss" || var8 == "s")
				{
					var18 = org.utils.SimpleDateFormatter._getInt(var2,var5,var8.length,2);
					if(var18 == null || (var18 < 0 || var18 > 59))
					{
						return null;
					}
					var5 = var5 + var18.length;
				}
				else if(var8 == "ii" || var8 == "i")
				{
					var19 = org.utils.SimpleDateFormatter._getInt(var2,var5,var8.length,2);
					if(var19 == null || (var19 < 0 || var19 > 999))
					{
						return null;
					}
					var5 = var5 + var19.length;
				}
				else if(var8 == "a")
				{
					if(var2.substring(var5,var5 + 2).toLowerCase() == "am")
					{
						var20 = "AM";
					}
					else if(var2.substring(var5,var5 + 2).toLowerCase() == "pm")
					{
						var20 = "PM";
					}
					else
					{
						return null;
					}
					var5 = var5 + 2;
				}
				else
				{
					if(var2.substring(var5,var5 + var8.length) != var8)
					{
						return null;
					}
					var5 = var5 + var8.length;
				}
				continue;
			}
			if(var5 != var2.length)
			{
				return null;
			}
			if(var14 == 2)
			{
				if(var13 % 4 == 0 && var13 % 100 != 0 || var13 % 400 == 0)
				{
					if(var15 > 29)
					{
						return null;
					}
				}
				else if(var15 > 28)
				{
					return null;
				}
			}
			if(var14 == 4 || (var14 == 6 || (var14 == 9 || var14 == 11)))
			{
				if(var15 > 30)
				{
					return null;
				}
			}
			if(var16 < 12 && var20 == "PM")
			{
				var16 = var16 - 0 + 12;
			}
			else if(var16 > 11 && var20 == "AM")
			{
				var16 = var16 - 12;
			}
			var var25 = new Date(var13,var14 - 1,var15,var16,var17,var18,var19);
			return var25;
		}
		return null;
	}
	static function _isInteger(§\x1e\n\x10§)
	{
		var var3 = "1234567890";
		var var4 = 0;
		while(var4 < var2.length)
		{
			if(var3.indexOf(var2.charAt(var4)) == -1)
			{
				return false;
			}
			var4 = var4 + 1;
		}
		return true;
	}
	static function _getInt(§\x1e\f\x17§, §\r\x0b§, §\n\x10§, §\x0b\x0f§)
	{
		var var6 = var5;
		while(var6 >= var4)
		{
			var var7 = var2.substring(var3,var3 + var6);
			if(var7.length < var4)
			{
				return null;
			}
			if(org.utils.SimpleDateFormatter._isInteger(var7))
			{
				return var7;
			}
			var6 = var6 - 1;
		}
		return null;
	}
}
