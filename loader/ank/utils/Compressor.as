class ank.utils.Compressor
{
	static var ZIPKEY = new Array("_a","_b","_c","_d","_e","_f","_g","_h","_i","_j","_k","_l","_m","_n","_o","_p","_q","_r","_s","_t","_u","_v","_w","_x","_y","_z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9","-","_");
	static var ZKARRAY = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9","-","_");
	static var _self = new ank.utils.();
	function Compressor()
	{
		this.initialize();
	}
	function initialize()
	{
		var var2 = ank.utils.Compressor.ZKARRAY.length - 1;
		this._hashCodes = new Object();
		while(var2 >= 0)
		{
			this._hashCodes[ank.utils.Compressor.ZKARRAY[var2]] = var2;
			var2 = var2 - 1;
		}
	}
	static function decode64(§\x12\x1b§)
	{
		return ank.utils.Compressor._self._hashCodes[var2];
	}
	static function encode64(§\x1e\n\x0f§)
	{
		return ank.utils.Compressor.ZKARRAY[var2];
	}
}
