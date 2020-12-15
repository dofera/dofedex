class dofus.DofusLoader extends ank.utils.QueueEmbedMovieClip
{
	var TABULATION = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	var _sLogs = "";
	var _sLang = "fr";
	var _bLocalFileListLoaded = false;
	var _bSkipDistantLoad = false;
	var _oXtraCurrentVersion = new Object();
	var _nTotalFile = 0;
	var _aLoadingBannersFiles = new Array();
	var _bLoadingBannersFilesLoaded = false;
	var _nProgressIndex = 0;
	var _nTimerJs = 0;
	var _bJsTimer = true;
	function DofusLoader()
	{
		super();
		ank.utils.Extensions.addExtensions();
		this.initLoader(_root);
	}
	static function main(var2)
	{
		if(_root.dofusPreLoaderMc == undefined)
		{
			return undefined;
		}
		System.security.allowDomain("*");
		getURL("FSCommand:" add "trapallkeys","true");
		getURL("FSCommand:" add "CustomerStart","");
		_root = var2;
		dofus.DofusLoader.registerAllClasses();
		_root._quality = "HIGH";
		if(dofus.Constants.DOUBLEFRAMERATE)
		{
			_root.attachMovie("DofusLoader_DoubleFramerate","_loader",_root.getNextHighestDepth());
		}
		else
		{
			_root.attachMovie("DofusLoader","_loader",_root.getNextHighestDepth());
		}
		_root.attachMovie("LoaderBorder","_loaderBorder",_root.getNextHighestDepth(),{_x:-2,_y:-2});
		_root.createEmptyMovieClip("_misc",_root.getNextHighestDepth());
		com.ankamagames.tools.Logger.initialize();
	}
	function addLoadingBannersFiles(var2)
	{
		var xDoc = new XML();
		xDoc.onLoad = function(var2)
		{
			if(var2)
			{
				var var3 = this.firstChild.firstChild;
				if(var3 != null && this.childNodes.length > 0)
				{
					while(var3 != null)
					{
						if(var3.nodeName == "loadingbanner")
						{
							var var4 = var3.attributes.file;
							xDoc.parent._aLoadingBannersFiles.push(var4);
						}
						var3 = var3.nextSibling;
					}
				}
			}
			xDoc.parent._bLoadingBannersFilesLoaded = true;
			xDoc.parent.showBanner(xDoc.bShow);
		};
		xDoc.ignoreWhite = true;
		xDoc.bShow = var2;
		xDoc.parent = this;
		xDoc.load(dofus.Constants.XML_LOADING_BANNERS_PATH);
	}
	function initLoader(var2)
	{
		this._sPrefixURL = this._url.substr(0,this._url.lastIndexOf("/") + 1);
		_global.CONFIG = new dofus.utils.();
		this.clearlogs();
		this.showMainLogger(false);
		this.showShowLogsButton(false);
		this.showConfigurationChoice(false);
		this.showNextButton(false);
		this.showContinueButton(false);
		this.showClearCacheButton(false);
		this.showCopyLogsButton(false);
		this.showProgressBar(false);
		this._mcContainer = this.createEmptyMovieClip("__ANKDATA__",this.getNextHighestDepth());
		this._mcLocalFileList = this.createEmptyMovieClip("__ANKFILEDATA__",this.getNextHighestDepth());
		_global.CONFIG.isNewAccount = _root.htmlLogin != undefined && (_root.htmlPassword != undefined && (_root.htmlLogin != null && (_root.htmlPassword != null && (_root.htmlLogin != "null" && (_root.htmlPassword != "null" && (_root.htmlLogin != "" && _root.htmlPassword != ""))))));
		this._bNonCriticalError = false;
		this._bUpdate = false;
		this._sStep = null;
		ank.gapi.styles.StylesManager.loadStylePackage(ank.gapi.styles.DefaultStylePackage);
		ank.gapi.styles.StylesManager.loadStylePackage(dofus.graphics.gapi.styles.DofusStylePackage);
		ank.utils.Extensions.addExtensions();
		if(System.capabilities.playerType == "StandAlone")
		{
			Key.addListener(this);
		}
		this._mcModules = var2.createEmptyMovieClip("mcModules",var2.getNextHighestDepth());
		this._mclLoader = new MovieClipLoader();
		this._mclLoader.addListener(this);
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initComponents});
		this.addToQueue({object:this,method:this.showBasicInformations,params:[true]});
	}
	function initComponents()
	{
		this["\x1e\b\x17"].text = this.getText("SERVER");
		this["\x1e\b\x18"].text = this.getText("CONFIGURATION");
		this["\x1e\b\x11"]["\x1e\n\x11"].text = "Loading";
		this["\x1e\t\x01"].label = this.getText("VALID");
		this["\x1e\t\x01"].addEventListener("click",this);
		this._btnContinue.label = this.getText("CONTINUE");
		this._btnContinue.addEventListener("click",this);
		this._btnClearCache.label = this.getText("CLEAR_CACHE");
		this._btnClearCache.addEventListener("click",this);
		this._btnNext.label = this.getText("NEXT");
		this._btnNext.addEventListener("click",this);
		this["\x1e\b\x1c"].label = this.getText("SHOW_LOGS");
		this["\x1e\b\x1c"].addEventListener("click",this);
		this["\x1e\b\x1d"].label = this.getText("COPY_LOGS");
		this["\x1e\b\x1d"].addEventListener("click",this);
		this["\x1e\b\x16"].addEventListener("itemSelected",this);
		this["\x1e\b\x15"].addEventListener("itemSelected",this);
		this.launchBannerAnim(true);
	}
	function initTexts()
	{
		this.LANG_TEXT = new Object();
		this.LANG_TEXT.STARTING = {fr:"Initialisation de DOFUS...",en:"Initializing DOFUS...",es:"Inicializando DOFUS...",de:"Initialisierung von DOFUS im Gange...",pt:"Inicializando DOFUS...",nl:"DOFUS initialiseren...",it:"Inizializzazione DOFUS..."};
		this.LANG_TEXT.SERVER = {fr:"Serveur",en:Server,es:"Servidor",de:Server,pt:"Servidor",nl:Server,it:Server};
		this.LANG_TEXT.CONFIGURATION = {fr:"Configuration",en:"Configuration",es:"Configuración",de:"Konfiguration",pt:"Configuração",nl:"Configuratie",it:"Configurazione"};
		this.LANG_TEXT.NEXT = {fr:"Continuer",en:"Next",es:"Siguiente",de:"Weiter",pt:"Próximo",nl:"Volgende",it:"Continuare"};
		this.LANG_TEXT.INIT_END = {fr:"Initialisation terminée",en:"Initialization completed",es:"Inicialización terminada",de:"Initialisierung beendet",pt:"Inicialização completada",nl:"Initialiseren voltooid",it:"Inizializzazzione terminata"};
		this.LANG_TEXT.VALID = {fr:"OK",en:"OK",es:"OK",de:"OK",pt:"OK",nl:"OK",it:"OK"};
		this.LANG_TEXT.CLEAR_CACHE = {fr:"Vider le cache",en:"Empty cache memory",es:"Vacía el caché",de:"Den Cache leeren",pt:"Esvaziar memória cache",nl:"Cache geheugen legen",it:"Svuotare la cache"};
		this.LANG_TEXT.COPY_LOGS = {fr:"Copier les logs",en:"Copy logs",es:"Copiar logs",de:"Logs kopieren",pt:"Copiar logs",nl:"Logs kopiëren",it:"Copiare i log"};
		this.LANG_TEXT.SHOW_LOGS = {fr:"Afficher les logs",en:"Display logs",es:"Mostrar logs",de:"Logs anzeigen",pt:"Exibir logs",nl:"Laat de logs zien",it:"Visualizzare i log"};
		this.LANG_TEXT.CONTINUE = {fr:"Continuer",en:"Continue",es:"Continuar",de:"Fortfahren",pt:"Continuar",nl:"Volgende",it:"Continuare"};
		this.LANG_TEXT.ERROR = {fr:"Erreur",en:"Error",es:"Error",de:"Fehler",pt:"Erro",nl:"Fout",it:"Errore"};
		this.LANG_TEXT.WARNING = {fr:"Attention",en:"Warning",es:"Atención",de:"Warnung",pt:"Aviso",nl:"Waarschuwing",it:"Attenzione"};
		this.LANG_TEXT.DEBUG_MODE = {fr:"Mode debug activé",en:"Debug mode activated",es:"Modo debug activado",de:"Debug Modus aktiviert",pt:"Modo de depuração ativado",nl:"Debug modus geactiveerd",it:"Modalità debug attiva"};
		this.LANG_TEXT.UNKNOWN_TYPE_NODE = {fr:"Paramètre inconnu",en:"Unknown parameter",es:"Parámetro desconocido",de:"Unbekannte Parameter",pt:"Parâmetro desconhecido",nl:"Onbekende parameter",it:"Parametro sconosciuto"};
		this.LANG_TEXT.LINK_HELP = {fr:"Cliquez ici pour voir les solutions",en:"Click here to see the solutions",es:"Pincha aquí para ver las soluciones",de:"Hier klicken für Lösungsvorschläge",pt:"Clique aqui para ver as soluções",nl:"Klik hier voor de oplossingen",it:"Clicca qui per vedere le soluzioni"};
		this.LANG_TEXT.LOADING_CONFIG_FILE = {fr:"Chargement du fichier de configuration...",en:"Configuration file downloading...",es:"Descargando el archivo de configuración",de:"Download der Konfigurationsdatei...",pt:"Baixando arquivo de configuração...",nl:"Configuratie bestand aan het downloaden...",it:"Caricamento del file di configurazione..."};
		this.LANG_TEXT.CONFIG_FILE_LOADED = {fr:"Fichier de configuration chargé",en:"Configuration file downloaded",es:"Archivo de configuración descargado",de:"Download der Konfigurationsdatei beendet",pt:"Arquivo de configuração baixado",nl:"Configuratie bestand gedownload",it:"File di configurazione caricato"};
		this.LANG_TEXT.CHOOSE_CONFIGURATION = {fr:"Choix de la configuration...",en:"Configuration choice...",es:"Elección de la configuración...",de:"Auswahl der Konfiguration...",pt:"Escolha de configuração...",nl:"Configuratie keuze...",it:"Scelta della configurazione..."};
		this.LANG_TEXT.LOAD_MODULES = {fr:"Chargement des modules de jeu...",en:"Game modules loading...",es:"Descargando módulos del juego...",de:"Spielmodule werden geladen...",pt:"Carregando módulos de jogo...",nl:"Spel modules aan het laden...",it:"Caricamento dei moduli di gioco..."};
		this.LANG_TEXT.CURRENT_CONFIG = {fr:"Configuration choisie : <b>%1</b>",en:"Chosen Configuration : <b>%1</b>",es:"Configuración elegida: <b>%1</b>",de:"Ausgewählte Konfiguration: <b>%1</b>",pt:"Configuração escolhida : <b>%1</b>",nl:"Gekozen Configuratie : <b>%1</b>",it:"Configurazione scelta : <b>%1</b>"};
		this.LANG_TEXT.CURRENT_SERVER = {fr:"Server de connexion choisi : <b>%1</b>",en:"Chosen Connection Server : <b>%1</b>",es:"Servidor de conexión seleccionado: <b>%1</b>",de:"Ausgewählter Einwahlserver: <b>%1</b>",pt:"Conexão com o servidor escolhida : <b>%1</b>",nl:"Gekozen Verbindings Server : <b>%1</b>",it:"Server di connessione scelto : <b>%1</b>"};
		this.LANG_TEXT.LOAD_LANG_FILE = {fr:"Chargement du fichier de langue...",en:"Language file downloading...",es:"Descargando el archivo de idioma...",de:"Laden der Sprachdateien im Gange...",pt:"Baixando arquivo de idioma...",nl:"Taalbestand aan het downloaden...",it:"Caricamento del file di lingua..."};
		this.LANG_TEXT.CURRENT_LANG_FILE_VERSION = {fr:"Version du fichier de langue en local : <b>%1</b>",en:"Local version of the language file : <b>%1</b>",es:"Versión local del archivo de idioma: <b>%1</b>",de:"Lokale Version der Sprachdatei: <b>%1</b>",pt:"Versão locais do arquivo de idioma : <b>%1</b>",nl:"Locale versie van het taalbestand : <b>%1</b>",it:"Versione del file di lingua in rete locale : <b>%1</b>"};
		this.LANG_TEXT.CHECK_LAST_VERSION = {fr:"Verification des mises à jour...",en:"Checking updates...",es:"Comprobando actualizaciones...",de:"Suchen nach Updates...",pt:"Verificando atualizações...",nl:"Zoeken naar updates...",it:"Verifica degli aggiornamenti..."};
		this.LANG_TEXT.NEW_LANG_FILE_AVAILABLE = {fr:"Mise à jour disponible, téléchargement en cours de la version <b>%1</b>",en:"Update available. Version <b>%1</b> downloading...",es:"Actualización disponible. Descargando versión <b>%1</b>...",de:"Update gefunden. Download von Version <b>%1</b> im Gange...",pt:"Atualização disponível. Baixando versão <b>%1</b>...",nl:"Update beschikbaar/ Versie <b>%1</b> aan het downloaden...",it:"Aggiornamenti disponibili, download della versione in corso <b>%1</b>..."};
		this.LANG_TEXT.NO_NEW_VERSION_AVAILABLE = {fr:"Aucune mise à jour disponible",en:"No update available",es:"Ninguna actualización disponible",de:"Kein Update verfügbar",pt:"Não há atualização disponível",nl:"Geen update beschikbaar",it:"Nessun aggiornamento disponibile"};
		this.LANG_TEXT.IMPOSSIBLE_TO_JOIN_SERVER = {fr:"Impossible de joindre le serveur <b>%1</b>",en:"Server <b>%1</b> can not be reached",es:"Imposible conectar con el servidor <b>%1</b>",de:"Server <b>%1</b> unerreichbar",pt:"Servidor <b>%1</b> não pôde ser alcançado",nl:"Server <b>%1</b> kon niet bereikt worden",it:"Non è possibile collegarsi al server <b>%1</b>"};
		this.LANG_TEXT.LOAD_XTRA_FILES = {fr:"Chargement des fichiers de langue supplémentaires...",en:"Additional language files downloading...",es:"Descargando archivos de idioma adicionales...",de:"Download zusätzlicher Sprachdateien im Gange...",pt:"Baixando arquivos adicionais de idioma...",nl:"Additioneel taalbestand aan het downloaden...",it:"Caricamento del file di lingua supplementari..."};
		this.LANG_TEXT.UPDATE_FILE = {fr:"Mise à jour du fichier <b>%1</b>...",en:"Updating file <b>%1</b>...",es:"Actualizando el archivo <b>%1</b>...",de:"Update der Datei <b>%1</b> im Gange...",pt:"Atualizando arquivo <b>%1</b>...",nl:"Bestand <b>%1</b> aan het updaten...",it:"Aggiornamento del file <b>%1</b>..."};
		this.LANG_TEXT.NO_FILE_IN_LOCAL = {fr:"Fichier <b>%1</b> non présent dans le dossier local <b>%2</b>",en:"File <b>%1</b> can not be found in local folder <b>%2</b>",es:"No se consiguió encontrar el archivo <b>%1</b> en la carpeta <b>%2</b>",de:"Datei <b>%1</b> gefindet sich nicht im lokalen Ordner <b>%2</b>",pt:"Arquivo <b>%1</b> não pôde ser encontrado na pasta local <b>%2</b>",nl:"Bestand <b>%1</b> kan niet in de lokale folder <b>%2</b> worden gevonden",it:"File <b>%1</b>  non presente nella cartella locale <b>%2</b>"};
		this.LANG_TEXT.IMPOSSIBLE_TO_DOWNLOAD_FILE = {fr:"Impossible de télécharger le fichier <b>%1</b> a partir du serveur <b>%2</b>",en:"File <b>%1</b> can not be downloaded from server <b>%2</b>",es:"Ha sido imposible descargar el archivo <b>%1</b> desde el servidor <b>%2</b>",de:"Download der Datei <b>%1</b> vom Server <b>%2</b> fehlgeschlagen",pt:"Arquivo <b>%1</b> não foi baixando do servidor <b>%2</b>",nl:"Bestand <b>%1</b> kan niet van server <b>%2</b> worden gedownload",it:"Non è possibile scaricare il file <b>%1</b> dal server <b>%2</b>"};
		this.LANG_TEXT.UPDATE_FINISH = {fr:"Mise à jour du fichier <b>%1</b> terminée à partir du serveur <b>%2</b>",en:"Update of file <b>%1</b> from server <b>%2</b> completed",es:"Actualización del archivo <b>%1</b> a partir del servidor <b>%2</b>terminada",de:"Update der Datei <b>%1</b> vom Server <b>%2</b> abgeschlossen",pt:"Atualização do arquivo <b>%1</b> do servidor <b>%2</b> completada",nl:"Update van het bestand <b>%1</b> van server <b>%2</b> is voltooid",it:"Aggiornamento del file <b>%1</b>dal server terminato <b>%2</b>"};
		this.LANG_TEXT.MODULE_LOADED = {fr:"Module <b>%1</b> chargé",en:"Module <b>%1</b> downloaded",es:"Módulo <b>%1</b> descargado",de:"Download von Modul <b>%1</b> abgeschlossen",pt:"Módulo <b>%1</b> baixado",nl:"Module <b>%1</b> gedownload",it:"Modulo <b>%1</b> caricato"};
		this.LANG_TEXT.FILE_LOADED = {fr:"Chargement du fichier <b>%1</b> terminé à partir du dossier local <b>%2</b>",en:"File <b>%1</b> from local folder <b>%2</b> downloaded",es:"Archivo <b>%1</b> de la carpeta <b>%2</b> descargado",de:"Download der Datei <b>%1</b> vom lokalen Ordner <b>%2</b> abgeschlossen",pt:"Arquivo <b>%1</b> da pasta local <b>%2</b> baixado",nl:"Bestand <b>%1</b> uit de lokale folder <b>%2</b> is gedownload",it:"Caricamento del file <b>%1</b> dalla cartella locale terminato <b>%2</b>"};
		this.LANG_TEXT.CORRUPT_FILE = {fr:"Fichier <b>%1</b> corrompu téléchargé à partir du serveur <b>%2</b> (Taille : %3)",en:"File <b>%1</b> corrupted. Downloaded from server <b>%2</b> (Size: %3)",es:"El archivo <b>%1</b> está corrupto. Descargado desde el servidor <b>%2</b> (Tamaño: %3)",de:"Datei <b>%1</b> ist korrupt. Heruntergeladen vom Server <b>%2</b> (Größe: %3)",pt:"Arquivo <b>%1</b> corrompido. Baixado do servidor <b>%2</b> (Tamanho: %3)",nl:"Bestand <b>%1</b> is beschadigd. Download van server <b>%2</b> (Grootte: %3)",it:"File <b>%1</b> corrotto scaricato dal server <b>%2</b> (Taglia: %3)"};
		this.ERRORS = new Object();
		var var2 = new Object();
		this.ERRORS.TOO_MANY_OCCURENCES = var2;
		var2.fr = "Vous ne pouvez pas lancer plus de clients DOFUS sur cet ordinateur.";
		var2.en = "You can\'t start anymore DOFUS client on this computer.";
		var2.es = "No puedes abrir más clientes DOFUS en este ordenador.";
		var2.de = "Es kann kein weiterer DOFUS-Client auf diesem Computer gestartet werden.";
		var2.pt = "Você não pode começar o cliente de DOFUS de novo neste computador.";
		var2.nl = "Je kan de DOFUS client niet meer op deze computer opstarten.";
		var2.it = "Non puoi lanciare più client su questo computer.";
		var2.linkfr = "http://www.dofus.com";
		var2.linken = "http://www.dofus.com";
		var2.linkes = "http://www.dofus.com";
		var2.linkde = "http://www.dofus.com";
		var2.linkpt = "http://www.dofus.com";
		var2 = new Object();
		this.ERRORS.BAD_FLASH_PLAYER = var2;
		var2.fr = "Vous devez posséder le lecteur Flash Player version 8 ou supérieure. (Version actuelle : " + System.capabilities.version + ")";
		var2.en = "You have to install the Flash Player version 8 or higher. (Actual version : " + System.capabilities.version + ")";
		var2.es = "Debes instalar el reproductor Flash Player versión 8 o superior. (Versión actual: " + System.capabilities.version + ")";
		var2.de = "Es wird die Version 8 oder höher des Flash Players benötigt. (Aktuelle Version: " + System.capabilities.version + ")";
		var2.pt = "Você precisa instalar a versão 8 ou superior do Flash Player. (Versão atual : " + System.capabilities.version + ")";
		var2.nl = "Je moet Flash Player versie 8 of hoger installeren. (Huidige versie : " + System.capabilities.version + ")";
		var2.it = "Devi avere il lettore Flash Player versione 8 o avanzata (Versione attuale:" + System.capabilities.version + ")";
		var2.linkfr = "http://store.adobe.com/go/getflashplayer";
		var2.linken = "http://store.adobe.com/go/getflashplayer";
		var2.linkes = "http://store.adobe.com/go/getflashplayer";
		var2.linkde = "http://store.adobe.com/go/getflashplayer";
		var2.linkpt = "http://store.adobe.com/go/getflashplayer";
		var2 = new Object();
		this.ERRORS.BAD_FLASH_SANDBOX = var2;
		var2.fr = "Les paramètres de sécurité actuels du lecteur Flash ne permettent pas à DOFUS de s\'executer.";
		var2.en = "You must configure DOFUS as a trusted application on the Flash Player security settings.";
		var2.es = "Los parámetros de seguridad actuales del reproductor Flash no permiten la ejecución de DOFUS.";
		var2.de = "DOFUS muss als vertrauenswürdige Anwendung in den Sicherheitseinstellungen des Flash Players konfiguriert werden.";
		var2.pt = "Você deve configurar DOFUS como uma aplicação confiável nas configurações de segurança do Flash Player.";
		var2.nl = "Je zult DOFUS als een veilige aplicatie moeten instellen bij de beveiligings instellingen van je Flash Player.";
		var2.it = "I parametri di sicurezza attuali del lettore Flash non permettono l\'esecuzione di DOFUS.";
		var2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=984&_gid=1&languageid=2&group=dofusfr";
		var2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=985&_gid=1&languageid=1&group=dofusen";
		var2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=985&_gid=1&languageid=1&group=dofusen";
		var2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=985&_gid=1&languageid=1&group=dofusen";
		var2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=985&_gid=1&languageid=1&group=dofusen";
		var2 = new Object();
		this.ERRORS.UPDATE_LANG_IMPOSSIBLE = var2;
		var2.fr = "Impossible de charger le fichier de langue";
		var2.en = "Impossible to download the language file";
		var2.es = "Descarga del archivo de idioma imposible";
		var2.de = "Download der Sprachdatei nicht möglich";
		var2.pt = "Impossível baixar o arquivo de idioma";
		var2.nl = "Onmogelijk om dit taalbestand te downloaden";
		var2.it = "Non è possibile caricare il file di lingua";
		var2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=961&_gid=1&languageid=2&group=dofusfr";
		var2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=971&_gid=1&languageid=1&group=dofusen";
		var2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=971&_gid=1&languageid=1&group=dofusen";
		var2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=971&_gid=1&languageid=1&group=dofusen";
		var2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=971&_gid=1&languageid=1&group=dofusen";
		var2 = new Object();
		this.ERRORS.NO_CONFIG_FILE = var2;
		var2.fr = "Impossible de charger le fichier de configuration";
		var2.en = "Impossible to load the configuration file";
		var2.es = "No se puede cargar el archivo de configuración";
		var2.de = "Laden der Konfigurationsdatei nicht möglich";
		var2.pt = "Impossível carregar o arquivo de configuração";
		var2.nl = "Onmogelijk om het configuratie bestand te laden";
		var2.it = "Non è possibile caricare il file di configurazione";
		var2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=957&_gid=1&languageid=2&group=dofusfr";
		var2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		var2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		var2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		var2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		var2 = new Object();
		this.ERRORS.CORRUPT_CONFIG_FILE = var2;
		var2.fr = "Impossible de lire le fichier de configuration";
		var2.en = "Impossible to read the configuration file";
		var2.es = "No es posible leer el archivo de configuración";
		var2.de = "Unmöglich die Konfigurationsdatei zu lesen";
		var2.pt = "Impossível ler o arquivo de configuração";
		var2.nl = "Onmogelijk om het configuratie bestand te lezen";
		var2.it = "Non è possibile leggere il file di configurazione";
		var2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=957&_gid=1&languageid=2&group=dofusfr";
		var2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		var2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		var2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		var2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		var2 = new Object();
		this.ERRORS.CHECK_LAST_VERSION_FAILED = var2;
		var2.fr = "Impossible de vérifier les mises à jour";
		var2.en = "Impossible to check updates";
		var2.es = "No es posible comprobar las actualizacones";
		var2.de = "Updateprüfung nicht möglich";
		var2.pt = "Impossível verificar atualizações";
		var2.nl = "Onmogelijk om op updates te controleren";
		var2.it = "Non è possibile verificare gli aggiornamenti";
		var2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=955&_gid=1&languageid=2&group=dofusfr";
		var2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		var2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		var2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		var2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		var2 = new Object();
		this.ERRORS.IMPOSSIBLE_TO_LOAD_MODULE = var2;
		var2.fr = "Impossible de charger le module <b>%1</b>";
		var2.en = "Impossible to download the module <b>%1</b>";
		var2.es = "No es posible descargar el módulo <b>%1</b>";
		var2.de = "Download des Moduls  <b>%1</b> nicht möglich";
		var2.pt = "Impossível baixar o módulo <b>%1</b>";
		var2.nl = "Onmogelijk om module <b>%1</b> te downloaden";
		var2.it = "Non è possibile caricare il modulo <b>%1</b>";
		var2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=963&_gid=1&languageid=2&group=dofusfr";
		var2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=976&_gid=1&languageid=1&group=dofusen";
		var2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=976&_gid=1&languageid=1&group=dofusen";
		var2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=976&_gid=1&languageid=1&group=dofusen";
		var2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=976&_gid=1&languageid=1&group=dofusen";
		var2 = new Object();
		this.ERRORS.WRITE_FAILED = var2;
		var2.fr = "Impossible de sauvegarder le fichier <b>%1</b> en local";
		var2.en = "Impossible to save file <b>%1</b> in local";
		var2.es = "No es posible guardar el archivo <b>%1</b> en local";
		var2.de = "Lokales Speichern der Datei <b>%1</b> nicht möglich";
		var2.pt = "Impossível salvar o arquivo <b>%1</b> localmente";
		var2.nl = "Onmogelijk het bestand <b>%1</b> lokaal te bewaren";
		var2.it = "Non è possibile registrare il file <b>%1</b> su rete locale";
		var2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=965&_gid=1&languageid=2&group=dofusfr";
		var2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=973&_gid=1&languageid=1&group=dofusen";
		var2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=973&_gid=1&languageid=1&group=dofusen";
		var2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=973&_gid=1&languageid=1&group=dofusen";
		var2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=973&_gid=1&languageid=1&group=dofusen";
		var2 = new Object();
		this.ERRORS.CANT_UPDATE_FILE = var2;
		var2.fr = "Impossible de mettre a jour le fichier <b>%1</b>";
		var2.en = "Impossible to update file <b>%1</b>";
		var2.es = "No es posible actualizar el archivo <b>%1</b>";
		var2.de = "Update der Datei <b>%1</b> nicht möglich";
		var2.pt = "Impossível atualizar o arquivo <b>%1</b>";
		var2.nl = "Onmogelijk om het bestand <b>%1</b> te updaten";
		var2.it = "Non è possibile aggiornare il file <b>%1</b>";
		var2.linkfr = "http://support.ankama-games.com/index.php?_gid=1&languageid=2&group=dofusfr";
		var2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		var2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		var2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		var2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
	}
	static function registerAllClasses()
	{
		Object.registerClass("ButtonNormalDown",ank.gapi.controls.button.ButtonBackground);
		Object.registerClass("ButtonNormalUp",ank.gapi.controls.button.ButtonBackground);
		Object.registerClass("ButtonToggleDown",ank.gapi.controls.button.ButtonBackground);
		Object.registerClass("ButtonToggleUp",ank.gapi.controls.button.ButtonBackground);
		Object.registerClass("ButtonSimpleRectangleUpDown",ank.gapi.controls.button.ButtonBackground);
		Object.registerClass("Label",ank.gapi.controls.Label);
		Object.registerClass("Button",ank.gapi.controls.Button);
		Object.registerClass("SelectableRow",ank.gapi.controls.list.SelectableRow);
		Object.registerClass("DefaultCellRenderer",ank.gapi.controls.list.DefaultCellRenderer);
		Object.registerClass("List",ank.gapi.controls.List);
		Object.registerClass("ConsoleLogger",ank.gapi.controls.ConsoleLogger);
		Object.registerClass("DofusLoader",dofus.DofusLoader);
		Object.registerClass("DofusLoader_DoubleFramerate",dofus.DofusLoader);
		Object.registerClass("Loader",ank.gapi.controls.Loader);
	}
	function log(var2, var3, var4)
	{
		if(var3 == undefined)
		{
			var3 = "#CCCCCC";
		}
		if(var4 == undefined)
		{
			var4 = "#666666";
		}
		this._currentLogger.log(var2,var3,var4);
		this.addToSaveLog(var2);
	}
	function addToSaveLog(var2)
	{
		this._sLogs = this._sLogs + (new ank.utils.(var2).replace("&nbsp;"," ") + "\r\n");
	}
	function logTitle(var2)
	{
		this.log("");
		this.log(var2,"#CCCCCC","#CCCCCC");
	}
	function logRed(var2)
	{
		this.log(var2,"#FF0000","#DD0000");
	}
	function logGreen(var2)
	{
		this.log(var2,"#00FF00","#00AA00");
	}
	function logOrange(var2)
	{
		this.log(var2,"#FF9900","#DD7700");
	}
	function logYellow(var2)
	{
		this.log(var2,"#FFFF00","#AAAA00");
	}
	function getText(var2, var3)
	{
		var var4 = this.LANG_TEXT[var2][_global.CONFIG.language];
		if(var4 == undefined || var4.length == 0)
		{
			var4 = _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data[var2];
		}
		if(var4 == undefined || var4.length == 0)
		{
			var4 = this.LANG_TEXT[var2].fr;
		}
		return this.replaceText(var4,var3);
	}
	function replaceText(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = new Array();
		}
		var var4 = new Array();
		var var5 = new Array();
		var var6 = 0;
		while(var6 < var3.length)
		{
			var4.push("%" + (var6 + 1));
			var5.push(var3[var6]);
			var6 = var6 + 1;
		}
		return new ank.utils.(var2).replace(var4,var5);
	}
	function clearlogs()
	{
		this["\x1e\b\x1b"].clear();
		this["\x1e\b\x19"].clear();
		this["\x1e\b\x1a"].clear();
	}
	function setProgressBarValue(var2, var3)
	{
		this.showProgressBar(true);
		if(var2 > var3)
		{
			var2 = var3;
		}
		this["\x1e\b\x12"]["\n\x12"]._width = var2 / var3 * 100;
		this["\x1e\b\x12"]["\x1e\n\x10"].text = Math.floor(Number(this["\x1e\b\x12"]["\n\x12"]._width)) + "%";
	}
	function showProgressBar(var2)
	{
		if(this["\x1e\b\x12"]._visible != var2)
		{
			this["\x1e\b\x12"]._visible = var2;
		}
	}
	function moveProgressBar(nX)
	{
	}
	function showWaitBar(var2)
	{
		if(var2)
		{
			this._mcWaitBar = this.attachMovie("GrayWaitBar","_mcWaitBar",1000,{_x:this["\x1e\b\x12"]._x + this["\x1e\b\x12"]["\n\x11"]._x,_y:this["\x1e\b\x12"]._y + this["\x1e\b\x12"]["\n\x11"]._y});
			this._mcWaitBar["\x1e\n\x11"].text = "Waiting";
		}
		else
		{
			this._mcWaitBar.removeMovieClip();
		}
		if(var2)
		{
			this.showProgressBar(false);
		}
	}
	function setTotalBarValue(var2, var3)
	{
		this.showTotalBar(true);
		if(var2 > var3)
		{
			var2 = var3;
		}
		this["\x1e\b\x11"]["\n\x12"]._width = var2 / var3 * 100;
		this["\x1e\b\x11"]["\x1e\n\x10"].text = Math.floor(Number(this["\x1e\b\x11"]["\n\x12"]._width)) + "%";
	}
	function showTotalBar(var2)
	{
		if(var2)
		{
			var var3 = 10079232;
			var var4 = (var3 & 16711680) >> 16;
			var var5 = (var3 & 65280) >> 8;
			var var6 = var3 & 255;
			var var7 = new Color(this["\x1e\b\x11"]["\n\x12"]);
			var var8 = new Object();
			var8 = {ra:"0",rb:var4,ga:"0",gb:var5,ba:"0",bb:var6,aa:"100",ab:"0"};
			var7.setTransform(var8);
			this["\x1e\b\x13"]._visible = true;
			this["\x1e\b\x11"]._visible = true;
		}
		else
		{
			this["\x1e\b\x11"]._visible = false;
			this["\x1e\b\x13"]._visible = false;
		}
	}
	function showConfigurationChoice(var2)
	{
		this["\x1e\b\x18"]._visible = var2;
		this["\x1e\b\x16"]._visible = var2;
		this["\x1e\b\x17"]._visible = var2;
		this["\x1e\b\x15"]._visible = var2;
		this["\x1e\t\x01"]._visible = var2;
	}
	function showNextButton(var2)
	{
		this._btnNext._visible = var2;
	}
	function showShowLogsButton(var2)
	{
		this["\x1e\b\x1c"]._visible = var2;
	}
	function showContinueButton(var2)
	{
		this._btnContinue._visible = var2;
	}
	function showClearCacheButton(var2)
	{
		this._btnClearCache._visible = var2;
	}
	function showCopyLogsButton(var2)
	{
		this["\x1e\b\x1d"]._visible = var2;
	}
	function showMainLogger(var2)
	{
		if(var2 == undefined)
		{
			var2 = !this["\x1e\b\x1b"]._visible;
		}
		this["\x1e\b\x1b"]._visible = var2;
	}
	function nonCriticalError(var2, var3)
	{
		this.logOrange(var3 + "<b>" + this.getText("WARNING") + "</b> : " + var2);
		this._bNonCriticalError = true;
	}
	function criticalError(var2, var3, var4, var5, var6)
	{
		var var7 = this.ERRORS[var2];
		this.ERRORS.current = var2;
		this.ERRORS.from = var6;
		var var8 = this.replaceText(var7[_global.CONFIG.language],var5);
		if(var8 == undefined || var8.length == 0)
		{
			var8 = this.replaceText(var7.fr,var5);
		}
		this["\x1e\b\x1a"].log("<b>" + this.getText("ERROR") + "</b> : " + var8,"#FF0000","#DD0000");
		var var9 = "<u><a href=\'" + var7["link" + _global.CONFIG.language] + "\' target=\'_blank\'>" + this.getText("LINK_HELP") + "</a></u>";
		this["\x1e\b\x1a"].log(var9,"#FF0000","#DD0000");
		this.addToSaveLog(var3 + "<b>" + this.getText("ERROR") + "</b> : " + var8);
		this.showCopyLogsButton(true);
		this.showShowLogsButton(true);
		this.showContinueButton(true);
		if(var4)
		{
			this.showClearCacheButton(true);
		}
	}
	function getLangSharedObject()
	{
		return ank.utils.SharedObjectFix.getLocal(dofus.Constants.LANG_SHAREDOBJECT_NAME);
	}
	function getXtraSharedObject()
	{
		return ank.utils.SharedObjectFix.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME);
	}
	function getOptionsSharedObject()
	{
		return ank.utils.SharedObjectFix.getLocal(dofus.Constants.GLOBAL_SO_OPTIONS_NAME);
	}
	function getShortcutsSharedObject()
	{
		return ank.utils.SharedObjectFix.getLocal(dofus.Constants.GLOBAL_SO_SHORTCUTS_NAME);
	}
	function getOccurencesSharedObject()
	{
		return ank.utils.SharedObjectFix.getLocal(dofus.Constants.GLOBAL_SO_OCCURENCES_NAME);
	}
	function getCacheDateSharedObject()
	{
		return ank.utils.SharedObjectFix.getLocal(dofus.Constants.GLOBAL_SO_CACHEDATE_NAME);
	}
	function launchBannerAnim(var2)
	{
		if(!this._bBannerDisplay)
		{
			this.showBanner(true);
		}
		if(var2)
		{
			this._mcBanner.playAll();
		}
		else
		{
			this._mcBanner.stopAll();
		}
	}
	function showBanner(var2)
	{
		if(!this._bLoadingBannersFilesLoaded)
		{
			this.addLoadingBannersFiles(var2);
		}
		else
		{
			var var3 = var2 != undefined?var2:!this._bBannerDisplay;
			if(var3)
			{
				if(this._bBannerDisplay)
				{
					return undefined;
				}
				var var4 = "";
				if(this._aLoadingBannersFiles.length > 0)
				{
					var var6 = Math.floor(Math.random() * (this._aLoadingBannersFiles.length + 1));
					if(var6 < this._aLoadingBannersFiles.length)
					{
						var var7 = this._aLoadingBannersFiles[var6];
						var var5 = this.createEmptyMovieClip("_mcBanner",this.getNextHighestDepth());
						eval(org).utils.Bitmap.loadBitmapSmoothed(dofus.Constants.LOADING_BANNERS_PATH + var7,var5);
					}
				}
				var var8 = "";
				if(!var5)
				{
					var5 = this.attachMovie("LoadingBanner_" + _global.CONFIG.language,"_mcBanner",this.getNextHighestDepth(),this["\x1e\b\x14"]);
				}
				if(!var5)
				{
					var5 = this.attachMovie("LoadingBanner_" + var8,"_mcBanner",this.getNextHighestDepth(),this["\x1e\b\x14"]);
				}
				if(!var5)
				{
					var5 = this.attachMovie("LoadingBanner","_mcBanner",this.getNextHighestDepth(),this["\x1e\b\x14"]);
				}
				var5.cacheAsBitmap = true;
				var5.swapDepths(this["\x1e\b\x14"]);
			}
			else
			{
				if(!this._bBannerDisplay)
				{
					return undefined;
				}
				this._mcBanner.swapDepths(this["\x1e\b\x14"]);
				this._mcBanner.removeMovieClip();
			}
			this._bBannerDisplay = var3;
		}
	}
	function copyAndOrganizeDataServerList()
	{
		var var2 = _global.CONFIG.dataServers.slice(0);
		var var3 = 0;
		while(var3 < var2.length)
		{
			var var4 = var2[var3];
			if(var4.nPriority == undefined || _global.isNaN(var4.nPriority))
			{
				var4.nPriority = 0;
			}
			var var5 = var4.priority;
			var4.rand = random(99999);
			var3 = var3 + 1;
		}
		var2.sortOn(["priority","rand"],Array.DESCENDING);
		var var6 = 0;
		while(var6 < var2.length)
		{
			var6 = var6 + 1;
		}
		return var2;
	}
	function checkOccurences()
	{
		var var2 = _global.API.lang.getConfigText("MAXIMUM_CLIENT_OCCURENCES");
		if(var2 == undefined || (_global.isNaN(var2) || var2 < 1))
		{
			return true;
		}
		var var3 = this.getOccurencesSharedObject().data.occ;
		var var4 = new Array();
		var var5 = 0;
		while(var5 < var3.length)
		{
			if(var3[var5].tick + dofus.Constants.MAX_OCCURENCE_DELAY > new Date().getTime())
			{
				var4.push(var3[var5]);
			}
			var5 = var5 + 1;
		}
		var var6 = var4.length;
		if(!_global.API.datacenter.Player.isAuthorized && var6 + 1 > var2)
		{
			this.criticalError("TOO_MANY_OCCURENCES",this.TABULATION,false);
			return false;
		}
		this._nOccurenceId = Math.round(Math.random() * 1000);
		var4.push({id:this._nOccurenceId,tick:new Date().getTime()});
		this.getOccurencesSharedObject().data.occ = var4;
		_global.setInterval(this,"refreshOccurenceTick",dofus.Constants.OCCURENCE_REFRESH);
		return true;
	}
	function refreshOccurenceTick()
	{
		var var2 = this.getOccurencesSharedObject().data.occ;
		var var3 = 0;
		while(var3 < var2.length)
		{
			if(var2[var3].id == this._nOccurenceId)
			{
				var2[var3].tick = new Date().getTime();
				break;
			}
			var3 = var3 + 1;
		}
		this.getOccurencesSharedObject().data.occ = var2;
	}
	function checkFlashPlayer()
	{
		var var2 = System.capabilities.version;
		var var3 = Number(var2.split(" ")[1].split(",")[0]);
		var var4 = System.capabilities.playerType.length != 0?" (" + System.capabilities.playerType + ")":" ";
		this.log(this.TABULATION + "Flash player" + var4 + " <b>" + var2 + "</b>");
		if(_root.electron != undefined)
		{
			var var5 = String(flash.external.ExternalInterface.call("getElectronVersion"));
			var var6 = String(flash.external.ExternalInterface.call("getNodejsVersion"));
			this.log(this.TABULATION + "Electron <b>" + var5 + "</b> (Node.js <b>" + var6 + "</b>)");
		}
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'checkFlashPlayer;" + var3 + "\')");
			this.getURL("JavaScript:WriteLog(\'versionDate;" + dofus.Constants.VERSIONDATE + "\')");
		}
		if(var3 >= 8)
		{
			var var7 = System.security.sandboxType;
			if(var7 != "localTrusted" && var7 != "remote")
			{
				this.criticalError("BAD_FLASH_SANDBOX",this.TABULATION,false);
				return false;
			}
			return true;
		}
		this.criticalError("BAD_FLASH_PLAYER",this.TABULATION,false);
		this.showBanner(false);
		return false;
	}
	function click(var2)
	{
		switch(var2.target)
		{
			case this["\x1e\t\x01"]:
				this.chooseConfiguration(this["\x1e\b\x16"].selectedItem.data,this["\x1e\b\x15"].selectedItem.data,true);
				break;
			case this._btnClearCache:
				this.clearCache();
				this.reboot();
				break;
			case this["\x1e\b\x1d"]:
				System.setClipboard(this._sLogs);
				break;
			default:
				switch(null)
				{
					case this["\x1e\b\x1c"]:
						this.showBanner(false);
						this.showMainLogger();
						break;
					case this._btnContinue:
						switch(this.ERRORS.current)
						{
							case "CHECK_LAST_VERSION_FAILED":
								var var3 = new LoadVars();
								var3.f = "";
								this.onCheckLanguage(true,var3,"","");
								break;
							case "CHECK_LAST_VERSION_FAILED":
								var var4 = new LoadVars();
								var4.f = "";
								this.onCheckLanguage(true,var4,"","");
						}
						break;
					case this._btnNext:
						this.showNextButton(false);
						switch(this._sStep)
						{
							case "MODULE":
								this.initCore(_global.MODULE_CORE);
								break;
							case "XTRA":
								this.initAndLoginFinished();
						}
				}
		}
	}
	function itemSelected(var2)
	{
		switch(var2.target)
		{
			case this["\x1e\b\x16"]:
				this.selectConfiguration();
				break;
			case this["\x1e\b\x15"]:
				this.selectConnexionServer();
		}
	}
	function onKeyUp()
	{
		if(Key.getCode() == Key.ESCAPE)
		{
			getURL("FSCommand:" add "quit","");
		}
	}
	function setDisplayStyle(var2)
	{
		if(System.capabilities.playerType == "PlugIn" && (!_global.CONFIG.isStreaming && _root.electron == undefined))
		{
			this.getURL("javascript:setFlashStyle(\'flashid\', \'" + var2 + "\');");
		}
	}
	function closeBrowserWindow()
	{
		if(System.capabilities.playerType == "PlugIn")
		{
			this.getURL("javascript:closeBrowserWindow();");
		}
	}
	function reboot()
	{
		var var2 = 0;
		while(var2 < dofus.Constants.MODULES_LIST.length)
		{
			this._mclLoader.unloadClip(_global["MODULE_" + dofus.Constants.MODULES_LIST[var2][4]]);
			var2 = var2 + 1;
		}
		this.initLoader(_root);
	}
	function clearCache()
	{
		ank.utils.SharedObjectFix.getLocal(dofus.Constants.LANG_SHAREDOBJECT_NAME).clear();
		ank.utils.SharedObjectFix.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME).clear();
	}
	function showLoader(var2, var3)
	{
		this._visible = var2;
	}
	function showBasicInformations(var2)
	{
		this._currentLogger = this["\x1e\b\x19"];
		this.logTitle(this.getText("STARTING"));
		this.log(this.TABULATION + "Dofus Retro <b>v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + "</b> " + (dofus.Constants.BETAVERSION <= 0?"":"(<font color=\"#FF0000\"><i><b>BETA " + dofus.Constants.BETAVERSION + "</b></i></font>) ") + "(<b>" + dofus.Constants.VERSIONDATE + "</b>" + (!dofus.Constants.ALPHA?"":" <font color=\"#00FF00\"><i><b>ALPHA BUILD</b></i></font>") + ")");
		if(!this.checkFlashPlayer())
		{
			this.showShowLogsButton(false);
			this.showCopyLogsButton(false);
			return undefined;
		}
		this.checkCacheVersion();
		this._currentLogger = this["\x1e\b\x1b"];
		if(var2)
		{
			this.addToQueue({object:this,method:this.loadConfig});
		}
	}
	function loadConfig()
	{
		this.showLoader(true);
		this.moveProgressBar(0);
		this.logTitle(this.getText("LOADING_CONFIG_FILE"));
		var var2 = new XML();
		var loader = this;
		var2.ignoreWhite = true;
		var2.onLoad = function(var2)
		{
			loader.onConfigLoaded(var2,this);
		};
		this.showWaitBar(true);
		var2.load(dofus.Constants.CONFIG_XML_FILE);
	}
	function onConfigLoaded(§\x14\x16§, xDoc)
	{
		this.showWaitBar(false);
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'onConfigLoaded;" + var2 + "\')");
		}
		if(var2)
		{
			this.setTotalBarValue(50,100);
			var var4 = xDoc.firstChild.firstChild;
			if(xDoc.childNodes.length == 0 || var4 == null)
			{
				this.criticalError("CORRUPT_CONFIG_FILE",this.TABULATION,false);
				return undefined;
			}
			_global.CONFIG.cacheAsBitmap = new Array();
			var var5 = new ank.utils.();
			var var6 = false;
			while(var4 != null)
			{
				loop4:
				switch(var4.nodeName)
				{
					case "delay":
						_global.CONFIG.delay = var4.attributes.value;
						break;
					case "rdelay":
						_global.CONFIG.rdelay = var4.attributes.value;
						break;
					default:
						switch(null)
						{
							case "rcount":
								_global.CONFIG.rcount = var4.attributes.value;
								break loop4;
							case "hardcore":
								_global.CONFIG.onlyHardcore = true;
								break loop4;
							case "streaming":
								_global.CONFIG.isStreaming = true;
								if(var4.attributes.method)
								{
									_global.CONFIG.streamingMethod = var4.attributes.method;
								}
								else
								{
									_global.CONFIG.streamingMethod = "compact";
								}
								_root._misc.attachMovie("UI_Misc","miniClip",_root._misc.getNextHighestDepth());
								break loop4;
							case "expo":
								_global.CONFIG.isExpo = true;
								break loop4;
							case "conf":
								var var7 = var4.attributes.name;
								var var8 = var4.attributes.type;
								if(var7 != undefined && (dofus.Constants.TEST != true && var8 != "test" || dofus.Constants.TEST == true && var8 == "test"))
								{
									var var9 = new Object();
									var9.name = var7;
									var var10 = Number(var4.attributes.zaapconnectport);
									var9.zaapConnectPort = !(var10 == undefined || _global.isNaN(var10))?var10:dofus.ZaapConnect.TCP_DEFAULT_PORT;
									var9.debug = var4.attributes.boo == "1";
									var9.debugRequests = var4.attributes.debugrequests == "1" || var4.attributes.debugrequests == "2";
									var9.logRequests = var4.attributes.debugrequests == "2";
									var9.connexionServers = new ank.utils.();
									var9.dataServers = new Array();
									var var11 = var4.firstChild;
									while(var11 != null)
									{
										switch(var11.nodeName)
										{
											case "dataserver":
												var var12 = var11.attributes.url;
												var var13 = var11.attributes.type;
												var var14 = Number(var11.attributes.priority);
												if(var12 != undefined && var12 != "")
												{
													var9.dataServers.push({url:var12,type:var13,priority:var14});
													System.security.allowDomain(var12);
												}
												break;
											case "connserver":
												var var15 = var11.attributes.name;
												var var16 = var11.attributes.ip;
												var var17 = var11.attributes.port;
												if(var15 != undefined && (var16 != "" && var17 != undefined))
												{
													var9.connexionServers.push({label:var15,data:{name:var15,ip:var16,port:var17}});
												}
												break;
											default:
												this.nonCriticalError(this.getText("UNKNOWN_TYPE_NODE") + " (" + var4.nodeName + ")",this.TABULATION);
										}
										var11 = var11.nextSibling;
									}
									if(var9.dataServers.length > 0)
									{
										var5.push({label:var9.name,data:var9});
									}
								}
								break loop4;
							default:
								switch(null)
								{
									case "languages":
										_global.CONFIG.xmlLanguages = var4.attributes.value.split(",");
										_global.CONFIG.skipLanguageVerification = var4.attributes.skipcheck == "true" || var4.attributes.skipcheck == "1";
										break loop4;
									case "cacheasbitmap":
										var var18 = var4.firstChild;
										while(var18 != null)
										{
											var var19 = var18.attributes.element;
											var var20 = var18.attributes.value == "true";
											_global.CONFIG.cacheAsBitmap[var19] = var20;
											var18 = var18.nextSibling;
										}
										break loop4;
									case "servers":
										var var21 = var4.firstChild;
										_global.CONFIG.customServersIP = new Array();
										while(var21 != null)
										{
											var var22 = var21.attributes.id;
											var var23 = var21.attributes.ip;
											var var24 = var21.attributes.port;
											_global.CONFIG.customServersIP[var22] = {ip:var23,port:var24};
											var21 = var21.nextSibling;
										}
										break loop4;
									default:
										this.nonCriticalError(this.getText("UNKNOWN_TYPE_NODE") + " (" + var4.nodeName + ")",this.TABULATION);
								}
						}
				}
				var4 = var4.nextSibling;
			}
			if(var5.length == 0)
			{
				this.criticalError("CORRUPT_CONFIG_FILE",this.TABULATION,false);
				return undefined;
			}
			this.log(this.TABULATION + this.getText("CONFIG_FILE_LOADED"));
			this.askForConfiguration(var5);
		}
		this.criticalError("NO_CONFIG_FILE",this.TABULATION,false);
		return undefined;
	}
	function askForConfiguration(var2)
	{
		if(var2.length == 1 && var2[0].data.connexionServers.length == 0)
		{
			this.chooseConfiguration(var2[0].data,undefined,false);
		}
		else
		{
			this.logTitle(this.getText("CHOOSE_CONFIGURATION"));
			this["\x1e\b\x16"].dataProvider = var2;
			var var3 = this.getOptionsSharedObject().data.loaderLastConfName;
			if(var3 != undefined)
			{
				var var4 = 0;
				while(var4 < var2.length)
				{
					if(var2[var4].data.name == var3)
					{
						this["\x1e\b\x16"].selectedIndex = var4;
						break;
					}
					var4 = var4 + 1;
				}
			}
			else
			{
				this["\x1e\b\x16"].selectedIndex = 0;
			}
			this.selectConfiguration();
			this.showConfigurationChoice(true);
		}
	}
	function selectConfiguration()
	{
		var var2 = this["\x1e\b\x16"].selectedItem.data.connexionServers;
		this["\x1e\b\x15"].dataProvider = var2;
		var var3 = this.getOptionsSharedObject();
		var var4 = var3.data.loaderConf[this["\x1e\b\x16"].selectedItem.label];
		if(var4 != undefined)
		{
			var var5 = 0;
			while(var5 < var2.length)
			{
				if(var2[var5].data.name == var4)
				{
					this["\x1e\b\x15"].selectedIndex = var5;
					break;
				}
				var5 = var5 + 1;
			}
		}
		else if(var2.length > 0)
		{
			this["\x1e\b\x15"].selectedIndex = 0;
		}
		var3.data.loaderLastConfName = this["\x1e\b\x16"].selectedItem.label;
		var3.flush();
		this.selectConnexionServer();
	}
	function selectConnexionServer()
	{
		var var2 = this.getOptionsSharedObject();
		if(var2.data.loaderConf == undefined)
		{
			var2.data.loaderConf = new Object();
		}
		var2.data.loaderConf[this["\x1e\b\x16"].selectedItem.label] = this["\x1e\b\x15"].selectedItem.label;
		var2.flush();
	}
	function chooseConfiguration(var2, var3, var4)
	{
		this.showConfigurationChoice(false);
		if(var4)
		{
			this.log(this.TABULATION + this.getText("CURRENT_CONFIG",[var2.name]));
			if(oServer != undefined)
			{
				this.log(this.TABULATION + this.getText("CURRENT_SERVER",[oServer.name]));
			}
		}
		_global.CONFIG.dataServers = var2.dataServers;
		_global.CONFIG.connexionServer = oServer;
		_global.CONFIG.zaapConnectPort = var2.zaapConnectPort;
		if(var2.debug)
		{
			dofus.Constants.DEBUG = true;
			this.logYellow(this.TABULATION + this.getText("DEBUG_MODE"));
		}
		if(var2.debugRequests)
		{
			dofus.Constants.DEBUG_DATAS = true;
		}
		if(var2.logRequests)
		{
			dofus.Constants.LOG_DATAS = true;
		}
		dofus.ZaapConnect.newInstance();
		this.loadLocalFileList();
	}
	function startJsTimer()
	{
		this._nTimerJs--;
		if(this._nTimerJs <= 0)
		{
			this._nTimerJs = 20;
			this.getURL("javascript:startTimer()");
		}
		if(this._bJsTimer)
		{
			this.addToQueue({object:this,method:this.startJsTimer});
		}
	}
	function loadLanguage()
	{
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("javascript:startTimer()");
			this.startJsTimer();
		}
		this.logTitle(this.getText("LOAD_LANG_FILE"));
		this._sStep = "LANG";
		this._aCurrentDataServers = this.copyAndOrganizeDataServerList();
		var var2 = this.getLangSharedObject().data.VERSIONS.lang;
		_global[dofus.Constants.GLOBAL_SO_LANG_NAME] = this.getLangSharedObject();
		this.log(this.TABULATION + this.getText("CURRENT_LANG_FILE_VERSION",[var2 != undefined?var2:"Aucune"]));
		this.log(this.TABULATION + this.getText("CHECK_LAST_VERSION"));
		this._oXtraCurrentVersion.lang = !_global.isNaN(var2)?Number(var2):0;
		this.checkLanguageWithNextHost("lang," + var2);
	}
	function checkLanguageWithNextHost(sFiles)
	{
		if(this._aCurrentDataServers.length < 1)
		{
			if(!this._bLocalFileListLoaded)
			{
				this.criticalError("CHECK_LAST_VERSION_FAILED",this.TABULATION,true,new Array(),"checkXtra");
			}
			else
			{
				this.nonCriticalError("CHECK_LAST_VERSION_FAILED",this.TABULATION,true);
				var var2 = new LoadVars();
				var var3 = new Array();
				var var4 = this._mcLocalFileList.VERSIONS[_global.CONFIG.language];
				for(var i in var4)
				{
					var3.push(i + "," + _global.CONFIG.language + "," + var4[i]);
				}
				var2.f = var3.join("|");
				this.onCheckLanguage(true,var2);
			}
			return undefined;
		}
		var oServer = this._aCurrentDataServers.shift();
		if(oServer.type == "local")
		{
			this.checkLanguageWithNextHost(sFiles);
			return undefined;
		}
		var var5 = oServer.url + "lang/versions_" + _global.CONFIG.language + ".txt" + "?wtf=" + Math.random();
		var var6 = new LoadVars();
		var loader = this;
		var6.onLoad = function(var2)
		{
			loader.onCheckLanguage(var2,this,oServer.url,sFiles);
		};
		this.showWaitBar(true);
		var6.load(var5,this,"GET");
	}
	function onCheckLanguage(var2, var3, var4, var5)
	{
		this.showWaitBar(false);
		if(var2 && var3.f != undefined)
		{
			this.setTotalBarValue(100,100);
			this._sDistantFileList = var3.f;
			var var6 = var3.f.substr(var3.f.indexOf("lang,")).split("|")[0].split(",");
			var var7 = false;
			if(var3.f != "")
			{
				var var8 = var6[2];
				if(_global.CONFIG.language == this.getLangSharedObject().data.LANGUAGE && (this._oXtraCurrentVersion.lang != undefined && var8 == this._oXtraCurrentVersion.lang))
				{
					var7 = true;
				}
				else
				{
					this.log(this.TABULATION + this.getText("NEW_LANG_FILE_AVAILABLE",[var6[2]]));
					if(this._bSkipDistantLoad)
					{
						if(this._oXtraCurrentVersion.lang == 0)
						{
							var8 = this._mcLocalFileList.VERSIONS[_global.CONFIG.language].lang;
						}
					}
					this.updateLanguage(var6[2]);
				}
			}
			else
			{
				var7 = true;
			}
			if(var7)
			{
				this.log(this.TABULATION + this.getText("NO_NEW_VERSION_AVAILABLE"));
				this.loadModules();
			}
		}
		else
		{
			this.nonCriticalError(this.getText("IMPOSSIBLE_TO_JOIN_SERVER",[var4]),this.TABULATION + this.TABULATION);
			this.checkLanguageWithNextHost(var5);
		}
	}
	function updateLanguage(var2)
	{
		this._bUpdate = true;
		this.showWaitBar(true);
		var var3 = new dofus.utils.();
		var3.addListener(this);
		var3.load(this.copyAndOrganizeDataServerList(),"lang/swf/lang_" + _global.CONFIG.language + "_" + var2 + ".swf",this._mcContainer,dofus.Constants.LANG_SHAREDOBJECT_NAME,"lang",_global.CONFIG.language);
	}
	function loadModules()
	{
		this.logTitle(this.getText("LOAD_MODULES"));
		this._sStep = "MODULE";
		this._aCurrentModules = dofus.Constants.MODULES_LIST.slice(0);
		this.loadNextModule();
	}
	function loadNextModule()
	{
		if(this._aCurrentModules.length < 1)
		{
			this.logTitle(this.getText("INIT_END"));
			this.onCoreLoaded(_global.MODULE_CORE);
			return undefined;
		}
		this._aCurrentModule = this._aCurrentModules.shift();
		var var2 = this._aCurrentModule[0];
		var var3 = this._aCurrentModule[1];
		var var4 = this._aCurrentModule[2];
		var var5 = this._aCurrentModule[4];
		this._mcCurrentModule = this._mcModules.createEmptyMovieClip("mc" + var5,this._mcModules.getNextHighestDepth());
		this._timedProgress = _global.setInterval(this.onTimedProgress,1000,this,this._mclLoader,this._mcCurrentModule);
		this._mclLoader.loadClip(var3,this._mcCurrentModule);
	}
	function onCoreLoaded(var2)
	{
		if(_global.CONFIG.isStreaming)
		{
			this._bJsTimer = false;
			this.getURL("javascript:stopTimer()");
		}
		if((this._bNonCriticalError || this._bUpdate) && (dofus.Constants.DEBUG && dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST == undefined))
		{
			this.showNextButton(true);
			this.showCopyLogsButton(true);
			this.showShowLogsButton(true);
		}
		else
		{
			this.initCore(var2);
		}
	}
	function initCore(var2)
	{
		Key.removeListener(this);
		if((var var3 = dofus.DofusCore.getInstance()) == undefined)
		{
			var3 = new dofus.(var2);
			if(Key.isDown(Key.SHIFT))
			{
				Stage.scaleMode = "exactFit";
			}
		}
		var3.initStart();
		this._bNonCriticalError = false;
		this._bUpdate = false;
	}
	function loadLocalFileList()
	{
		this.logTitle(this.getText("LOAD_XTRA_FILES"));
		this._aCurrentDataServers = this.copyAndOrganizeDataServerList();
		this.checkLocalFileListWithNextHost(dofus.Constants.LANG_LOCAL_FILE_LIST);
		this.showWaitBar(true);
	}
	function checkLocalFileListWithNextHost(sFiles)
	{
		if(this._aCurrentDataServers.length < 1)
		{
			this.nonCriticalError("CHECK_LAST_VERSION_FAILED",this.TABULATION,true);
			this.loadLanguage();
			return undefined;
		}
		var var2 = this._aCurrentDataServers.shift();
		var sURL = var2.url + sFiles;
		var loader = this;
		var var3 = new MovieClipLoader();
		var var4 = new Object();
		var4.onLoadInit = function(var2)
		{
			loader.loadLanguage();
			loader._bLocalFileListLoaded = true;
		};
		var4.onLoadError = function(var2)
		{
			loader.checkLocalFileListWithNextHost(sFiles);
		};
		var3.addListener(var4);
		var3.loadClip(sURL,this._mcLocalFileList);
	}
	function loadXtra()
	{
		this.clearlogs();
		this.showLoader(true);
		this.showBanner(true);
		this.showMainLogger(false);
		this.showShowLogsButton(false);
		this.showConfigurationChoice(false);
		this.showNextButton(false);
		this.showContinueButton(false);
		this.showClearCacheButton(false);
		this.showCopyLogsButton(false);
		this.showProgressBar(false);
		this.launchBannerAnim(true);
		this.setTotalBarValue(0,100);
		this.showBasicInformations();
		if(!this.checkOccurences())
		{
			this.showShowLogsButton(false);
			this.showCopyLogsButton(false);
			return undefined;
		}
		this.logTitle(this.getText("LOAD_XTRA_FILES"));
		this.log(this.TABULATION + this.getText("CHECK_LAST_VERSION"));
		this._sStep = "XTRA";
		this.moveProgressBar(-60);
		_global[dofus.Constants.GLOBAL_SO_XTRA_NAME] = ank.utils.SharedObjectFix.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME);
		var var2 = dofus.utils.Api.getInstance();
		if(var2 != undefined)
		{
			var2.lang.clearSOXtraCache();
		}
		this._aCurrentDataServers = this.copyAndOrganizeDataServerList();
		var var3 = this.getXtraSharedObject().data.VERSIONS;
		var var4 = _global.API.lang.getConfigText("XTRA_FILE");
		var var5 = 0;
		while(var5 < var4.length)
		{
			var var6 = var4[var5];
			var var7 = var3[var6] != undefined?var3[var6]:0;
			this._oXtraCurrentVersion[var6] = var7;
			var5 = var5 + 1;
		}
		this.showWaitBar(false);
		this._aXtraList = this._sDistantFileList.split("|");
		this._nTotalFile = this._aXtraList.length;
		this.updateNextXtra();
	}
	function updateNextXtra()
	{
		if(this._bSkipDistantLoad && this._oCurrentXtraLoadFile != undefined)
		{
			this._aXtraList.push(this._oCurrentXtraLoadFile);
		}
		if(this._aXtraList.length < 1)
		{
			this.noMoreXtra();
		}
		else
		{
			while(true)
			{
				if(this._aXtraList.length > 0)
				{
					this.setTotalBarValue(10 + (90 - 90 / this._nTotalFile * (this._aXtraList.length - 1)),100);
					this._aCurrentXtra = this._aXtraList.shift().split(",");
					if(this._aXtraList.length > 0 && this._aCurrentXtra[2])
					{
						if(!this._bSkipDistantLoad)
						{
							this._oCurrentXtraLoadFile = this._aCurrentXtra;
						}
						var var2 = this._aCurrentXtra[0];
						var var3 = this._aCurrentXtra[1];
						var var4 = this._aCurrentXtra[2];
						if(var2 == "lang")
						{
							continue;
						}
						this["\x1e\b\x12"]["\x1e\n\x11"].text = var2;
						if(_global.CONFIG.language == this.getLangSharedObject().data.LANGUAGE && Number(var4) == this._oXtraCurrentVersion[var2])
						{
							continue;
						}
						if(this._bLocalFileListLoaded)
						{
							if(this._bSkipDistantLoad)
							{
								if(this._oXtraCurrentVersion[var2] == 0)
								{
									var4 = this._mcLocalFileList.VERSIONS[_global.CONFIG.language][var2];
									break;
								}
								continue;
							}
							break;
						}
						if(this._bSkipDistantLoad)
						{
							return undefined;
						}
						break;
					}
					continue;
				}
				this.noMoreXtra();
			}
			this._bUpdate = true;
			this._aCurrentXtra[3] = this._aCurrentXtra[0] + "_" + this._aCurrentXtra[1] + "_" + this._aCurrentXtra[2];
			this.log(this.TABULATION + this.getText("UPDATE_FILE",[var2]));
			this.showWaitBar(true);
			var var5 = new dofus.utils.();
			var5.addListener(this);
			if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
			{
				this.getURL("JavaScript:WriteLog(\'updateNextXtra;" + var2 + "_" + _global.CONFIG.language + "_" + var4 + "\')");
			}
			var5.load(this.copyAndOrganizeDataServerList(),"lang/swf/" + var2 + "_" + _global.CONFIG.language + "_" + var4 + ".swf",this._mcContainer,dofus.Constants.XTRA_SHAREDOBJECT_NAME,var2,_global.CONFIG.language,true);
			return undefined;
		}
	}
	function noMoreXtra()
	{
		this.logTitle(this.getText("INIT_END"));
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'XtraLangLoadEnd\')");
		}
		if((this._bNonCriticalError || this._bUpdate) && (dofus.Constants.DEBUG && dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST == undefined))
		{
			this.showNextButton(true);
			this.showCopyLogsButton(true);
			this.showShowLogsButton(true);
		}
		else
		{
			this.initAndLoginFinished();
		}
	}
	function initAndLoginFinished()
	{
		this.showLoader(false);
		_global.API.kernel.onInitAndLoginFinished();
		this._bNonCriticalError = false;
		this._bUpdate = false;
		this.launchBannerAnim(false);
		this.showBanner(false);
	}
	function checkCacheVersion()
	{
		var var2 = new Date();
		var var3 = var2.getFullYear() + "-" + (var2.getMonth() + 1) + "-" + var2.getDate();
		if(!this.getCacheDateSharedObject().data.clearDate)
		{
			this.clearCache();
			this.getCacheDateSharedObject().data.clearDate = var3;
			this.getCacheDateSharedObject().flush(100);
			return false;
		}
		if(_global[dofus.Constants.GLOBAL_SO_LANG_NAME] && (_global[dofus.Constants.GLOBAL_SO_LANG_NAME].data.C.CLEAR_DATE && _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data.C.ENABLED_AUTO_CLEARCACHE))
		{
			if(this.getCacheDateSharedObject().data.clearDate < _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data.C.CLEAR_DATE)
			{
				this.clearCache();
				this.getCacheDateSharedObject().data.clearDate = _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data.C.CLEAR_DATE;
				this.getCacheDateSharedObject().flush();
				this.reboot();
				return false;
			}
		}
		return true;
	}
	function onLoadStart(var2)
	{
		this.showWaitBar(false);
		this.setProgressBarValue(0,100);
	}
	function onTimedProgress(var2, var3, var4)
	{
		var var5 = var3.getProgress(var4);
		var2.setProgressBarValue(Number(var5.bytesLoaded),Number(var5.bytesTotal));
	}
	function onLoadError(§\n\x1d§, §\x0f\x06§, §\r\x03§, oServer)
	{
		_global.clearInterval(this._timedProgress);
		this.showProgressBar(false);
		this.showWaitBar(false);
		switch(this._sStep)
		{
			case "LANG":
				if(oServer.type == "local")
				{
					this.log(this.TABULATION + this.TABULATION + this.getText("NO_FILE_IN_LOCAL",["lang",oServer.url]));
				}
				else
				{
					if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
					{
						this.getURL("JavaScript:WriteLog(\'onLoadError LANG-" + oServer.url + "lang" + "\')");
					}
					this.nonCriticalError(this.getText("IMPOSSIBLE_TO_DOWNLOAD_FILE",["lang",oServer.url]),this.TABULATION + this.TABULATION);
				}
				break;
			case "MODULE":
				if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
				{
					this.getURL("JavaScript:WriteLog(\'onLoadError MODULE-" + this._aCurrentModule[4] + "\')");
				}
				this.criticalError("IMPOSSIBLE_TO_LOAD_MODULE",this.TABULATION,true,[this._aCurrentModule[4]]);
				break;
			case "XTRA":
				if(oServer.type == "local")
				{
					this.log(this.TABULATION + this.TABULATION + this.getText("NO_FILE_IN_LOCAL",[this._aCurrentXtra[3],oServer.url]));
					break;
				}
				if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
				{
					this.getURL("JavaScript:WriteLog(\'onLoadError XTRA-" + oServer.url + this._aCurrentXtra[3] + "\')");
				}
				this.nonCriticalError(this.getText("IMPOSSIBLE_TO_DOWNLOAD_FILE",[this._aCurrentXtra[3],oServer.url]),this.TABULATION + this.TABULATION);
				break;
		}
	}
	function onLoadComplete(var2)
	{
		_global.clearInterval(this._timedProgress);
		if(this._sStep == "MODULE")
		{
			_global["MODULE_" + this._aCurrentModule[4]] = var2;
		}
	}
	function onLoadInit(§\n\x1d§, oServer)
	{
		this.showProgressBar(false);
		switch(this._sStep)
		{
			case "LANG":
				this.logGreen(this.TABULATION + this.getText("UPDATE_FINISH",["lang",oServer.url]));
				if(!this.checkCacheVersion())
				{
					return undefined;
				}
				this.loadModules();
				break;
			case "MODULE":
				this.log(this.TABULATION + this.getText("MODULE_LOADED",[this._aCurrentModule[4]]));
				if(!this.checkCacheVersion())
				{
					return undefined;
				}
				this.loadNextModule();
				break;
			default:
				if(var0 !== "XTRA")
				{
					break;
				}
				if(oServer.type == "local")
				{
					this.logGreen(this.TABULATION + this.TABULATION + this.getText("FILE_LOADED",[this._aCurrentXtra[3],oServer.url]));
				}
				else
				{
					this.logGreen(this.TABULATION + this.TABULATION + this.getText("UPDATE_FINISH",[this._aCurrentXtra[3],oServer.url]));
				}
				this._oCurrentXtraLoadFile = undefined;
				this.updateNextXtra();
				break;
		}
	}
	function onCorruptFile(§\n\x1d§, §\x1e\n\x1a§, oServer)
	{
		switch(this._sStep)
		{
			case "LANG":
				this.nonCriticalError(this.getText("CORRUPT_FILE",["lang",oServer.url,var3]),this.TABULATION + this.TABULATION);
				break;
			case "XTRA":
				this.nonCriticalError(this.getText("CORRUPT_FILE",[this._aCurrentXtra[3],oServer.url,var3]),this.TABULATION + this.TABULATION);
		}
	}
	function onCantWrite(var2)
	{
		switch(this._sStep)
		{
			case "LANG":
				this.criticalError("WRITE_FAILED",this.TABULATION + this.TABULATION,true,["lang"]);
				break;
			case "XTRA":
				this.criticalError("WRITE_FAILED",this.TABULATION + this.TABULATION,true,[this._aCurrentXtra[3]]);
		}
	}
	function onAllLoadFailed(var2)
	{
		this.showProgressBar(false);
		this.showWaitBar(false);
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'onAllLoadFailed;" + this._sStep + "\')");
		}
		switch(this._sStep)
		{
			case "LANG":
				if(!this._bSkipDistantLoad)
				{
					this.criticalError("CANT_UPDATE_FILE",this.TABULATION + this.TABULATION,true,["lang"]);
				}
				else
				{
					this.nonCriticalError("CANT_UPDATE_FILE",this.TABULATION + this.TABULATION,true,["lang"]);
				}
				this._bSkipDistantLoad = true;
				break;
			case "XTRA":
				this._bSkipDistantLoad = true;
				this.nonCriticalError("CANT_UPDATE_FILE",this.TABULATION + this.TABULATION,true,[this._aCurrentXtra[3]]);
				this.updateNextXtra();
		}
	}
	function onCoreDisplayed()
	{
		this.launchBannerAnim(false);
		this.showBanner(false);
		this.showLoader(false);
	}
}
