class dofus.graphics.gapi.ui.MakeReport extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MakeReport";
	static var FIRST_VIEW = 0;
	static var FAPENAL_VIEW = 1;
	function MakeReport()
	{
		super();
	}
	function __get__isAllAccounts()
	{
		return this._bAllAccounts;
	}
	function __set__isAllAccounts(var2)
	{
		this._bAllAccounts = var2;
		return this.__get__isAllAccounts();
	}
	function __get__targetPseudos()
	{
		return this._sTargetPseudos;
	}
	function __set__targetPseudos(var2)
	{
		this._sTargetPseudos = var2;
		return this.__get__targetPseudos();
	}
	function __get__description()
	{
		return this._sDescription;
	}
	function __set__description(var2)
	{
		this._sDescription = var2;
		return this.__get__description();
	}
	function __get__jailDialog()
	{
		return this._sJailDialog;
	}
	function __set__jailDialog(var2)
	{
		this._sJailDialog = var2;
		return this.__get__jailDialog();
	}
	function __get__penal()
	{
		return this._sPenal;
	}
	function __set__penal(var2)
	{
		this._sPenal = var2;
		return this.__get__penal();
	}
	function __get__findAccounts()
	{
		return this._sFindAccounts;
	}
	function __set__findAccounts(var2)
	{
		this._sFindAccounts = var2;
		return this.__get__findAccounts();
	}
	function __get__reason()
	{
		return this._sReason;
	}
	function __set__reason(var2)
	{
		this._sReason = var2;
		return this.__get__reason();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.MakeReport.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		this._btnCancel.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
		this._btnOk.addEventListener("click",this);
		this._btnSwitch.addEventListener("click",this);
		this._taDescription.addEventListener("change",this);
		this._taComplementary.addEventListener("change",this);
		this._taFindAccounts.addEventListener("change",this);
		this._taJailDialog.addEventListener("change",this);
		this._taPenal.addEventListener("change",this);
		this._tiReasonName.addEventListener("change",this);
	}
	function initTexts()
	{
		this._winBackground.title = "Make Report";
		this._lblTarget.text = "Target(s) :";
		this._lblReason.text = "Reason :";
		this._lblDescription.text = "Description :";
		this._lblJailDialog.text = "Jail dialog :";
		this._lblComplementary.text = "Comments :";
		this._lblAllAccounts.text = "All Accounts : " + (!this._bAllAccounts?"No":"Yes");
		this._btnOk.label = "Validate";
		this._btnCancel.label = "Cancel";
		this._btnSwitch.label = "Switch view";
		this._lblFindAccounts.text = "Find Accounts :";
		this._lblPenal.text = "Penal :";
	}
	function initData()
	{
		this._lblTargetName.text = this._sTargetPseudos;
		this._taDescription.text = this._sDescription;
		this._taFindAccounts.text = this._sFindAccounts;
		this._taJailDialog.text = this._sJailDialog;
		this._taPenal.text = this._sPenal;
		this._tiReasonName.text = this._sReason;
		this.showViewData(dofus.graphics.gapi.ui.MakeReport.FIRST_VIEW);
	}
	function showViewData(var2)
	{
		var var3 = var2 == dofus.graphics.gapi.ui.MakeReport.FIRST_VIEW;
		this._lblTarget._visible = var3;
		this._tiReasonName._visible = var3;
		this._lblReason._visible = var3;
		this._lblDescription._visible = var3;
		this._taDescription._visible = var3;
		this._lblComplementary._visible = var3;
		this._taComplementary._visible = var3;
		this._lblAllAccounts._visible = var3;
		this._lblTargetName._visible = var3;
		this._mcTextInputBackground._visible = var3;
		var var4 = var2 == dofus.graphics.gapi.ui.MakeReport.FAPENAL_VIEW;
		this._lblPenal._visible = var4;
		this._lblFindAccounts._visible = var4;
		this._lblJailDialog._visible = var4;
		this._taFindAccounts._visible = var4;
		this._taJailDialog._visible = var4;
		this._taPenal._visible = var4;
		this._nCurrentView = var2;
	}
	function makeReport()
	{
		if(!this.api.electron.enabled)
		{
			this.api.kernel.showMessage(undefined,"This feature is not compatible on a Flash Projector","ERROR_CHAT");
			return undefined;
		}
		if(this._sTargetPseudos == undefined || this._sTargetPseudos.length < 1)
		{
			this.api.kernel.showMessage(undefined,"Target(s) cannot be empty","ERROR_CHAT");
			return undefined;
		}
		if(this._sReason == undefined || this._sReason.length < 1)
		{
			this.api.kernel.showMessage(undefined,"Reason cannot be empty","ERROR_CHAT");
			return undefined;
		}
		if(this._sPenal == undefined || this._sPenal.length < 1)
		{
			this.api.kernel.showMessage(undefined,"Penal cannot be empty","ERROR_CHAT");
			return undefined;
		}
		var var2 = this.api.datacenter.Temporary.Report;
		var var3 = var2.targetAccountPseudo;
		var var4 = var2.targetAccountId;
		var var5 = var2.sanctionnatedAccounts;
		this.api.electron.makeReport(this._sReason,var3,var4,var5,this._sDescription,this._sFindAccounts,this._sPenal,this._sJailDialog,this._sComplementary);
		this.unloadThis();
	}
	function update()
	{
		var var2 = this.api.datacenter.Temporary.Report;
		this._sTargetPseudos = var2.targetPseudos;
		this._lblTargetName.text = this._sTargetPseudos;
		if(var2.description != undefined)
		{
			this._sDescription = this._taDescription.tf.htmlText + "\n" + var2.description;
			this._taDescription.text = this._sDescription;
		}
		this._sPenal = this._taPenal.tf.htmlText + "\n" + var2.penal;
		this._taPenal.text = this._sPenal;
		this._sFindAccounts = this._taFindAccounts.tf.htmlText + "\n" + var2.findAccounts;
		this._taFindAccounts.text = this._sFindAccounts;
		this.api.kernel.showMessage(undefined,"Report updated","COMMANDS_CHAT");
	}
	function destroy()
	{
		this.api.datacenter.Temporary.Report = undefined;
	}
	function change(var2)
	{
		var var3 = var2.target;
		if((var var0 = var3) !== this._taComplementary)
		{
			switch(null)
			{
				case this._taDescription:
					this._sDescription = var3.text;
					break;
				case this._taFindAccounts:
					this._sFindAccounts = var3.text;
					break;
				case this._taPenal:
					this._sPenal = var3.text;
					break;
				default:
					switch(null)
					{
						case this._tiReasonName:
							this._sReason = var3.text;
							break;
						case this._taJailDialog:
							this._sJailDialog = var3.text;
					}
			}
		}
		else
		{
			this._sComplementary = var3.text;
		}
	}
	function click(var2)
	{
		switch(var2.target)
		{
			case this._btnOk:
				this.api.kernel.showMessage(undefined,"Are you sure ?","CAUTION_YESNO",{name:"MakeReport",listener:this});
				break;
			default:
				switch(null)
				{
					case this._btnClose:
						break;
					case this._btnSwitch:
						var var3 = this._nCurrentView != dofus.graphics.gapi.ui.MakeReport.FIRST_VIEW?dofus.graphics.gapi.ui.MakeReport.FIRST_VIEW:dofus.graphics.gapi.ui.MakeReport.FAPENAL_VIEW;
						this.showViewData(var3);
				}
				break;
			case this._btnCancel:
				this.unloadThis();
		}
	}
	function yes(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoMakeReport")
		{
			this.makeReport();
		}
	}
}
