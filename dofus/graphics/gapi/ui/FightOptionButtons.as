class dofus.graphics.gapi.ui.FightOptionButtons extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "FightOptionButtons";
	function FightOptionButtons()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.FightOptionButtons.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function addListeners()
	{
		this._btnTactic.addEventListener("click",this);
		this._btnTactic.addEventListener("over",this);
		this._btnTactic.addEventListener("out",this);
		this._btnFlag.addEventListener("click",this);
		this._btnFlag.addEventListener("over",this);
		this._btnFlag.addEventListener("out",this);
		this._btnBlockJoinerExceptParty.addEventListener("click",this);
		this._btnBlockJoinerExceptParty.addEventListener("over",this);
		this._btnBlockJoinerExceptParty.addEventListener("out",this);
		this._btnBlockJoiner.addEventListener("click",this);
		this._btnBlockJoiner.addEventListener("over",this);
		this._btnBlockJoiner.addEventListener("out",this);
		this._btnHelp.addEventListener("click",this);
		this._btnHelp.addEventListener("over",this);
		this._btnHelp.addEventListener("out",this);
		this._btnBlockSpectators.addEventListener("click",this);
		this._btnBlockSpectators.addEventListener("over",this);
		this._btnBlockSpectators.addEventListener("out",this);
		this._btnToggleSprites.addEventListener("click",this);
		this._btnToggleSprites.addEventListener("over",this);
		this._btnToggleSprites.addEventListener("out",this);
	}
	function initData()
	{
		if(!this.api.datacenter.Game.isSpectator)
		{
			if(!this.api.datacenter.Player.inParty)
			{
				this._btnBlockJoinerExceptParty._visible = false;
				this._btnTactic._x = 642;
			}
			else
			{
				this._btnBlockJoinerExceptParty.selected = this.api.kernel.OptionsManager.getOption("FightGroupAutoLock");
				if(this._btnBlockJoinerExceptParty.selected)
				{
					this.api.network.Fights.blockJoinerExceptParty();
				}
				this._btnTactic._x = 622;
			}
		}
		else
		{
			this._btnBlockJoinerExceptParty._visible = false;
			this._btnBlockJoiner._visible = false;
			this._btnHelp._visible = false;
			this._btnBlockSpectators._visible = false;
			this._btnFlag._visible = false;
			this._btnTactic._x = 722;
		}
		this._btnTactic.selected = this.api.datacenter.Game.isTacticMode;
		this._btnToggleSprites._visible = false;
	}
	function onGameRunning()
	{
		this._btnBlockJoinerExceptParty._visible = false;
		this._btnBlockJoiner._visible = false;
		this._btnHelp._visible = false;
		this._btnToggleSprites._visible = true;
		this._btnTactic._x = 662;
	}
	function click(var2)
	{
		loop0:
		switch(var2.target)
		{
			case this._btnTactic:
				this.api.datacenter.Game.isTacticMode = !this.api.datacenter.Game.isTacticMode;
				break;
			case this._btnFlag:
				this.api.kernel.GameManager.switchToFlagSet();
				break;
			default:
				switch(null)
				{
					case this._btnBlockJoinerExceptParty:
						this.api.network.Fights.blockJoinerExceptParty();
						break loop0;
					case this._btnBlockJoiner:
						this.api.network.Fights.blockJoiner();
						break loop0;
					case this._btnHelp:
						this.api.network.Fights.needHelp();
						break loop0;
					default:
						switch(null)
						{
							case this._btnBlockSpectators:
								this.api.network.Fights.blockSpectators();
								break;
							case this._btnToggleSprites:
								this.api.datacenter.Basics.gfx_isSpritesHidden = !this.api.datacenter.Basics.gfx_isSpritesHidden;
								if(this.api.datacenter.Basics.gfx_isSpritesHidden)
								{
									this.api.gfx.spriteHandler.maskAllSprites();
									break;
								}
								this.api.gfx.spriteHandler.unmaskAllSprites();
								break;
						}
				}
		}
	}
	function over(var2)
	{
		loop0:
		switch(var2.target)
		{
			case this._btnTactic:
				this.gapi.showTooltip(this.api.lang.getText("TACTIC_MODE"),this._btnFlag,-30);
				break;
			case this._btnFlag:
				this.gapi.showTooltip(this.api.lang.getText("FLAG_INDICATOR_HELP"),this._btnFlag,-30);
				break;
			default:
				switch(null)
				{
					case this._btnBlockJoinerExceptParty:
						this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_BLOCKJOINEREXCEPTPARTY"),this._btnFlag,-30);
						break loop0;
					case this._btnBlockJoiner:
						this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_BLOCKJOINER"),this._btnFlag,-30);
						break loop0;
					case this._btnHelp:
						this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_HELP"),this._btnFlag,-30);
						break loop0;
					default:
						switch(null)
						{
							case this._btnBlockSpectators:
								this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_SPECTATOR"),this._btnFlag,-30);
								break;
							case this._btnToggleSprites:
								this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_SPRITES"),this._btnFlag,-30);
						}
				}
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function moveButtons(var2)
	{
		this._btnTactic._y = this._btnTactic._y + var2;
		this._btnFlag._y = this._btnFlag._y + var2;
		this._btnBlockJoinerExceptParty._y = this._btnBlockJoinerExceptParty._y + var2;
		this._btnBlockJoiner._y = this._btnBlockJoiner._y + var2;
		this._btnHelp._y = this._btnHelp._y + var2;
		this._btnBlockSpectators._y = this._btnBlockSpectators._y + var2;
		this._btnToggleSprites._y = this._btnToggleSprites._y + var2;
	}
}
