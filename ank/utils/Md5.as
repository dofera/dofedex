class ank.utils.Md5
{
	var hexcase = 0;
	var b64pad = "";
	var chrsz = 8;
	function Md5()
	{
	}
	function hex_md5(loc2)
	{
		return this.binl2hex(this.core_md5(this.str2binl(loc2),loc2.length * this.chrsz));
	}
	function b64_md5(loc2)
	{
		return this.binl2b64(this.core_md5(this.str2binl(loc2),loc2.length * this.chrsz));
	}
	function str_md5(loc2)
	{
		return this.binl2str(this.core_md5(this.str2binl(loc2),loc2.length * this.chrsz));
	}
	function hex_hmac_md5(loc2, loc3)
	{
		return this.binl2hex(this.core_hmac_md5(loc2,loc3));
	}
	function b64_hmac_md5(loc2, loc3)
	{
		return this.binl2b64(this.core_hmac_md5(loc2,loc3));
	}
	function str_hmac_md5(loc2, loc3)
	{
		return this.binl2str(this.core_hmac_md5(loc2,loc3));
	}
	function md5_vm_test()
	{
		return this.hex_md5("abc") == "900150983cd24fb0d6963f7d28e17f72";
	}
	function core_md5(loc2, loc3)
	{
		loc2[loc3 >> 5] = loc2[loc3 >> 5] | 128 << loc3 % 32;
		loc2[(loc3 + 64 >>> 9 << 4) + 14] = loc3;
		var loc4 = 1732584193;
		var loc5 = -271733879;
		var loc6 = -1732584194;
		var loc7 = 271733878;
		var loc8 = 0;
		while(loc8 < loc2.length)
		{
			var loc9 = loc4;
			var loc10 = loc5;
			var loc11 = loc6;
			var loc12 = loc7;
			loc4 = this.md5_ff(loc4,loc5,loc6,loc7,loc2[loc8 + 0],7,-680876936);
			loc7 = this.md5_ff(loc7,loc4,loc5,loc6,loc2[loc8 + 1],12,-389564586);
			loc6 = this.md5_ff(loc6,loc7,loc4,loc5,loc2[loc8 + 2],17,606105819);
			loc5 = this.md5_ff(loc5,loc6,loc7,loc4,loc2[loc8 + 3],22,-1044525330);
			loc4 = this.md5_ff(loc4,loc5,loc6,loc7,loc2[loc8 + 4],7,-176418897);
			loc7 = this.md5_ff(loc7,loc4,loc5,loc6,loc2[loc8 + 5],12,1200080426);
			loc6 = this.md5_ff(loc6,loc7,loc4,loc5,loc2[loc8 + 6],17,-1473231341);
			loc5 = this.md5_ff(loc5,loc6,loc7,loc4,loc2[loc8 + 7],22,-45705983);
			loc4 = this.md5_ff(loc4,loc5,loc6,loc7,loc2[loc8 + 8],7,1770035416);
			loc7 = this.md5_ff(loc7,loc4,loc5,loc6,loc2[loc8 + 9],12,-1958414417);
			loc6 = this.md5_ff(loc6,loc7,loc4,loc5,loc2[loc8 + 10],17,-42063);
			loc5 = this.md5_ff(loc5,loc6,loc7,loc4,loc2[loc8 + 11],22,-1990404162);
			loc4 = this.md5_ff(loc4,loc5,loc6,loc7,loc2[loc8 + 12],7,1804603682);
			loc7 = this.md5_ff(loc7,loc4,loc5,loc6,loc2[loc8 + 13],12,-40341101);
			loc6 = this.md5_ff(loc6,loc7,loc4,loc5,loc2[loc8 + 14],17,-1502002290);
			loc5 = this.md5_ff(loc5,loc6,loc7,loc4,loc2[loc8 + 15],22,1236535329);
			loc4 = this.md5_gg(loc4,loc5,loc6,loc7,loc2[loc8 + 1],5,-165796510);
			loc7 = this.md5_gg(loc7,loc4,loc5,loc6,loc2[loc8 + 6],9,-1069501632);
			loc6 = this.md5_gg(loc6,loc7,loc4,loc5,loc2[loc8 + 11],14,643717713);
			loc5 = this.md5_gg(loc5,loc6,loc7,loc4,loc2[loc8 + 0],20,-373897302);
			loc4 = this.md5_gg(loc4,loc5,loc6,loc7,loc2[loc8 + 5],5,-701558691);
			loc7 = this.md5_gg(loc7,loc4,loc5,loc6,loc2[loc8 + 10],9,38016083);
			loc6 = this.md5_gg(loc6,loc7,loc4,loc5,loc2[loc8 + 15],14,-660478335);
			loc5 = this.md5_gg(loc5,loc6,loc7,loc4,loc2[loc8 + 4],20,-405537848);
			loc4 = this.md5_gg(loc4,loc5,loc6,loc7,loc2[loc8 + 9],5,568446438);
			loc7 = this.md5_gg(loc7,loc4,loc5,loc6,loc2[loc8 + 14],9,-1019803690);
			loc6 = this.md5_gg(loc6,loc7,loc4,loc5,loc2[loc8 + 3],14,-187363961);
			loc5 = this.md5_gg(loc5,loc6,loc7,loc4,loc2[loc8 + 8],20,1163531501);
			loc4 = this.md5_gg(loc4,loc5,loc6,loc7,loc2[loc8 + 13],5,-1444681467);
			loc7 = this.md5_gg(loc7,loc4,loc5,loc6,loc2[loc8 + 2],9,-51403784);
			loc6 = this.md5_gg(loc6,loc7,loc4,loc5,loc2[loc8 + 7],14,1735328473);
			loc5 = this.md5_gg(loc5,loc6,loc7,loc4,loc2[loc8 + 12],20,-1926607734);
			loc4 = this.md5_hh(loc4,loc5,loc6,loc7,loc2[loc8 + 5],4,-378558);
			loc7 = this.md5_hh(loc7,loc4,loc5,loc6,loc2[loc8 + 8],11,-2022574463);
			loc6 = this.md5_hh(loc6,loc7,loc4,loc5,loc2[loc8 + 11],16,1839030562);
			loc5 = this.md5_hh(loc5,loc6,loc7,loc4,loc2[loc8 + 14],23,-35309556);
			loc4 = this.md5_hh(loc4,loc5,loc6,loc7,loc2[loc8 + 1],4,-1530992060);
			loc7 = this.md5_hh(loc7,loc4,loc5,loc6,loc2[loc8 + 4],11,1272893353);
			loc6 = this.md5_hh(loc6,loc7,loc4,loc5,loc2[loc8 + 7],16,-155497632);
			loc5 = this.md5_hh(loc5,loc6,loc7,loc4,loc2[loc8 + 10],23,-1094730640);
			loc4 = this.md5_hh(loc4,loc5,loc6,loc7,loc2[loc8 + 13],4,681279174);
			loc7 = this.md5_hh(loc7,loc4,loc5,loc6,loc2[loc8 + 0],11,-358537222);
			loc6 = this.md5_hh(loc6,loc7,loc4,loc5,loc2[loc8 + 3],16,-722521979);
			loc5 = this.md5_hh(loc5,loc6,loc7,loc4,loc2[loc8 + 6],23,76029189);
			loc4 = this.md5_hh(loc4,loc5,loc6,loc7,loc2[loc8 + 9],4,-640364487);
			loc7 = this.md5_hh(loc7,loc4,loc5,loc6,loc2[loc8 + 12],11,-421815835);
			loc6 = this.md5_hh(loc6,loc7,loc4,loc5,loc2[loc8 + 15],16,530742520);
			loc5 = this.md5_hh(loc5,loc6,loc7,loc4,loc2[loc8 + 2],23,-995338651);
			loc4 = this.md5_ii(loc4,loc5,loc6,loc7,loc2[loc8 + 0],6,-198630844);
			loc7 = this.md5_ii(loc7,loc4,loc5,loc6,loc2[loc8 + 7],10,1126891415);
			loc6 = this.md5_ii(loc6,loc7,loc4,loc5,loc2[loc8 + 14],15,-1416354905);
			loc5 = this.md5_ii(loc5,loc6,loc7,loc4,loc2[loc8 + 5],21,-57434055);
			loc4 = this.md5_ii(loc4,loc5,loc6,loc7,loc2[loc8 + 12],6,1700485571);
			loc7 = this.md5_ii(loc7,loc4,loc5,loc6,loc2[loc8 + 3],10,-1894986606);
			loc6 = this.md5_ii(loc6,loc7,loc4,loc5,loc2[loc8 + 10],15,-1051523);
			loc5 = this.md5_ii(loc5,loc6,loc7,loc4,loc2[loc8 + 1],21,-2054922799);
			loc4 = this.md5_ii(loc4,loc5,loc6,loc7,loc2[loc8 + 8],6,1873313359);
			loc7 = this.md5_ii(loc7,loc4,loc5,loc6,loc2[loc8 + 15],10,-30611744);
			loc6 = this.md5_ii(loc6,loc7,loc4,loc5,loc2[loc8 + 6],15,-1560198380);
			loc5 = this.md5_ii(loc5,loc6,loc7,loc4,loc2[loc8 + 13],21,1309151649);
			loc4 = this.md5_ii(loc4,loc5,loc6,loc7,loc2[loc8 + 4],6,-145523070);
			loc7 = this.md5_ii(loc7,loc4,loc5,loc6,loc2[loc8 + 11],10,-1120210379);
			loc6 = this.md5_ii(loc6,loc7,loc4,loc5,loc2[loc8 + 2],15,718787259);
			loc5 = this.md5_ii(loc5,loc6,loc7,loc4,loc2[loc8 + 9],21,-343485551);
			loc4 = this.safe_add(loc4,loc9);
			loc5 = this.safe_add(loc5,loc10);
			loc6 = this.safe_add(loc6,loc11);
			loc7 = this.safe_add(loc7,loc12);
			loc8 = loc8 + 16;
		}
		return [loc4,loc5,loc6,loc7];
	}
	function md5_cmn(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		return this.safe_add(this.bit_rol(this.safe_add(this.safe_add(loc3,loc2),this.safe_add(loc5,loc7)),loc6),loc4);
	}
	function md5_ff(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		return this.md5_cmn(loc3 & loc4 | (loc3 ^ -1) & loc5,loc2,loc3,loc6,loc7,loc8);
	}
	function md5_gg(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		return this.md5_cmn(loc3 & loc5 | loc4 & (loc5 ^ -1),loc2,loc3,loc6,loc7,loc8);
	}
	function md5_hh(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		return this.md5_cmn(loc3 ^ loc4 ^ loc5,loc2,loc3,loc6,loc7,loc8);
	}
	function md5_ii(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		return this.md5_cmn(loc4 ^ (loc3 | loc5 ^ -1),loc2,loc3,loc6,loc7,loc8);
	}
	function core_hmac_md5(loc2, loc3)
	{
		var loc4 = this.str2binl(loc2);
		if(loc4.length > 16)
		{
			loc4 = this.core_md5(loc4,loc2.length * this.chrsz);
		}
		var loc5 = (Array)16;
		var loc6 = (Array)16;
		var loc7 = 0;
		while(loc7 < 16)
		{
			loc5[loc7] = loc4[loc7] ^ 909522486;
			loc6[loc7] = loc4[loc7] ^ 1549556828;
			loc7 = loc7 + 1;
		}
		var loc8 = this.core_md5(loc5.concat(this.str2binl(loc3)),512 + loc3.length * this.chrsz);
		return this.core_md5(loc6.concat(loc8),512 + 128);
	}
	function safe_add(loc2, loc3)
	{
		var loc4 = (loc2 & 65535) + (loc3 & 65535);
		var loc5 = (loc2 >> 16) + (loc3 >> 16) + (loc4 >> 16);
		return loc5 << 16 | loc4 & 65535;
	}
	function bit_rol(loc2, loc3)
	{
		return loc2 << loc3 | loc2 >>> 32 - loc3;
	}
	function str2binl(loc2)
	{
		var loc3 = new Array();
		var loc4 = (1 << this.chrsz) - 1;
		var loc5 = 0;
		while(loc5 < loc2.length * this.chrsz)
		{
			loc3[loc5 >> 5] = loc3[loc5 >> 5] | (loc2.charCodeAt(loc5 / this.chrsz) & loc4) << loc5 % 32;
			loc5 = loc5 + this.chrsz;
		}
		return loc3;
	}
	function binl2str(loc2)
	{
		var loc3 = "";
		var loc4 = (1 << this.chrsz) - 1;
		var loc5 = 0;
		while(loc5 < loc2.length * 32)
		{
			loc3 = loc3 + String.fromCharCode(loc2[loc5 >> 5] >>> loc5 % 32 & loc4);
			loc5 = loc5 + this.chrsz;
		}
		return loc3;
	}
	function binl2hex(loc2)
	{
		var loc3 = !this.hexcase?"0123456789abcdef":"0123456789ABCDEF";
		var loc4 = "";
		var loc5 = 0;
		while(loc5 < loc2.length * 4)
		{
			loc4 = loc4 + (loc3.charAt(loc2[loc5 >> 2] >> loc5 % 4 * 8 + 4 & 15) + loc3.charAt(loc2[loc5 >> 2] >> loc5 % 4 * 8 & 15));
			loc5 = loc5 + 1;
		}
		return loc4;
	}
	function binl2b64(loc2)
	{
		var loc3 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		var loc4 = "";
		var loc5 = 0;
		while(loc5 < loc2.length * 4)
		{
			var loc6 = (loc2[loc5 >> 2] >> 8 * (loc5 % 4) & 255) << 16 | (loc2[loc5 + 1 >> 2] >> 8 * ((loc5 + 1) % 4) & 255) << 8 | loc2[loc5 + 2 >> 2] >> 8 * ((loc5 + 2) % 4) & 255;
			var loc7 = 0;
			while(loc7 < 4)
			{
				if(loc5 * 8 + loc7 * 6 > loc2.length * 32)
				{
					loc4 = loc4 + this.b64pad;
				}
				else
				{
					loc4 = loc4 + loc3.charAt(loc6 >> 6 * (3 - loc7) & 63);
				}
				loc7 = loc7 + 1;
			}
			loc5 = loc5 + 3;
		}
		return loc4;
	}
}
