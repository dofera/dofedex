class ank.utils.Md5
{
	var hexcase = 0;
	var b64pad = "";
	var chrsz = 8;
	function Md5()
	{
	}
	function hex_md5(var2)
	{
		return this.binl2hex(this.core_md5(this.str2binl(var2),var2.length * this.chrsz));
	}
	function b64_md5(var2)
	{
		return this.binl2b64(this.core_md5(this.str2binl(var2),var2.length * this.chrsz));
	}
	function str_md5(var2)
	{
		return this.binl2str(this.core_md5(this.str2binl(var2),var2.length * this.chrsz));
	}
	function hex_hmac_md5(var2, var3)
	{
		return this.binl2hex(this.core_hmac_md5(var2,var3));
	}
	function b64_hmac_md5(var2, var3)
	{
		return this.binl2b64(this.core_hmac_md5(var2,var3));
	}
	function str_hmac_md5(var2, var3)
	{
		return this.binl2str(this.core_hmac_md5(var2,var3));
	}
	function md5_vm_test()
	{
		return this.hex_md5("abc") == "900150983cd24fb0d6963f7d28e17f72";
	}
	function core_md5(var2, var3)
	{
		var2[var3 >> 5] = var2[var3 >> 5] | 128 << var3 % 32;
		var2[(var3 + 64 >>> 9 << 4) + 14] = var3;
		var var4 = 1732584193;
		var var5 = -271733879;
		var var6 = -1732584194;
		var var7 = 271733878;
		var var8 = 0;
		while(var8 < var2.length)
		{
			var var9 = var4;
			var var10 = var5;
			var var11 = var6;
			var var12 = var7;
			var4 = this.md5_ff(var4,var5,var6,var7,var2[var8 + 0],7,-680876936);
			var7 = this.md5_ff(var7,var4,var5,var6,var2[var8 + 1],12,-389564586);
			var6 = this.md5_ff(var6,var7,var4,var5,var2[var8 + 2],17,606105819);
			var5 = this.md5_ff(var5,var6,var7,var4,var2[var8 + 3],22,-1044525330);
			var4 = this.md5_ff(var4,var5,var6,var7,var2[var8 + 4],7,-176418897);
			var7 = this.md5_ff(var7,var4,var5,var6,var2[var8 + 5],12,1200080426);
			var6 = this.md5_ff(var6,var7,var4,var5,var2[var8 + 6],17,-1473231341);
			var5 = this.md5_ff(var5,var6,var7,var4,var2[var8 + 7],22,-45705983);
			var4 = this.md5_ff(var4,var5,var6,var7,var2[var8 + 8],7,1770035416);
			var7 = this.md5_ff(var7,var4,var5,var6,var2[var8 + 9],12,-1958414417);
			var6 = this.md5_ff(var6,var7,var4,var5,var2[var8 + 10],17,-42063);
			var5 = this.md5_ff(var5,var6,var7,var4,var2[var8 + 11],22,-1990404162);
			var4 = this.md5_ff(var4,var5,var6,var7,var2[var8 + 12],7,1804603682);
			var7 = this.md5_ff(var7,var4,var5,var6,var2[var8 + 13],12,-40341101);
			var6 = this.md5_ff(var6,var7,var4,var5,var2[var8 + 14],17,-1502002290);
			var5 = this.md5_ff(var5,var6,var7,var4,var2[var8 + 15],22,1236535329);
			var4 = this.md5_gg(var4,var5,var6,var7,var2[var8 + 1],5,-165796510);
			var7 = this.md5_gg(var7,var4,var5,var6,var2[var8 + 6],9,-1069501632);
			var6 = this.md5_gg(var6,var7,var4,var5,var2[var8 + 11],14,643717713);
			var5 = this.md5_gg(var5,var6,var7,var4,var2[var8 + 0],20,-373897302);
			var4 = this.md5_gg(var4,var5,var6,var7,var2[var8 + 5],5,-701558691);
			var7 = this.md5_gg(var7,var4,var5,var6,var2[var8 + 10],9,38016083);
			var6 = this.md5_gg(var6,var7,var4,var5,var2[var8 + 15],14,-660478335);
			var5 = this.md5_gg(var5,var6,var7,var4,var2[var8 + 4],20,-405537848);
			var4 = this.md5_gg(var4,var5,var6,var7,var2[var8 + 9],5,568446438);
			var7 = this.md5_gg(var7,var4,var5,var6,var2[var8 + 14],9,-1019803690);
			var6 = this.md5_gg(var6,var7,var4,var5,var2[var8 + 3],14,-187363961);
			var5 = this.md5_gg(var5,var6,var7,var4,var2[var8 + 8],20,1163531501);
			var4 = this.md5_gg(var4,var5,var6,var7,var2[var8 + 13],5,-1444681467);
			var7 = this.md5_gg(var7,var4,var5,var6,var2[var8 + 2],9,-51403784);
			var6 = this.md5_gg(var6,var7,var4,var5,var2[var8 + 7],14,1735328473);
			var5 = this.md5_gg(var5,var6,var7,var4,var2[var8 + 12],20,-1926607734);
			var4 = this.md5_hh(var4,var5,var6,var7,var2[var8 + 5],4,-378558);
			var7 = this.md5_hh(var7,var4,var5,var6,var2[var8 + 8],11,-2022574463);
			var6 = this.md5_hh(var6,var7,var4,var5,var2[var8 + 11],16,1839030562);
			var5 = this.md5_hh(var5,var6,var7,var4,var2[var8 + 14],23,-35309556);
			var4 = this.md5_hh(var4,var5,var6,var7,var2[var8 + 1],4,-1530992060);
			var7 = this.md5_hh(var7,var4,var5,var6,var2[var8 + 4],11,1272893353);
			var6 = this.md5_hh(var6,var7,var4,var5,var2[var8 + 7],16,-155497632);
			var5 = this.md5_hh(var5,var6,var7,var4,var2[var8 + 10],23,-1094730640);
			var4 = this.md5_hh(var4,var5,var6,var7,var2[var8 + 13],4,681279174);
			var7 = this.md5_hh(var7,var4,var5,var6,var2[var8 + 0],11,-358537222);
			var6 = this.md5_hh(var6,var7,var4,var5,var2[var8 + 3],16,-722521979);
			var5 = this.md5_hh(var5,var6,var7,var4,var2[var8 + 6],23,76029189);
			var4 = this.md5_hh(var4,var5,var6,var7,var2[var8 + 9],4,-640364487);
			var7 = this.md5_hh(var7,var4,var5,var6,var2[var8 + 12],11,-421815835);
			var6 = this.md5_hh(var6,var7,var4,var5,var2[var8 + 15],16,530742520);
			var5 = this.md5_hh(var5,var6,var7,var4,var2[var8 + 2],23,-995338651);
			var4 = this.md5_ii(var4,var5,var6,var7,var2[var8 + 0],6,-198630844);
			var7 = this.md5_ii(var7,var4,var5,var6,var2[var8 + 7],10,1126891415);
			var6 = this.md5_ii(var6,var7,var4,var5,var2[var8 + 14],15,-1416354905);
			var5 = this.md5_ii(var5,var6,var7,var4,var2[var8 + 5],21,-57434055);
			var4 = this.md5_ii(var4,var5,var6,var7,var2[var8 + 12],6,1700485571);
			var7 = this.md5_ii(var7,var4,var5,var6,var2[var8 + 3],10,-1894986606);
			var6 = this.md5_ii(var6,var7,var4,var5,var2[var8 + 10],15,-1051523);
			var5 = this.md5_ii(var5,var6,var7,var4,var2[var8 + 1],21,-2054922799);
			var4 = this.md5_ii(var4,var5,var6,var7,var2[var8 + 8],6,1873313359);
			var7 = this.md5_ii(var7,var4,var5,var6,var2[var8 + 15],10,-30611744);
			var6 = this.md5_ii(var6,var7,var4,var5,var2[var8 + 6],15,-1560198380);
			var5 = this.md5_ii(var5,var6,var7,var4,var2[var8 + 13],21,1309151649);
			var4 = this.md5_ii(var4,var5,var6,var7,var2[var8 + 4],6,-145523070);
			var7 = this.md5_ii(var7,var4,var5,var6,var2[var8 + 11],10,-1120210379);
			var6 = this.md5_ii(var6,var7,var4,var5,var2[var8 + 2],15,718787259);
			var5 = this.md5_ii(var5,var6,var7,var4,var2[var8 + 9],21,-343485551);
			var4 = this.safe_add(var4,var9);
			var5 = this.safe_add(var5,var10);
			var6 = this.safe_add(var6,var11);
			var7 = this.safe_add(var7,var12);
			var8 = var8 + 16;
		}
		return [var4,var5,var6,var7];
	}
	function md5_cmn(var2, var3, var4, var5, var6, var7)
	{
		return this.safe_add(this.bit_rol(this.safe_add(this.safe_add(var3,var2),this.safe_add(var5,var7)),var6),var4);
	}
	function md5_ff(var2, var3, var4, var5, var6, var7, var8)
	{
		return this.md5_cmn(var3 & var4 | (var3 ^ -1) & var5,var2,var3,var6,var7,var8);
	}
	function md5_gg(var2, var3, var4, var5, var6, var7, var8)
	{
		return this.md5_cmn(var3 & var5 | var4 & (var5 ^ -1),var2,var3,var6,var7,var8);
	}
	function md5_hh(var2, var3, var4, var5, var6, var7, var8)
	{
		return this.md5_cmn(var3 ^ var4 ^ var5,var2,var3,var6,var7,var8);
	}
	function md5_ii(var2, var3, var4, var5, var6, var7, var8)
	{
		return this.md5_cmn(var4 ^ (var3 | var5 ^ -1),var2,var3,var6,var7,var8);
	}
	function core_hmac_md5(var2, var3)
	{
		var var4 = this.str2binl(var2);
		if(var4.length > 16)
		{
			var4 = this.core_md5(var4,var2.length * this.chrsz);
		}
		var var5 = (Array)16;
		var var6 = (Array)16;
		var var7 = 0;
		while(var7 < 16)
		{
			var5[var7] = var4[var7] ^ 909522486;
			var6[var7] = var4[var7] ^ 1549556828;
			var7 = var7 + 1;
		}
		var var8 = this.core_md5(var5.concat(this.str2binl(var3)),512 + var3.length * this.chrsz);
		return this.core_md5(var6.concat(var8),512 + 128);
	}
	function safe_add(var2, var3)
	{
		var var4 = (var2 & 65535) + (var3 & 65535);
		var var5 = (var2 >> 16) + (var3 >> 16) + (var4 >> 16);
		return var5 << 16 | var4 & 65535;
	}
	function bit_rol(var2, var3)
	{
		return var2 << var3 | var2 >>> 32 - var3;
	}
	function str2binl(var2)
	{
		var var3 = new Array();
		var var4 = (1 << this.chrsz) - 1;
		var var5 = 0;
		while(var5 < var2.length * this.chrsz)
		{
			var3[var5 >> 5] = var3[var5 >> 5] | (var2.charCodeAt(var5 / this.chrsz) & var4) << var5 % 32;
			var5 = var5 + this.chrsz;
		}
		return var3;
	}
	function binl2str(var2)
	{
		var var3 = "";
		var var4 = (1 << this.chrsz) - 1;
		var var5 = 0;
		while(var5 < var2.length * 32)
		{
			var3 = var3 + String.fromCharCode(var2[var5 >> 5] >>> var5 % 32 & var4);
			var5 = var5 + this.chrsz;
		}
		return var3;
	}
	function binl2hex(var2)
	{
		var var3 = !this.hexcase?"0123456789abcdef":"0123456789ABCDEF";
		var var4 = "";
		var var5 = 0;
		while(var5 < var2.length * 4)
		{
			var4 = var4 + (var3.charAt(var2[var5 >> 2] >> var5 % 4 * 8 + 4 & 15) + var3.charAt(var2[var5 >> 2] >> var5 % 4 * 8 & 15));
			var5 = var5 + 1;
		}
		return var4;
	}
	function binl2b64(var2)
	{
		var var3 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		var var4 = "";
		var var5 = 0;
		while(var5 < var2.length * 4)
		{
			var var6 = (var2[var5 >> 2] >> 8 * (var5 % 4) & 255) << 16 | (var2[var5 + 1 >> 2] >> 8 * ((var5 + 1) % 4) & 255) << 8 | var2[var5 + 2 >> 2] >> 8 * ((var5 + 2) % 4) & 255;
			var var7 = 0;
			while(var7 < 4)
			{
				if(var5 * 8 + var7 * 6 > var2.length * 32)
				{
					var4 = var4 + this.b64pad;
				}
				else
				{
					var4 = var4 + var3.charAt(var6 >> 6 * (3 - var7) & 63);
				}
				var7 = var7 + 1;
			}
			var5 = var5 + 3;
		}
		return var4;
	}
}
