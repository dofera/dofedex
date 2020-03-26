class dofus.aks.DataProcessor extends dofus.aks.Handler
{
   function DataProcessor(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function process(sData)
   {
      var _loc3_ = sData.charAt(0);
      var _loc4_ = sData.charAt(1);
      var _loc5_ = sData.charAt(2) == "E";
      this.postProcess(_loc3_,_loc4_,_loc5_,sData);
   }
   function postProcess(sType, sAction, bError, sData)
   {
      switch(sType)
      {
         case "H":
            switch(sAction)
            {
               case "C":
                  this.aks.onHelloConnectionServer(sData.substr(2));
                  break;
               case "G":
                  this.aks.onHelloGameServer(sData.substr(2));
                  break;
               default:
                  this.aks.disconnect(false,true);
            }
            break;
         case "p":
            this.aks.onPong();
            break;
         case "q":
            this.aks.onQuickPong();
            break;
         case "r":
            this.aks.send("rpong" + sData.substr(5),false);
            break;
         case "M":
            this.aks.onServerMessage(sData.substr(1));
            break;
         case "k":
            this.aks.onServerWillDisconnect();
            break;
         case "B":
            switch(sAction)
            {
               case "N":
                  return undefined;
               case "A":
                  switch(sData.charAt(2))
                  {
                     case "T":
                        this.aks.Basics.onAuthorizedCommand(true,sData.substr(3));
                        break;
                     case "L":
                        this.aks.Basics.onAuthorizedLine(sData.substr(3));
                        break;
                     case "P":
                        this.aks.Basics.onAuthorizedCommandPrompt(sData.substr(3));
                        break;
                     case "C":
                        this.aks.Basics.onAuthorizedCommandClear();
                        break;
                     case "E":
                        this.aks.Basics.onAuthorizedCommand(false);
                        break;
                     case "I":
                        switch(sData.charAt(3))
                        {
                           case "O":
                              this.aks.Basics.onAuthorizedInterfaceOpen(sData.substr(4));
                              break;
                           case "C":
                              this.aks.Basics.onAuthorizedInterfaceClose(sData.substr(4));
                        }
                  }
               case "T":
                  this.aks.Basics.onReferenceTime(sData.substr(2));
               case "D":
                  this.aks.Basics.onDate(sData.substr(2));
               case "W":
                  this.aks.Basics.onWhoIs(!bError,sData.substr(3));
               case "P":
                  this.aks.Basics.onSubscriberRestriction(sData.substr(2));
               case "C":
                  this.aks.Basics.onFileCheck(sData.substr(2));
               case "p":
                  this.aks.Basics.onAveragePing(sData.substr(2));
            }
            break;
         case "A":
            switch(sAction)
            {
               case "c":
                  this.aks.Account.onCommunity(sData.substr(2));
                  break;
               case "d":
                  this.aks.Account.onDofusPseudo(sData.substr(2));
                  break;
               case "l":
                  this.aks.Account.onLogin(!bError,sData.substr(3));
                  break;
               case "L":
                  this.aks.Account.onCharactersList(!bError,sData.substr(3));
                  break;
               case "x":
                  this.aks.Account.onServersList(!bError,sData.substr(3));
                  break;
               case "A":
                  this.aks.Account.onCharacterAdd(!bError,sData.substr(3));
                  break;
               case "T":
                  this.aks.Account.onTicketResponse(!bError,sData.substr(3));
                  break;
               case "X":
                  this.aks.Account.onSelectServer(!bError,true,sData.substr(3));
                  break;
               case "Y":
                  this.aks.Account.onSelectServer(!bError,false,sData.substr(3));
                  break;
               case "S":
                  this.aks.Account.onCharacterSelected(!bError,sData.substr(4));
                  break;
               case "s":
                  this.aks.Account.onStats(sData.substr(2));
                  break;
               case "N":
                  this.aks.Account.onNewLevel(sData.substr(2));
                  break;
               case "R":
                  this.aks.Account.onRestrictions(sData.substr(2));
                  break;
               case "H":
                  this.aks.Account.onHosts(sData.substr(2));
                  break;
               case "r":
                  this.aks.Account.onRescue(!bError);
                  break;
               case "g":
                  this.aks.Account.onGiftsList(sData.substr(2));
                  break;
               case "G":
                  this.aks.Account.onGiftStored(!bError);
                  break;
               case "q":
                  this.aks.Account.onQueue(sData.substr(2));
                  break;
               case "f":
                  this.aks.Account.onNewQueue(sData.substr(2));
                  break;
               case "V":
                  this.aks.Account.onRegionalVersion(sData.substr(2));
                  break;
               case "P":
                  this.aks.Account.onCharacterNameGenerated(!bError,sData.substr(3));
                  break;
               case "K":
                  this.aks.Account.onKey(sData.substr(2));
                  break;
               case "Q":
                  this.aks.Account.onSecretQuestion(sData.substr(2));
                  break;
               case "D":
                  this.aks.Account.onCharacterDelete(!bError,sData.substr(3));
                  break;
               case "M":
                  if((_loc0_ = sData.charAt(2)) !== "?")
                  {
                     this.aks.Account.onCharactersList(!bError,sData.substr(3),true);
                  }
                  else
                  {
                     this.aks.Account.onCharactersMigrationAskConfirm(sData.substr(3));
                  }
                  break;
               case "F":
                  this.aks.Account.onFriendServerList(sData.substr(2));
                  break;
               case "m":
                  if(!_global.CONFIG.isStreaming)
                  {
                     this.aks.Account.onMiniClipInfo();
                  }
                  else
                  {
                     var _loc6_ = _global.parseInt(sData.charAt(2),10);
                     if(_global.isNaN(_loc6_))
                     {
                        _loc6_ = 3;
                     }
                     getURL("FSCommand:" add "GoToCongratulation",_loc6_);
                  }
            }
            break;
         case "G":
            switch(sAction)
            {
               case "C":
                  this.aks.Game.onCreate(!bError,sData.substr(4));
                  break;
               case "J":
                  this.aks.Game.onJoin(sData.substr(3));
                  break;
               case "P":
                  this.aks.Game.onPositionStart(sData.substr(2));
                  break;
               case "R":
                  this.aks.Game.onReady(sData.substr(2));
                  break;
               case "S":
                  this.aks.Game.onStartToPlay();
                  break;
               case "E":
                  this.aks.Game.onEnd(sData.substr(2));
                  break;
               case "M":
                  this.aks.Game.onMovement(sData.substr(3));
                  break;
               case "c":
                  this.aks.Game.onChallenge(sData.substr(2));
                  break;
               case "t":
                  this.aks.Game.onTeam(sData.substr(2));
                  break;
               case "V":
                  this.aks.Game.onLeave(true,sData.substr(2));
                  break;
               case "f":
                  this.aks.Game.onFlag(sData.substr(2));
                  break;
               case "I":
                  switch(sData.charAt(2))
                  {
                     case "C":
                        this.aks.Game.onPlayersCoordinates(sData.substr(4));
                        break;
                     case "E":
                        this.aks.Game.onEffect(sData.substr(3));
                        break;
                     case "e":
                        this.aks.Game.onClearAllEffect(sData.substr(3));
                        break;
                     case "P":
                        this.aks.Game.onPVP(sData.substr(3),false);
                  }
                  break;
               case "D":
                  switch(sData.charAt(2))
                  {
                     case "M":
                        this.aks.Game.onMapData(sData.substr(4));
                        break;
                     case "K":
                        this.aks.Game.onMapLoaded();
                        break;
                     case "C":
                        this.aks.Game.onCellData(sData.substr(3));
                        break;
                     case "Z":
                        this.aks.Game.onZoneData(sData.substring(3));
                        break;
                     case "O":
                        this.aks.Game.onCellObject(sData.substring(3));
                        break;
                     case "F":
                        this.aks.Game.onFrameObject2(sData.substring(4));
                        break;
                     case "E":
                        this.aks.Game.onFrameObjectExternal(sData.substring(4));
                  }
                  break;
               case "d":
                  switch(sData.charAt(3))
                  {
                     case "K":
                        this.aks.Game.onFightChallengeUpdate(sData.substr(4),true);
                        break;
                     case "O":
                        this.aks.Game.onFightChallengeUpdate(sData.substr(4),false);
                        break;
                     default:
                        this.aks.Game.onFightChallenge(sData.substr(2));
                  }
                  break;
               case "A":
                  switch(sData.charAt(2))
                  {
                     case "S":
                        this.aks.GameActions.onActionsStart(sData.substr(3));
                        break;
                     case "F":
                        this.aks.GameActions.onActionsFinish(sData.substr(3));
                        break;
                     default:
                        this.aks.GameActions.onActions(sData.substr(2));
                  }
                  break;
               case "T":
                  switch(sData.charAt(2))
                  {
                     case "S":
                        this.aks.Game.onTurnStart(sData.substr(3));
                        break;
                     case "F":
                        this.aks.Game.onTurnFinish(sData.substr(3));
                        break;
                     case "L":
                        this.aks.Game.onTurnlist(sData.substr(4));
                        break;
                     case "M":
                        this.aks.Game.onTurnMiddle(sData.substr(4));
                        break;
                     case "R":
                        this.aks.Game.onTurnReady(sData.substr(3));
                  }
                  break;
               case "X":
                  this.aks.Game.onExtraClip(sData.substr(2));
                  break;
               case "o":
                  this.aks.Game.onFightOption(sData.substr(2));
                  break;
               case "O":
                  this.aks.Game.onGameOver();
            }
            break;
         case "c":
            switch(sAction)
            {
               case "M":
                  this.aks.Chat.onMessage(!bError,sData.substr(3));
                  break;
               case "s":
                  this.aks.Chat.onServerMessage(sData.substr(2));
                  break;
               case "S":
                  this.aks.Chat.onSmiley(sData.substr(2));
                  break;
               case "C":
                  this.aks.Chat.onSubscribeChannel(sData.substr(2));
            }
            break;
         case "D":
            switch(sAction)
            {
               case "A":
                  this.aks.Dialog.onCustomAction(sData.substr(2));
                  break;
               case "C":
                  this.aks.Dialog.onCreate(!bError,sData.substr(3));
                  break;
               case "Q":
                  this.aks.Dialog.onQuestion(sData.substr(2));
                  break;
               case "V":
                  this.aks.Dialog.onLeave();
                  break;
               case "P":
                  this.aks.Dialog.onPause();
            }
            break;
         case "I":
            switch(sAction)
            {
               case "M":
                  this.aks.Infos.onInfoMaps(sData.substr(2));
                  break;
               case "C":
                  this.aks.Infos.onInfoCompass(sData.substr(2));
                  break;
               case "H":
                  this.aks.Infos.onInfoCoordinatespHighlight(sData.substr(2));
                  break;
               case "m":
                  this.aks.Infos.onMessage(sData.substr(2));
                  break;
               case "Q":
                  this.aks.Infos.onQuantity(sData.substr(2));
                  break;
               case "O":
                  this.aks.Infos.onObject(sData.substr(2));
                  break;
               case "L":
                  switch(sData.charAt(2))
                  {
                     case "S":
                        this.aks.Infos.onLifeRestoreTimerStart(sData.substr(3));
                        break;
                     case "F":
                        this.aks.Infos.onLifeRestoreTimerFinish(sData.substr(3));
                  }
            }
            break;
         case "S":
            switch(sAction)
            {
               case "L":
                  if((_loc0_ = sData.charAt(2)) !== "o")
                  {
                     this.aks.Spells.onList(sData.substr(2));
                  }
                  else
                  {
                     this.aks.Spells.onChangeOption(sData.substr(3));
                  }
                  break;
               case "U":
                  this.aks.Spells.onUpgradeSpell(!bError,sData.substr(3));
                  break;
               case "B":
                  this.aks.Spells.onSpellBoost(sData.substr(2));
                  break;
               case "F":
                  this.aks.Spells.onSpellForget(sData.substr(2));
            }
            break;
         case "O":
            switch(sAction)
            {
               case "a":
                  this.aks.Items.onAccessories(sData.substr(2));
                  break;
               case "D":
                  this.aks.Items.onDrop(!bError,sData.substr(3));
                  break;
               case "A":
                  this.aks.Items.onAdd(!bError,sData.substr(3));
                  break;
               case "C":
                  this.aks.Items.onChange(sData.substr(3));
                  break;
               case "R":
                  this.aks.Items.onRemove(sData.substr(2));
                  break;
               case "Q":
                  this.aks.Items.onQuantity(sData.substr(2));
                  break;
               case "M":
                  this.aks.Items.onMovement(sData.substr(2));
                  break;
               case "T":
                  this.aks.Items.onTool(sData.substr(2));
                  break;
               case "w":
                  this.aks.Items.onWeight(sData.substr(2));
                  break;
               case "S":
                  this.aks.Items.onItemSet(sData.substr(2));
                  break;
               case "K":
                  this.aks.Items.onItemUseCondition(sData.substr(2));
                  break;
               case "F":
                  this.aks.Items.onItemFound(sData.substr(2));
            }
            break;
         case "F":
            switch(sAction)
            {
               case "A":
                  this.aks.Friends.onAddFriend(!bError,sData.substr(3));
                  break;
               case "D":
                  this.aks.Friends.onRemoveFriend(!bError,sData.substr(3));
                  break;
               case "L":
                  this.aks.Friends.onFriendsList(sData.substr(3));
                  break;
               case "S":
                  this.aks.Friends.onSpouse(sData.substr(2));
                  break;
               case "O":
                  this.aks.Friends.onNotifyChange(sData.substr(2));
            }
            break;
         case "i":
            switch(sAction)
            {
               case "A":
                  this.aks.Enemies.onAddEnemy(!bError,sData.substr(3));
                  break;
               case "D":
                  this.aks.Enemies.onRemoveEnemy(!bError,sData.substr(3));
                  break;
               case "L":
                  this.aks.Enemies.onEnemiesList(sData.substr(3));
            }
            break;
         case "K":
            switch(sAction)
            {
               case "C":
                  this.aks.Key.onCreate(sData.substr(3));
                  break;
               case "K":
                  this.aks.Key.onKey(!bError);
                  break;
               case "V":
                  this.aks.Key.onLeave();
            }
            break;
         case "J":
            switch(sAction)
            {
               case "S":
                  this.aks.Job.onSkills(sData.substr(3));
                  break;
               case "X":
                  this.aks.Job.onXP(sData.substr(3));
                  break;
               case "N":
                  this.aks.Job.onLevel(sData.substr(2));
                  break;
               case "R":
                  this.aks.Job.onRemove(sData.substr(2));
                  break;
               case "O":
                  this.aks.Job.onOptions(sData.substr(2));
            }
            break;
         case "E":
            switch(sAction)
            {
               case "R":
                  this.aks.Exchange.onRequest(!bError,sData.substr(3));
                  break;
               case "K":
                  this.aks.Exchange.onReady(sData.substr(2));
                  break;
               case "V":
                  this.aks.Exchange.onLeave(!bError,sData.substr(2));
                  break;
               case "C":
                  this.aks.Exchange.onCreate(!bError,sData.substr(3));
                  break;
               case "c":
                  this.aks.Exchange.onCraft(!bError,sData.substr(3));
                  break;
               case "M":
                  this.aks.Exchange.onLocalMovement(!bError,sData.substr(3));
                  break;
               case "m":
                  this.aks.Exchange.onDistantMovement(!bError,sData.substr(3));
                  break;
               case "r":
                  this.aks.Exchange.onCoopMovement(!bError,sData.substr(3));
                  break;
               case "p":
                  this.aks.Exchange.onPayMovement(!bError,sData.substr(2));
                  break;
               case "s":
                  this.aks.Exchange.onStorageMovement(!bError,sData.substr(3));
                  break;
               case "i":
                  this.aks.Exchange.onPlayerShopMovement(!bError,sData.substr(3));
                  break;
               case "W":
                  this.aks.Exchange.onCraftPublicMode(sData.substr(2));
                  break;
               case "e":
                  this.aks.Exchange.onMountStorage(sData.substr(2));
                  break;
               case "f":
                  this.aks.Exchange.onMountPark(sData.substr(2));
                  break;
               case "w":
                  this.aks.Exchange.onMountPods(sData.substr(2));
                  break;
               case "L":
                  this.aks.Exchange.onList(sData.substr(2));
                  break;
               case "S":
                  this.aks.Exchange.onSell(!bError);
                  break;
               case "B":
                  this.aks.Exchange.onBuy(!bError);
                  break;
               case "q":
                  this.aks.Exchange.onAskOfflineExchange(sData.substr(2));
                  break;
               case "H":
                  switch(sData.charAt(2))
                  {
                     case "S":
                        this.aks.Exchange.onSearch(sData.substr(3));
                        break;
                     case "L":
                        this.aks.Exchange.onBigStoreTypeItemsList(sData.substr(3));
                        break;
                     case "M":
                        this.aks.Exchange.onBigStoreTypeItemsMovement(sData.substr(3));
                        break;
                     case "l":
                        this.aks.Exchange.onBigStoreItemsList(sData.substr(3));
                        break;
                     case "m":
                        this.aks.Exchange.onBigStoreItemsMovement(sData.substr(3));
                        break;
                     case "P":
                        this.aks.Exchange.onItemMiddlePriceInBigStore(sData.substr(3));
                  }
                  break;
               case "J":
                  this.aks.Exchange.onCrafterListChanged(sData.substr(2));
                  break;
               case "j":
                  this.aks.Exchange.onCrafterReference(sData.substr(2));
                  break;
               case "A":
                  this.aks.Exchange.onCraftLoop(sData.substr(2));
                  break;
               case "a":
                  this.aks.Exchange.onCraftLoopEnd(sData.substr(2));
            }
            break;
         case "h":
            switch(sAction)
            {
               case "L":
                  this.aks.Houses.onList(sData.substr(2));
                  break;
               case "P":
                  this.aks.Houses.onProperties(sData.substr(2));
                  break;
               case "X":
                  this.aks.Houses.onLockedProperty(sData.substr(2));
                  break;
               case "C":
                  this.aks.Houses.onCreate(sData.substr(3));
                  break;
               case "S":
                  this.aks.Houses.onSell(!bError,sData.substr(3));
                  break;
               case "B":
                  this.aks.Houses.onBuy(!bError,sData.substr(3));
                  break;
               case "V":
                  this.aks.Houses.onLeave();
                  break;
               case "G":
                  this.aks.Houses.onGuildInfos(sData.substr(2));
            }
            break;
         case "s":
            switch(sAction)
            {
               case "L":
                  this.aks.Storages.onList(sData.substr(2));
                  break;
               case "X":
                  this.aks.Storages.onLockedProperty(sData.substr(2));
            }
            break;
         case "e":
            switch(sAction)
            {
               case "U":
                  this.aks.Emotes.onUse(!bError,sData.substr(3));
                  break;
               case "L":
                  this.aks.Emotes.onList(sData.substr(2));
                  break;
               case "A":
                  this.aks.Emotes.onAdd(sData.substr(2));
                  break;
               case "R":
                  this.aks.Emotes.onRemove(sData.substr(2));
                  break;
               case "D":
                  this.aks.Emotes.onDirection(sData.substr(2));
            }
            break;
         case "d":
            switch(sAction)
            {
               case "C":
                  this.aks.Documents.onCreate(!bError,sData.substr(3));
                  break;
               case "V":
                  this.aks.Documents.onLeave();
            }
            break;
         case "g":
            switch(sAction)
            {
               case "n":
                  this.aks.Guild.onNew();
                  break;
               case "C":
                  this.aks.Guild.onCreate(!bError,sData.substr(3));
                  break;
               case "S":
                  this.aks.Guild.onStats(sData.substr(2));
                  break;
               case "I":
                  switch(sData.charAt(2))
                  {
                     case "G":
                        this.aks.Guild.onInfosGeneral(sData.substr(3));
                        break;
                     case "M":
                        this.aks.Guild.onInfosMembers(sData.substr(3));
                        break;
                     case "B":
                        this.aks.Guild.onInfosBoosts(sData.substr(3));
                        break;
                     case "F":
                        this.aks.Guild.onInfosMountPark(sData.substr(3));
                        break;
                     case "T":
                        switch(sData.charAt(3))
                        {
                           case "M":
                              this.aks.Guild.onInfosTaxCollectorsMovement(sData.substr(4));
                              break;
                           case "P":
                              this.aks.Guild.onInfosTaxCollectorsPlayers(sData.substr(4));
                              break;
                           case "p":
                              this.aks.Guild.onInfosTaxCollectorsAttackers(sData.substr(4));
                        }
                        break;
                     case "H":
                        this.aks.Guild.onInfosHouses(sData.substr(3));
                  }
                  break;
               case "J":
                  switch(sData.charAt(2))
                  {
                     case "E":
                        this.aks.Guild.onJoinError(sData.substr(3));
                        break;
                     case "R":
                        this.aks.Guild.onRequestLocal(sData.substr(3));
                        break;
                     case "r":
                        this.aks.Guild.onRequestDistant(sData.substr(3));
                        break;
                     case "K":
                        this.aks.Guild.onJoinOk(sData.substr(3));
                        break;
                     case "C":
                        this.aks.Guild.onJoinDistantOk();
                  }
                  break;
               case "V":
                  this.aks.Guild.onLeave();
                  break;
               case "K":
                  this.aks.Guild.onBann(!bError,sData.substr(3));
                  break;
               case "H":
                  this.aks.Guild.onHireTaxCollector(!bError,sData.substr(3));
                  break;
               case "A":
                  this.aks.Guild.onTaxCollectorAttacked(sData.substr(2));
                  break;
               case "T":
                  this.aks.Guild.onTaxCollectorInfo(sData.substr(2));
                  break;
               case "U":
                  this.aks.Guild.onUserInterfaceOpen(sData.substr(2));
            }
            break;
         case "W":
            switch(sAction)
            {
               case "C":
                  this.aks.Waypoints.onCreate(sData.substr(2));
                  break;
               case "V":
                  this.aks.Waypoints.onLeave();
                  break;
               case "U":
                  this.aks.Waypoints.onUseError();
                  break;
               case "c":
                  this.aks.Subway.onCreate(sData.substr(2));
                  break;
               case "v":
                  this.aks.Subway.onLeave();
                  break;
               case "u":
                  this.aks.Subway.onUseError();
                  break;
               case "p":
                  this.aks.Subway.onPrismCreate(sData.substr(2));
                  break;
               case "w":
                  this.aks.Subway.onPrismLeave();
            }
            break;
         case "a":
            switch(sAction)
            {
               case "l":
                  this.aks.Subareas.onList(sData.substr(3));
                  break;
               case "m":
                  this.aks.Subareas.onAlignmentModification(sData.substr(2));
                  break;
               case "M":
                  this.aks.Conquest.onAreaAlignmentChanged(sData.substr(2));
            }
            break;
         case "C":
            switch(sAction)
            {
               case "I":
                  switch(sData.charAt(2))
                  {
                     case "J":
                        this.aks.Conquest.onPrismInfosJoined(sData.substr(3));
                        break;
                     case "V":
                        this.aks.Conquest.onPrismInfosClosing(sData.substr(3));
                  }
                  break;
               case "B":
                  this.aks.Conquest.onConquestBonus(sData.substr(2));
                  break;
               case "A":
                  this.aks.Conquest.onPrismAttacked(sData.substr(2));
                  break;
               case "S":
                  this.aks.Conquest.onPrismSurvived(sData.substr(2));
                  break;
               case "D":
                  this.aks.Conquest.onPrismDead(sData.substr(2));
                  break;
               case "P":
                  this.aks.Conquest.onPrismFightAddPlayer(sData.substr(2));
                  break;
               case "p":
                  this.aks.Conquest.onPrismFightAddEnemy(sData.substr(2));
                  break;
               case "W":
                  this.aks.Conquest.onWorldData(sData.substr(2));
                  break;
               case "b":
                  this.aks.Conquest.onConquestBalance(sData.substr(2));
            }
            break;
         case "Z":
            switch(sAction)
            {
               case "S":
                  this.aks.Specialization.onSet(sData.substr(2));
                  break;
               case "C":
                  this.aks.Specialization.onChange(sData.substr(2));
            }
            break;
         case "f":
            switch(sAction)
            {
               case "C":
                  this.aks.Fights.onCount(sData.substr(2));
                  break;
               case "L":
                  this.aks.Fights.onList(sData.substr(2));
                  break;
               case "D":
                  this.aks.Fights.onDetails(sData.substr(2));
            }
            break;
         case "T":
            switch(sAction)
            {
               case "C":
                  this.aks.Tutorial.onCreate(sData.substr(2));
                  break;
               case "T":
                  this.aks.Tutorial.onShowTip(sData.substr(2));
                  break;
               case "B":
                  this.aks.Tutorial.onGameBegin();
            }
            break;
         case "Q":
            switch(sAction)
            {
               case "L":
                  this.aks.Quests.onList(sData.substr(3));
                  break;
               case "S":
                  this.aks.Quests.onStep(sData.substr(2));
            }
            break;
         case "P":
            switch(sAction)
            {
               case "I":
                  this.aks.Party.onInvite(!bError,sData.substr(3));
                  break;
               case "L":
                  this.aks.Party.onLeader(sData.substr(2));
                  break;
               case "R":
                  this.aks.Party.onRefuse(sData.substr(2));
                  break;
               case "A":
                  this.aks.Party.onAccept(sData.substr(2));
                  break;
               case "C":
                  this.aks.Party.onCreate(!bError,sData.substr(3));
                  break;
               case "V":
                  this.aks.Party.onLeave(sData.substr(2));
                  break;
               case "F":
                  this.aks.Party.onFollow(!bError,sData.substr(3));
                  break;
               case "M":
                  this.aks.Party.onMovement(sData.substr(2));
            }
            break;
         case "R":
            switch(sAction)
            {
               case "e":
                  this.aks.Mount.onEquip(sData.substr(2));
                  break;
               case "x":
                  this.aks.Mount.onXP(sData.substr(2));
                  break;
               case "n":
                  this.aks.Mount.onName(sData.substr(2));
                  break;
               case "d":
                  this.aks.Mount.onData(sData.substr(2));
                  break;
               case "p":
                  this.aks.Mount.onMountPark(sData.substr(2));
                  break;
               case "D":
                  this.aks.Mount.onMountParkBuy(sData.substr(2));
                  break;
               case "v":
                  this.aks.Mount.onLeave(sData.substr(2));
                  break;
               case "r":
                  this.aks.Mount.onRidingState(sData.substr(2));
            }
      }
   }
}
