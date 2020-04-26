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
	static function main(loc2)
	{
		if(_root.dofusPreLoaderMc == undefined)
		{
			return undefined;
		}
		System.security.allowDomain("*");
		getURL("FSCommand:" add "trapallkeys","true");
		getURL("FSCommand:" add "CustomerStart","");
		_root = loc2;
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
	function addLoadingBannersFiles(loc2)
	{
		var xDoc = new XML();
		xDoc.onLoad = function(loc2)
		{
			if(loc2)
			{
				var loc3 = this.firstChild.firstChild;
				if(loc3 != null && this.childNodes.length > 0)
				{
					while(loc3 != null)
					{
						if(loc3.nodeName == "loadingbanner")
						{
							var loc4 = loc3.attributes.file;
							xDoc.parent._aLoadingBannersFiles.push(loc4);
						}
						loc3 = loc3.nextSibling;
					}
				}
			}
			xDoc.parent._bLoadingBannersFilesLoaded = true;
			xDoc.parent.showBanner(xDoc.bShow);
		};
		xDoc.ignoreWhite = true;
		xDoc.bShow = loc2;
		xDoc.parent = this;
		xDoc.load(dofus.Constants.XML_LOADING_BANNERS_PATH);
	}
	function initLoader(loc2)
	{
		this._sPrefixURL = this._url.substr(0,this._url.lastIndexOf("/") + 1);
		_global.CONFIG = new dofus.utils.();
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
		this._mcModules = loc2.createEmptyMovieClip("mcModules",loc2.getNextHighestDepth());
		this._mclLoader = new MovieClipLoader();
		this._mclLoader.addListener(this);
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initComponents});
		this.addToQueue({object:this,method:this.showBasicInformations,params:[true]});
	}
	function initComponents()
	{
		this["\x1e\x0b\x04"].text = this.getText("SERVER");
		this["\x1e\x0b\x05"].text = this.getText("CONFIGURATION");
		this["\x1e\n\x1b"]["\x1e\f\x1a"].text = "Loading";
		this["\x1e\x0b\x0b"].label = this.getText("VALID");
		this["\x1e\x0b\x0b"].addEventListener("click",this);
		this._btnContinue.label = this.getText("CONTINUE");
		this._btnContinue.addEventListener("click",this);
		this._btnClearCache.label = this.getText("CLEAR_CACHE");
		this._btnClearCache.addEventListener("click",this);
		this._btnNext.label = this.getText("NEXT");
		this._btnNext.addEventListener("click",this);
		this["\x1e\x0b\t"].label = this.getText("SHOW_LOGS");
		this["\x1e\x0b\t"].addEventListener("click",this);
		this["\x1e\x0b\n"].label = this.getText("COPY_LOGS");
		this["\x1e\x0b\n"].addEventListener("click",this);
		this["\x1e\x0b\x03"].addEventListener("itemSelected",this);
		this["\x1e\x0b\x02"].addEventListener("itemSelected",this);
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
		var loc2 = new Object();
		this.ERRORS.TOO_MANY_OCCURENCES = loc2;
		loc2.fr = "Vous ne pouvez pas lancer plus de clients DOFUS sur cet ordinateur.";
		loc2.en = "You can\'t start anymore DOFUS client on this computer.";
		loc2.es = "No puedes abrir más clientes DOFUS en este ordenador.";
		loc2.de = "Es kann kein weiterer DOFUS-Client auf diesem Computer gestartet werden.";
		loc2.pt = "Você não pode começar o cliente de DOFUS de novo neste computador.";
		loc2.nl = "Je kan de DOFUS client niet meer op deze computer opstarten.";
		loc2.it = "Non puoi lanciare più client su questo computer.";
		loc2.linkfr = "http://www.dofus.com";
		loc2.linken = "http://www.dofus.com";
		loc2.linkes = "http://www.dofus.com";
		loc2.linkde = "http://www.dofus.com";
		loc2.linkpt = "http://www.dofus.com";
		loc2 = new Object();
		this.ERRORS.BAD_FLASH_PLAYER = loc2;
		loc2.fr = "Vous devez posséder le lecteur Flash Player version 8 ou supérieure. (Version actuelle : " + System.capabilities.version + ")";
		loc2.en = "You have to install the Flash Player version 8 or higher. (Actual version : " + System.capabilities.version + ")";
		loc2.es = "Debes instalar el reproductor Flash Player versión 8 o superior. (Versión actual: " + System.capabilities.version + ")";
		loc2.de = "Es wird die Version 8 oder höher des Flash Players benötigt. (Aktuelle Version: " + System.capabilities.version + ")";
		loc2.pt = "Você precisa instalar a versão 8 ou superior do Flash Player. (Versão atual : " + System.capabilities.version + ")";
		loc2.nl = "Je moet Flash Player versie 8 of hoger installeren. (Huidige versie : " + System.capabilities.version + ")";
		loc2.it = "Devi avere il lettore Flash Player versione 8 o avanzata (Versione attuale:" + System.capabilities.version + ")";
		loc2.linkfr = "http://store.adobe.com/go/getflashplayer";
		loc2.linken = "http://store.adobe.com/go/getflashplayer";
		loc2.linkes = "http://store.adobe.com/go/getflashplayer";
		loc2.linkde = "http://store.adobe.com/go/getflashplayer";
		loc2.linkpt = "http://store.adobe.com/go/getflashplayer";
		loc2 = new Object();
		this.ERRORS.BAD_FLASH_SANDBOX = loc2;
		loc2.fr = "Les paramètres de sécurité actuels du lecteur Flash ne permettent pas à DOFUS de s\'executer.";
		loc2.en = "You must configure DOFUS as a trusted application on the Flash Player security settings.";
		loc2.es = "Los parámetros de seguridad actuales del reproductor Flash no permiten la ejecución de DOFUS.";
		loc2.de = "DOFUS muss als vertrauenswürdige Anwendung in den Sicherheitseinstellungen des Flash Players konfiguriert werden.";
		loc2.pt = "Você deve configurar DOFUS como uma aplicação confiável nas configurações de segurança do Flash Player.";
		loc2.nl = "Je zult DOFUS als een veilige aplicatie moeten instellen bij de beveiligings instellingen van je Flash Player.";
		loc2.it = "I parametri di sicurezza attuali del lettore Flash non permettono l\'esecuzione di DOFUS.";
		loc2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=984&_gid=1&languageid=2&group=dofusfr";
		loc2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=985&_gid=1&languageid=1&group=dofusen";
		loc2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=985&_gid=1&languageid=1&group=dofusen";
		loc2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=985&_gid=1&languageid=1&group=dofusen";
		loc2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=985&_gid=1&languageid=1&group=dofusen";
		loc2 = new Object();
		this.ERRORS.UPDATE_LANG_IMPOSSIBLE = loc2;
		loc2.fr = "Impossible de charger le fichier de langue";
		loc2.en = "Impossible to download the language file";
		loc2.es = "Descarga del archivo de idioma imposible";
		loc2.de = "Download der Sprachdatei nicht möglich";
		loc2.pt = "Impossível baixar o arquivo de idioma";
		loc2.nl = "Onmogelijk om dit taalbestand te downloaden";
		loc2.it = "Non è possibile caricare il file di lingua";
		loc2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=961&_gid=1&languageid=2&group=dofusfr";
		loc2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=971&_gid=1&languageid=1&group=dofusen";
		loc2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=971&_gid=1&languageid=1&group=dofusen";
		loc2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=971&_gid=1&languageid=1&group=dofusen";
		loc2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=971&_gid=1&languageid=1&group=dofusen";
		loc2 = new Object();
		this.ERRORS.NO_CONFIG_FILE = loc2;
		loc2.fr = "Impossible de charger le fichier de configuration";
		loc2.en = "Impossible to load the configuration file";
		loc2.es = "No se puede cargar el archivo de configuración";
		loc2.de = "Laden der Konfigurationsdatei nicht möglich";
		loc2.pt = "Impossível carregar o arquivo de configuração";
		loc2.nl = "Onmogelijk om het configuratie bestand te laden";
		loc2.it = "Non è possibile caricare il file di configurazione";
		loc2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=957&_gid=1&languageid=2&group=dofusfr";
		loc2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		loc2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		loc2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		loc2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		loc2 = new Object();
		this.ERRORS.CORRUPT_CONFIG_FILE = loc2;
		loc2.fr = "Impossible de lire le fichier de configuration";
		loc2.en = "Impossible to read the configuration file";
		loc2.es = "No es posible leer el archivo de configuración";
		loc2.de = "Unmöglich die Konfigurationsdatei zu lesen";
		loc2.pt = "Impossível ler o arquivo de configuração";
		loc2.nl = "Onmogelijk om het configuratie bestand te lezen";
		loc2.it = "Non è possibile leggere il file di configurazione";
		loc2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=957&_gid=1&languageid=2&group=dofusfr";
		loc2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		loc2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		loc2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		loc2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=968&_gid=1&languageid=1&group=dofusen";
		loc2 = new Object();
		this.ERRORS.CHECK_LAST_VERSION_FAILED = loc2;
		loc2.fr = "Impossible de vérifier les mises à jour";
		loc2.en = "Impossible to check updates";
		loc2.es = "No es posible comprobar las actualizacones";
		loc2.de = "Updateprüfung nicht möglich";
		loc2.pt = "Impossível verificar atualizações";
		loc2.nl = "Onmogelijk om op updates te controleren";
		loc2.it = "Non è possibile verificare gli aggiornamenti";
		loc2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=955&_gid=1&languageid=2&group=dofusfr";
		loc2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		loc2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		loc2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		loc2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		loc2 = new Object();
		this.ERRORS.IMPOSSIBLE_TO_LOAD_MODULE = loc2;
		loc2.fr = "Impossible de charger le module <b>%1</b>";
		loc2.en = "Impossible to download the module <b>%1</b>";
		loc2.es = "No es posible descargar el módulo <b>%1</b>";
		loc2.de = "Download des Moduls  <b>%1</b> nicht möglich";
		loc2.pt = "Impossível baixar o módulo <b>%1</b>";
		loc2.nl = "Onmogelijk om module <b>%1</b> te downloaden";
		loc2.it = "Non è possibile caricare il modulo <b>%1</b>";
		loc2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=963&_gid=1&languageid=2&group=dofusfr";
		loc2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=976&_gid=1&languageid=1&group=dofusen";
		loc2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=976&_gid=1&languageid=1&group=dofusen";
		loc2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=976&_gid=1&languageid=1&group=dofusen";
		loc2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=976&_gid=1&languageid=1&group=dofusen";
		loc2 = new Object();
		this.ERRORS.WRITE_FAILED = loc2;
		loc2.fr = "Impossible de sauvegarder le fichier <b>%1</b> en local";
		loc2.en = "Impossible to save file <b>%1</b> in local";
		loc2.es = "No es posible guardar el archivo <b>%1</b> en local";
		loc2.de = "Lokales Speichern der Datei <b>%1</b> nicht möglich";
		loc2.pt = "Impossível salvar o arquivo <b>%1</b> localmente";
		loc2.nl = "Onmogelijk het bestand <b>%1</b> lokaal te bewaren";
		loc2.it = "Non è possibile registrare il file <b>%1</b> su rete locale";
		loc2.linkfr = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=965&_gid=1&languageid=2&group=dofusfr";
		loc2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=973&_gid=1&languageid=1&group=dofusen";
		loc2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=973&_gid=1&languageid=1&group=dofusen";
		loc2.linkde = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=973&_gid=1&languageid=1&group=dofusen";
		loc2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=973&_gid=1&languageid=1&group=dofusen";
		loc2 = new Object();
		this.ERRORS.CANT_UPDATE_FILE = loc2;
		loc2.fr = "Impossible de mettre a jour le fichier <b>%1</b>";
		loc2.en = "Impossible to update file <b>%1</b>";
		loc2.es = "No es posible actualizar el archivo <b>%1</b>";
		loc2.de = "Update der Datei <b>%1</b> nicht möglich";
		loc2.pt = "Impossível atualizar o arquivo <b>%1</b>";
		loc2.nl = "Onmogelijk om het bestand <b>%1</b> te updaten";
		loc2.it = "Non è possibile aggiornare il file <b>%1</b>";
		loc2.linkfr = "http://support.ankama-games.com/index.php?_gid=1&languageid=2&group=dofusfr";
		loc2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		loc2.linkes = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		loc2.linken = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
		loc2.linkpt = "http://support.ankama-games.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=967&_gid=1&languageid=1&group=dofusen";
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
	function log(loc2, loc3, loc4)
	{
		if(loc3 == undefined)
		{
			loc3 = "#CCCCCC";
		}
		if(loc4 == undefined)
		{
			loc4 = "#666666";
		}
		this._currentLogger.log(loc2,loc3,loc4);
		this.addToSaveLog(loc2);
	}
	function addToSaveLog(loc2)
	{
		this._sLogs = this._sLogs + (new ank.utils.(loc2).replace("&nbsp;"," ") + "\r\n");
	}
	function logTitle(loc2)
	{
		this.log("");
		this.log(loc2,"#CCCCCC","#CCCCCC");
	}
	function logRed(loc2)
	{
		this.log(loc2,"#FF0000","#DD0000");
	}
	function logGreen(loc2)
	{
		this.log(loc2,"#00FF00","#00AA00");
	}
	function logOrange(loc2)
	{
		this.log(loc2,"#FF9900","#DD7700");
	}
	function logYellow(loc2)
	{
		this.log(loc2,"#FFFF00","#AAAA00");
	}
	function getText(loc2, loc3)
	{
		var loc4 = this.LANG_TEXT[loc2][_global.CONFIG.language];
		if(loc4 == undefined || loc4.length == 0)
		{
			loc4 = _global[dofus.Constants.GLOBAL_SO_LANG_NAME].data[loc2];
		}
		if(loc4 == undefined || loc4.length == 0)
		{
			loc4 = this.LANG_TEXT[loc2].fr;
		}
		return this.replaceText(loc4,loc3);
	}
	function replaceText(loc2, loc3)
	{
		if(loc3 == undefined)
		{
			loc3 = new Array();
		}
		var loc4 = new Array();
		var loc5 = new Array();
		var loc6 = 0;
		while(loc6 < loc3.length)
		{
			loc4.push("%" + (loc6 + 1));
			loc5.push(loc3[loc6]);
			loc6 = loc6 + 1;
		}
		return new ank.utils.(loc2).replace(loc4,loc5);
	}
	function clearlogs()
	{
		this["\x1e\x0b\b"].clear();
		this["\x1e\x0b\x06"].clear();
		this["\x1e\x0b\x07"].clear();
	}
	function setProgressBarValue(loc2, loc3)
	{
		this.showProgressBar(true);
		if(loc2 > loc3)
		{
			loc2 = loc3;
		}
		this["\x1e\n\x1c"]["\x0b\x17"]._width = loc2 / loc3 * 100;
		this["\x1e\n\x1c"]["\x1e\f\x19"].text = Math.floor(Number(this["\x1e\n\x1c"]["\x0b\x17"]._width)) + "%";
	}
	function showProgressBar(loc2)
	{
		if(this["\x1e\n\x1c"]._visible != loc2)
		{
			this["\x1e\n\x1c"]._visible = loc2;
		}
	}
	function moveProgressBar(loc2)
	{
	}
	function showWaitBar(loc2)
	{
		if(loc2)
		{
			this._mcWaitBar = this.attachMovie("GrayWaitBar","_mcWaitBar",1000,{_x:this["\x1e\n\x1c"]._x + this["\x1e\n\x1c"]["\x0b\x16"]._x,_y:this["\x1e\n\x1c"]._y + this["\x1e\n\x1c"]["\x0b\x16"]._y});
			this._mcWaitBar["\x1e\f\x1a"].text = "Waiting";
		}
		else
		{
			this._mcWaitBar.removeMovieClip();
		}
		if(loc2)
		{
			this.showProgressBar(false);
		}
	}
	function setTotalBarValue(loc2, loc3)
	{
		this.showTotalBar(true);
		if(loc2 > loc3)
		{
			loc2 = loc3;
		}
		this["\x1e\n\x1b"]["\x0b\x17"]._width = loc2 / loc3 * 100;
		this["\x1e\n\x1b"]["\x1e\f\x19"].text = Math.floor(Number(this["\x1e\n\x1b"]["\x0b\x17"]._width)) + "%";
	}
	function showTotalBar(loc2)
	{
		if(loc2)
		{
			var loc3 = 10079232;
			var loc4 = (loc3 & 16711680) >> 16;
			var loc5 = (loc3 & 65280) >> 8;
			var loc6 = loc3 & 255;
			var loc7 = new Color(this["\x1e\n\x1b"]["\x0b\x17"]);
			var loc8 = new Object();
			loc8 = {ra:"0",rb:loc4,ga:"0",gb:loc5,ba:"0",bb:loc6,aa:"100",ab:"0"};
			loc7.setTransform(loc8);
			this["\x1e\n\x1d"]._visible = true;
			this["\x1e\n\x1b"]._visible = true;
		}
		else
		{
			this["\x1e\n\x1b"]._visible = false;
			this["\x1e\n\x1d"]._visible = false;
		}
	}
	function showConfigurationChoice(loc2)
	{
		this["\x1e\x0b\x05"]._visible = loc2;
		this["\x1e\x0b\x03"]._visible = loc2;
		this["\x1e\x0b\x04"]._visible = loc2;
		this["\x1e\x0b\x02"]._visible = loc2;
		this["\x1e\x0b\x0b"]._visible = loc2;
	}
	function showNextButton(loc2)
	{
		this._btnNext._visible = loc2;
	}
	function showShowLogsButton(loc2)
	{
		this["\x1e\x0b\t"]._visible = loc2;
	}
	function showContinueButton(loc2)
	{
		this._btnContinue._visible = loc2;
	}
	function showClearCacheButton(loc2)
	{
		this._btnClearCache._visible = loc2;
	}
	function showCopyLogsButton(loc2)
	{
		this["\x1e\x0b\n"]._visible = loc2;
	}
	function showMainLogger(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = !this["\x1e\x0b\b"]._visible;
		}
		this["\x1e\x0b\b"]._visible = loc2;
	}
	function nonCriticalError(loc2, loc3)
	{
		this.logOrange(loc3 + "<b>" + this.getText("WARNING") + "</b> : " + loc2);
		this._bNonCriticalError = true;
	}
	function criticalError(loc2, loc3, loc4, loc5, loc6)
	{
		var loc7 = this.ERRORS[loc2];
		this.ERRORS.current = loc2;
		this.ERRORS.from = loc6;
		var loc8 = this.replaceText(loc7[_global.CONFIG.language],loc5);
		if(loc8 == undefined || loc8.length == 0)
		{
			loc8 = this.replaceText(loc7.fr,loc5);
		}
		this["\x1e\x0b\x07"].log("<b>" + this.getText("ERROR") + "</b> : " + loc8,"#FF0000","#DD0000");
		var loc9 = "<u><a href=\'" + loc7["link" + _global.CONFIG.language] + "\' target=\'_blank\'>" + this.getText("LINK_HELP") + "</a></u>";
		this["\x1e\x0b\x07"].log(loc9,"#FF0000","#DD0000");
		this.addToSaveLog(loc3 + "<b>" + this.getText("ERROR") + "</b> : " + loc8);
		this.showCopyLogsButton(true);
		this.showShowLogsButton(true);
		this.showContinueButton(true);
		if(loc4)
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
	function launchBannerAnim(loc2)
	{
		if(!this._bBannerDisplay)
		{
			this.showBanner(true);
		}
		if(loc2)
		{
			this._mcBanner.playAll();
		}
		else
		{
			this._mcBanner.stopAll();
		}
	}
	function showBanner(loc2)
	{
		if(!this._bLoadingBannersFilesLoaded)
		{
			this.addLoadingBannersFiles(loc2);
		}
		else
		{
			var loc3 = loc2 != undefined?loc2:!this._bBannerDisplay;
			if(loc3)
			{
				if(this._bBannerDisplay)
				{
					return undefined;
				}
				var loc4 = "";
				if(this._aLoadingBannersFiles.length > 0)
				{
					var loc6 = Math.floor(Math.random() * (this._aLoadingBannersFiles.length + 1));
					if(loc6 < this._aLoadingBannersFiles.length)
					{
						var loc7 = this._aLoadingBannersFiles[loc6];
						var loc5 = this.createEmptyMovieClip("_mcBanner",this.getNextHighestDepth());
						eval("\x1e\x19\x13").utils.Bitmap.loadBitmapSmoothed(dofus.Constants.LOADING_BANNERS_PATH + loc7,loc5);
					}
				}
				var loc8 = "";
				if(!loc5)
				{
					loc5 = this.attachMovie("LoadingBanner_" + _global.CONFIG.language,"_mcBanner",this.getNextHighestDepth(),this["\x1e\x0b\x01"]);
				}
				if(!loc5)
				{
					loc5 = this.attachMovie("LoadingBanner_" + loc8,"_mcBanner",this.getNextHighestDepth(),this["\x1e\x0b\x01"]);
				}
				if(!loc5)
				{
					loc5 = this.attachMovie("LoadingBanner","_mcBanner",this.getNextHighestDepth(),this["\x1e\x0b\x01"]);
				}
				loc5.cacheAsBitmap = true;
				loc5.swapDepths(this["\x1e\x0b\x01"]);
			}
			else
			{
				if(!this._bBannerDisplay)
				{
					return undefined;
				}
				this._mcBanner.swapDepths(this["\x1e\x0b\x01"]);
				this._mcBanner.removeMovieClip();
			}
			this._bBannerDisplay = loc3;
		}
	}
	function copyAndOrganizeDataServerList()
	{
		var loc2 = _global.CONFIG.dataServers.slice(0);
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			var loc4 = loc2[loc3];
			if(loc4.nPriority == undefined || _global.isNaN(loc4.nPriority))
			{
				loc4.nPriority = 0;
			}
			var loc5 = loc4.priority;
			loc4.rand = random(99999);
			loc3 = loc3 + 1;
		}
		loc2.sortOn(["priority","rand"],Array.DESCENDING);
		var loc6 = 0;
		while(loc6 < loc2.length)
		{
			loc6 = loc6 + 1;
		}
		return loc2;
	}
	function checkOccurences()
	{
		var loc2 = _global.API.lang.getConfigText("MAXIMUM_CLIENT_OCCURENCES");
		if(loc2 == undefined || (_global.isNaN(loc2) || loc2 < 1))
		{
			return true;
		}
		var loc3 = this.getOccurencesSharedObject().data.occ;
		var loc4 = new Array();
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			if(loc3[loc5].tick + dofus.Constants.MAX_OCCURENCE_DELAY > new Date().getTime())
			{
				loc4.push(loc3[loc5]);
			}
			loc5 = loc5 + 1;
		}
		var loc6 = loc4.length;
		if(!_global.API.datacenter.Player.isAuthorized && loc6 + 1 > loc2)
		{
			this.criticalError("TOO_MANY_OCCURENCES",this.TABULATION,false);
			return false;
		}
		this._nOccurenceId = Math.round(Math.random() * 1000);
		loc4.push({id:this._nOccurenceId,tick:new Date().getTime()});
		this.getOccurencesSharedObject().data.occ = loc4;
		_global.setInterval(this,"refreshOccurenceTick",dofus.Constants.OCCURENCE_REFRESH);
		return true;
	}
	function refreshOccurenceTick()
	{
		var loc2 = this.getOccurencesSharedObject().data.occ;
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			if(loc2[loc3].id == this._nOccurenceId)
			{
				loc2[loc3].tick = new Date().getTime();
				break;
			}
			loc3 = loc3 + 1;
		}
		this.getOccurencesSharedObject().data.occ = loc2;
	}
	function checkFlashPlayer()
	{
		var loc2 = System.capabilities.version;
		var loc3 = Number(loc2.split(" ")[1].split(",")[0]);
		var loc4 = System.capabilities.playerType.length != 0?" (" + System.capabilities.playerType + ")":" ";
		this.log(this.TABULATION + "Flash player" + loc4 + " <b>" + loc2 + "</b>");
		if(_root.electron != undefined)
		{
			var loc5 = String(flash.external.ExternalInterface.call("getElectronVersion"));
			var loc6 = String(flash.external.ExternalInterface.call("getNodejsVersion"));
			this.log(this.TABULATION + "Electron <b>" + loc5 + "</b> (Node.js <b>" + loc6 + "</b>)");
		}
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'checkFlashPlayer;" + loc3 + "\')");
			this.getURL("JavaScript:WriteLog(\'versionDate;" + dofus.Constants.VERSIONDATE + "\')");
		}
		if(loc3 >= 8)
		{
			var loc7 = System.security.sandboxType;
			if(loc7 != "localTrusted" && loc7 != "remote")
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
	function click(loc2)
	{
		switch(loc2.target)
		{
			case this["\x1e\x0b\x0b"]:
				this.chooseConfiguration(this["\x1e\x0b\x03"].selectedItem.data,this["\x1e\x0b\x02"].selectedItem.data,true);
				break;
			case this._btnClearCache:
				this.clearCache();
				this.reboot();
				break;
			case this["\x1e\x0b\n"]:
				System.setClipboard(this._sLogs);
				break;
			default:
				switch(null)
				{
					case this["\x1e\x0b\t"]:
						this.showBanner(false);
						this.showMainLogger();
						break;
					case this._btnContinue:
						switch(this.ERRORS.current)
						{
							case "CHECK_LAST_VERSION_FAILED":
								var loc3 = new LoadVars();
								loc3.f = "";
								this.onCheckLanguage(true,loc3,"","");
								break;
							case "CHECK_LAST_VERSION_FAILED":
								var loc4 = new LoadVars();
								loc4.f = "";
								this.onCheckLanguage(true,loc4,"","");
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
	function itemSelected(loc2)
	{
		switch(loc2.target)
		{
			case this["\x1e\x0b\x03"]:
				this.selectConfiguration();
				break;
			case this["\x1e\x0b\x02"]:
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
	function setDisplayStyle(loc2)
	{
		if(System.capabilities.playerType == "PlugIn" && (!_global.CONFIG.isStreaming && _root.electron == undefined))
		{
			this.getURL("javascript:setFlashStyle(\'flashid\', \'" + loc2 + "\');");
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
		var loc2 = 0;
		while(loc2 < dofus.Constants.MODULES_LIST.length)
		{
			this._mclLoader.unloadClip(_global["MODULE_" + dofus.Constants.MODULES_LIST[loc2][4]]);
			loc2 = loc2 + 1;
		}
		this.initLoader(_root);
	}
	function clearCache()
	{
		ank.utils.SharedObjectFix.getLocal(dofus.Constants.LANG_SHAREDOBJECT_NAME).clear();
		ank.utils.SharedObjectFix.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME).clear();
	}
	function showLoader(loc2, loc3)
	{
		this._visible = loc2;
	}
	function showBasicInformations(loc2)
	{
		this._currentLogger = this["\x1e\x0b\x06"];
		this.logTitle(this.getText("STARTING"));
		this.log(this.TABULATION + "Dofus Retro <b>v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + "</b> " + (dofus.Constants.BETAVERSION <= 0?"":"(<font color=\"#FF0000\"><i><b>BETA " + dofus.Constants.BETAVERSION + "</b></i></font>) ") + "(<b>" + dofus.Constants.VERSIONDATE + "</b>" + (!dofus.Constants.ALPHA?"":" <font color=\"#00FF00\"><i><b>ALPHA BUILD</b></i></font>") + ")");
		if(!this.checkFlashPlayer())
		{
			this.showShowLogsButton(false);
			this.showCopyLogsButton(false);
			return undefined;
		}
		this.checkCacheVersion();
		this._currentLogger = this["\x1e\x0b\b"];
		if(loc2)
		{
			this.addToQueue({object:this,method:this.loadConfig});
		}
	}
	function loadConfig()
	{
		this.showLoader(true);
		this.moveProgressBar(0);
		this.logTitle(this.getText("LOADING_CONFIG_FILE"));
		var loc2 = new XML();
		var loader = this;
		loc2.ignoreWhite = true;
		loc2.onLoad = function(loc2)
		{
			loader.onConfigLoaded(loc2,this);
		};
		this.showWaitBar(true);
		loc2.load(dofus.Constants.CONFIG_XML_FILE);
	}
	function onConfigLoaded(§\x15\x10§, xDoc)
	{
		this.showWaitBar(false);
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'onConfigLoaded;" + loc2 + "\')");
		}
		if(loc2)
		{
			this.setTotalBarValue(50,100);
			var loc4 = xDoc.firstChild.firstChild;
			if(xDoc.childNodes.length == 0 || loc4 == null)
			{
				this.criticalError("CORRUPT_CONFIG_FILE",this.TABULATION,false);
				return undefined;
			}
			_global.CONFIG.cacheAsBitmap = new Array();
			var loc5 = new ank.utils.();
			var loc6 = false;
			while(loc4 != null)
			{
				loop4:
				switch(loc4.nodeName)
				{
					case "delay":
						_global.CONFIG.delay = loc4.attributes.value;
						break;
					case "rdelay":
						_global.CONFIG.rdelay = loc4.attributes.value;
						break;
					case "rcount":
						_global.CONFIG.rcount = loc4.attributes.value;
						break;
					case "hardcore":
						_global.CONFIG.onlyHardcore = true;
						break;
					default:
						switch(null)
						{
							case "streaming":
								_global.CONFIG.isStreaming = true;
								if(loc4.attributes.method)
								{
									_global.CONFIG.streamingMethod = loc4.attributes.method;
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
								var loc7 = loc4.attributes.name;
								var loc8 = loc4.attributes.type;
								if(loc7 != undefined && (dofus.Constants.TEST != true && loc8 != "test" || dofus.Constants.TEST == true && loc8 == "test"))
								{
									var loc9 = new Object();
									loc9.name = loc7;
									loc9.debug = loc4.attributes.boo == "1";
									loc9.debugRequests = loc4.attributes.debugrequests == "1" || loc4.attributes.debugrequests == "2";
									loc9.logRequests = loc4.attributes.debugrequests == "2";
									loc9.connexionServers = new ank.utils.();
									loc9.dataServers = new Array();
									var loc10 = loc4.firstChild;
									while(loc10 != null)
									{
										if((loc0 = loc10.nodeName) !== "dataserver")
										{
											if(loc0 !== "connserver")
											{
												this.nonCriticalError(this.getText("UNKNOWN_TYPE_NODE") + " (" + loc4.nodeName + ")",this.TABULATION);
											}
											else
											{
												var loc14 = loc10.attributes.name;
												var loc15 = loc10.attributes.ip;
												var loc16 = loc10.attributes.port;
												if(loc14 != undefined && (loc15 != "" && loc16 != undefined))
												{
													loc9.connexionServers.push({label:loc14,data:{name:loc14,ip:loc15,port:loc16}});
												}
											}
										}
										else
										{
											var loc11 = loc10.attributes.url;
											var loc12 = loc10.attributes.type;
											var loc13 = Number(loc10.attributes.priority);
											if(loc11 != undefined && loc11 != "")
											{
												loc9.dataServers.push({url:loc11,type:loc12,priority:loc13});
												System.security.allowDomain(loc11);
											}
										}
										loc10 = loc10.nextSibling;
									}
									if(loc9.dataServers.length > 0)
									{
										loc5.push({label:loc9.name,data:loc9});
									}
								}
								break loop4;
							case "languages":
								_global.CONFIG.xmlLanguages = loc4.attributes.value.split(",");
								_global.CONFIG.skipLanguageVerification = loc4.attributes.skipcheck == "true" || loc4.attributes.skipcheck == "1";
								break loop4;
							default:
								switch(null)
								{
									case "cacheasbitmap":
										var loc17 = loc4.firstChild;
										while(loc17 != null)
										{
											var loc18 = loc17.attributes.element;
											var loc19 = loc17.attributes.value == "true";
											_global.CONFIG.cacheAsBitmap[loc18] = loc19;
											loc17 = loc17.nextSibling;
										}
										break loop4;
									case "servers":
										var loc20 = loc4.firstChild;
										_global.CONFIG.customServersIP = new Array();
										while(loc20 != null)
										{
											var loc21 = loc20.attributes.id;
											var loc22 = loc20.attributes.ip;
											var loc23 = loc20.attributes.port;
											_global.CONFIG.customServersIP[loc21] = {ip:loc22,port:loc23};
											loc20 = loc20.nextSibling;
										}
										break loop4;
									default:
										this.nonCriticalError(this.getText("UNKNOWN_TYPE_NODE") + " (" + loc4.nodeName + ")",this.TABULATION);
								}
						}
				}
				loc4 = loc4.nextSibling;
			}
			if(loc5.length == 0)
			{
				this.criticalError("CORRUPT_CONFIG_FILE",this.TABULATION,false);
				return undefined;
			}
			this.log(this.TABULATION + this.getText("CONFIG_FILE_LOADED"));
			this.askForConfiguration(loc5);
		}
		this.criticalError("NO_CONFIG_FILE",this.TABULATION,false);
		return undefined;
	}
	function askForConfiguration(loc2)
	{
		if(loc2.length == 1 && loc2[0].data.connexionServers.length == 0)
		{
			this.chooseConfiguration(loc2[0].data,undefined,false);
		}
		else
		{
			this.logTitle(this.getText("CHOOSE_CONFIGURATION"));
			this["\x1e\x0b\x03"].dataProvider = loc2;
			var loc3 = this.getOptionsSharedObject().data.loaderLastConfName;
			if(loc3 != undefined)
			{
				var loc4 = 0;
				while(loc4 < loc2.length)
				{
					if(loc2[loc4].data.name == loc3)
					{
						this["\x1e\x0b\x03"].selectedIndex = loc4;
						break;
					}
					loc4 = loc4 + 1;
				}
			}
			else
			{
				this["\x1e\x0b\x03"].selectedIndex = 0;
			}
			this.selectConfiguration();
			this.showConfigurationChoice(true);
		}
	}
	function selectConfiguration()
	{
		var loc2 = this["\x1e\x0b\x03"].selectedItem.data.connexionServers;
		this["\x1e\x0b\x02"].dataProvider = loc2;
		var loc3 = this.getOptionsSharedObject();
		var loc4 = loc3.data.loaderConf[this["\x1e\x0b\x03"].selectedItem.label];
		if(loc4 != undefined)
		{
			var loc5 = 0;
			while(loc5 < loc2.length)
			{
				if(loc2[loc5].data.name == loc4)
				{
					this["\x1e\x0b\x02"].selectedIndex = loc5;
					break;
				}
				loc5 = loc5 + 1;
			}
		}
		else if(loc2.length > 0)
		{
			this["\x1e\x0b\x02"].selectedIndex = 0;
		}
		loc3.data.loaderLastConfName = this["\x1e\x0b\x03"].selectedItem.label;
		loc3.flush();
		this.selectConnexionServer();
	}
	function selectConnexionServer()
	{
		var loc2 = this.getOptionsSharedObject();
		if(loc2.data.loaderConf == undefined)
		{
			loc2.data.loaderConf = new Object();
		}
		loc2.data.loaderConf[this["\x1e\x0b\x03"].selectedItem.label] = this["\x1e\x0b\x02"].selectedItem.label;
	}
	function chooseConfiguration(loc2, loc3, loc4)
	{
		this.showConfigurationChoice(false);
		if(loc4)
		{
			this.log(this.TABULATION + this.getText("CURRENT_CONFIG",[loc2.name]));
			if(oServer != undefined)
			{
				this.log(this.TABULATION + this.getText("CURRENT_SERVER",[oServer.name]));
			}
		}
		_global.CONFIG.dataServers = loc2.dataServers;
		_global.CONFIG.connexionServer = oServer;
		if(loc2.debug)
		{
			dofus.Constants.DEBUG = true;
			this.logYellow(this.TABULATION + this.getText("DEBUG_MODE"));
		}
		if(loc2.debugRequests)
		{
			dofus.Constants.DEBUG_DATAS = true;
		}
		if(loc2.logRequests)
		{
			dofus.Constants.LOG_DATAS = true;
		}
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
		var loc2 = this.getLangSharedObject().data.VERSIONS.lang;
		_global[dofus.Constants.GLOBAL_SO_LANG_NAME] = this.getLangSharedObject();
		this.log(this.TABULATION + this.getText("CURRENT_LANG_FILE_VERSION",[loc2 != undefined?loc2:"Aucune"]));
		this.log(this.TABULATION + this.getText("CHECK_LAST_VERSION"));
		this._oXtraCurrentVersion.lang = !_global.isNaN(loc2)?Number(loc2):0;
		this.checkLanguageWithNextHost("lang," + loc2);
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
				var loc2 = new LoadVars();
				var loc3 = new Array();
				var loc4 = this._mcLocalFileList.VERSIONS[_global.CONFIG.language];
				for(var i in loc4)
				{
					loc3.push(i + "," + _global.CONFIG.language + "," + loc4[i]);
				}
				loc2.f = loc3.join("|");
				this.onCheckLanguage(true,loc2);
			}
			return undefined;
		}
		var oServer = this._aCurrentDataServers.shift();
		if(oServer.type == "local")
		{
			this.checkLanguageWithNextHost(sFiles);
			return undefined;
		}
		var loc5 = oServer.url + "lang/versions_" + _global.CONFIG.language + ".txt" + "?wtf=" + Math.random();
		var loc6 = new LoadVars();
		var loader = this;
		loc6.onLoad = function(loc2)
		{
			loader.onCheckLanguage(loc2,this,oServer.url,sFiles);
		};
		this.showWaitBar(true);
		loc6.load(loc5,this,"GET");
	}
	function onCheckLanguage(loc2, loc3, loc4, loc5)
	{
		this.showWaitBar(false);
		if(loc2 && loc3.f != undefined)
		{
			this.setTotalBarValue(100,100);
			this._sDistantFileList = loc3.f;
			var loc6 = loc3.f.substr(loc3.f.indexOf("lang,")).split("|")[0].split(",");
			var loc7 = false;
			if(loc3.f != "")
			{
				var loc8 = loc6[2];
				if(_global.CONFIG.language == this.getLangSharedObject().data.LANGUAGE && (this._oXtraCurrentVersion.lang != undefined && loc8 == this._oXtraCurrentVersion.lang))
				{
					loc7 = true;
				}
				else
				{
					this.log(this.TABULATION + this.getText("NEW_LANG_FILE_AVAILABLE",[loc6[2]]));
					if(this._bSkipDistantLoad)
					{
						if(this._oXtraCurrentVersion.lang == 0)
						{
							loc8 = this._mcLocalFileList.VERSIONS[_global.CONFIG.language].lang;
						}
					}
					this.updateLanguage(loc6[2]);
				}
			}
			else
			{
				loc7 = true;
			}
			if(loc7)
			{
				this.log(this.TABULATION + this.getText("NO_NEW_VERSION_AVAILABLE"));
				this.loadModules();
			}
		}
		else
		{
			this.nonCriticalError(this.getText("IMPOSSIBLE_TO_JOIN_SERVER",[loc4]),this.TABULATION + this.TABULATION);
			this.checkLanguageWithNextHost(loc5);
		}
	}
	function updateLanguage(loc2)
	{
		this._bUpdate = true;
		this.showWaitBar(true);
		var loc3 = new dofus.utils.();
		loc3.addListener(this);
		loc3.load(this.copyAndOrganizeDataServerList(),"lang/swf/lang_" + _global.CONFIG.language + "_" + loc2 + ".swf",this._mcContainer,dofus.Constants.LANG_SHAREDOBJECT_NAME,"lang",_global.CONFIG.language);
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
		var loc2 = this._aCurrentModule[0];
		var loc3 = this._aCurrentModule[1];
		var loc4 = this._aCurrentModule[2];
		var loc5 = this._aCurrentModule[4];
		this._mcCurrentModule = this._mcModules.createEmptyMovieClip("mc" + loc5,this._mcModules.getNextHighestDepth());
		this._timedProgress = _global.setInterval(this.onTimedProgress,1000,this,this._mclLoader,this._mcCurrentModule);
		this._mclLoader.loadClip(loc3,this._mcCurrentModule);
	}
	function onCoreLoaded(loc2)
	{
		if(_global.CONFIG.isStreaming)
		{
			this._bJsTimer = false;
			this.getURL("javascript:stopTimer()");
		}
		if((this._bNonCriticalError || this._bUpdate) && dofus.Constants.DEBUG)
		{
			this.showNextButton(true);
			this.showCopyLogsButton(true);
			this.showShowLogsButton(true);
		}
		else
		{
			this.initCore(loc2);
		}
	}
	function initCore(loc2)
	{
		Key.removeListener(this);
		if((var loc3 = dofus.DofusCore.getInstance()) == undefined)
		{
			loc3 = new dofus.(loc2);
			if(Key.isDown(Key.SHIFT))
			{
				Stage.scaleMode = "exactFit";
			}
		}
		loc3.initStart();
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
		var loc2 = this._aCurrentDataServers.shift();
		var sURL = loc2.url + sFiles;
		var loader = this;
		var loc3 = new MovieClipLoader();
		var loc4 = new Object();
		loc4.onLoadInit = function(loc2)
		{
			loader.loadLanguage();
			loader._bLocalFileListLoaded = true;
		};
		loc4.onLoadError = function(loc2)
		{
			loader.checkLocalFileListWithNextHost(sFiles);
		};
		loc3.addListener(loc4);
		loc3.loadClip(sURL,this._mcLocalFileList);
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
		var loc2 = dofus.utils.Api.getInstance();
		if(loc2 != undefined)
		{
			loc2.lang.clearSOXtraCache();
		}
		this._aCurrentDataServers = this.copyAndOrganizeDataServerList();
		var loc3 = this.getXtraSharedObject().data.VERSIONS;
		var loc4 = _global.API.lang.getConfigText("XTRA_FILE");
		var loc5 = 0;
		while(loc5 < loc4.length)
		{
			var loc6 = loc4[loc5];
			var loc7 = loc3[loc6] != undefined?loc3[loc6]:0;
			this._oXtraCurrentVersion[loc6] = loc7;
			loc5 = loc5 + 1;
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
			while(this._aXtraList.length > 0)
			{
				this.setTotalBarValue(10 + (90 - 90 / this._nTotalFile * (this._aXtraList.length - 1)),100);
				this._aCurrentXtra = this._aXtraList.shift().split(",");
				if(this._aXtraList.length > 0 && this._aCurrentXtra[2])
				{
					if(!this._bSkipDistantLoad)
					{
						this._oCurrentXtraLoadFile = this._aCurrentXtra;
					}
					var loc2 = this._aCurrentXtra[0];
					var loc3 = this._aCurrentXtra[1];
					var loc4 = this._aCurrentXtra[2];
					if(loc2 == "lang")
					{
						continue;
					}
					this["\x1e\n\x1c"]["\x1e\f\x1a"].text = loc2;
					if(_global.CONFIG.language == this.getLangSharedObject().data.LANGUAGE && Number(loc4) == this._oXtraCurrentVersion[loc2])
					{
						continue;
					}
					if(this._bLocalFileListLoaded)
					{
						if(this._bSkipDistantLoad)
						{
							if(this._oXtraCurrentVersion[loc2] == 0)
							{
								loc4 = this._mcLocalFileList.VERSIONS[_global.CONFIG.language][loc2];
							}
							else
							{
								continue;
							}
						}
					}
					else if(this._bSkipDistantLoad)
					{
						return undefined;
					}
					this._bUpdate = true;
					this._aCurrentXtra[3] = this._aCurrentXtra[0] + "_" + this._aCurrentXtra[1] + "_" + this._aCurrentXtra[2];
					this.log(this.TABULATION + this.getText("UPDATE_FILE",[loc2]));
					this.showWaitBar(true);
					var loc5 = new dofus.utils.();
					loc5.addListener(this);
					if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
					{
						this.getURL("JavaScript:WriteLog(\'updateNextXtra;" + loc2 + "_" + _global.CONFIG.language + "_" + loc4 + "\')");
					}
					loc5.load(this.copyAndOrganizeDataServerList(),"lang/swf/" + loc2 + "_" + _global.CONFIG.language + "_" + loc4 + ".swf",this._mcContainer,dofus.Constants.XTRA_SHAREDOBJECT_NAME,loc2,_global.CONFIG.language,true);
					return undefined;
				}
			}
			this.noMoreXtra();
		}
	}
	function noMoreXtra()
	{
		this.logTitle(this.getText("INIT_END"));
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'XtraLangLoadEnd\')");
		}
		if((this._bNonCriticalError || this._bUpdate) && dofus.Constants.DEBUG)
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
		var loc2 = new Date();
		var loc3 = loc2.getFullYear() + "-" + (loc2.getMonth() + 1) + "-" + loc2.getDate();
		if(!this.getCacheDateSharedObject().data.clearDate)
		{
			this.clearCache();
			this.getCacheDateSharedObject().data.clearDate = loc3;
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
	function onLoadStart(loc2)
	{
		this.showWaitBar(false);
		this.setProgressBarValue(0,100);
	}
	function onTimedProgress(loc2, loc3, loc4)
	{
		var loc5 = loc3.getProgress(loc4);
		loc2.setProgressBarValue(Number(loc5.bytesLoaded),Number(loc5.bytesTotal));
	}
	function onLoadError(§\f\x01§, §\x10\x06§, §\x0e\x04§, oServer)
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
	function onLoadComplete(loc2)
	{
		_global.clearInterval(this._timedProgress);
		if(this._sStep == "MODULE")
		{
			_global["MODULE_" + this._aCurrentModule[4]] = loc2;
		}
	}
	function onLoadInit(§\f\x01§, oServer)
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
			default:
				if(!this.checkCacheVersion())
				{
					return undefined;
				}
				this.loadNextModule();
				break;
			case "XTRA":
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
		}
	}
	function onCorruptFile(§\f\x01§, §\x1e\r\x06§, oServer)
	{
		switch(this._sStep)
		{
			case "LANG":
				this.nonCriticalError(this.getText("CORRUPT_FILE",["lang",oServer.url,loc3]),this.TABULATION + this.TABULATION);
				break;
			case "XTRA":
				this.nonCriticalError(this.getText("CORRUPT_FILE",[this._aCurrentXtra[3],oServer.url,loc3]),this.TABULATION + this.TABULATION);
		}
	}
	function onCantWrite(loc2)
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
	function onAllLoadFailed(loc2)
	{
		this.showProgressBar(false);
		this.showWaitBar(false);
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			this.getURL("JavaScript:WriteLog(\'onAllLoadFailed;" + this._sStep + "\')");
		}
		if((var loc0 = this._sStep) !== "LANG")
		{
			if(loc0 === "XTRA")
			{
				this._bSkipDistantLoad = true;
				this.nonCriticalError("CANT_UPDATE_FILE",this.TABULATION + this.TABULATION,true,[this._aCurrentXtra[3]]);
				this.updateNextXtra();
			}
		}
		else
		{
			if(!this._bSkipDistantLoad)
			{
				this.criticalError("CANT_UPDATE_FILE",this.TABULATION + this.TABULATION,true,["lang"]);
			}
			else
			{
				this.nonCriticalError("CANT_UPDATE_FILE",this.TABULATION + this.TABULATION,true,["lang"]);
			}
			this._bSkipDistantLoad = true;
		}
	}
	function onCoreDisplayed()
	{
		this.launchBannerAnim(false);
		this.showBanner(false);
		this.showLoader(false);
	}
}
