class ank.gapi.styles.DefaultStylePackage extends Object
{
   static var Label = {labelfont:"_sans",labelembedfonts:false,labelalign:"center",labelsize:10,labelcolor:16777215,labelbold:true,labelitalic:false};
   static var LabelBlack = {labelfont:"_sans",labelembedfonts:false,labelalign:"center",labelsize:10,labelcolor:0,labelbold:true,labelitalic:false};
   static var TextInput = {labelfont:"_sans",labelembedfonts:false,labelalign:"left",labelsize:10,labelcolor:0,labelbold:true,labelitalic:false};
   static var Button = {labelupstyle:"Label",labeloverstyle:"LabelBlack",labeldownstyle:"Label",bgcolor:16736512,bordercolor:5128232,highlightcolor:15508082,bgdowncolor:5327420,borderdowncolor:13421772,highlightdowncolor:11509893};
   static var ScrollBar = {sbarrowbgcolor:12499352,sbarrowcolor:5327420,sbthumbcolor:5327420,sbtrackcolor:-1};
   static var TextArea = {font:"Font1",embedfonts:true,align:"left",size:10,bold:false,italic:false,scrollbarstyle:"ScrollBar"};
   static var ChatArea = {font:"_sans",embedfonts:false,align:"left",size:10,bold:false,italic:false,scrollbarstyle:"ScrollBar"};
   static var CellRenderer = {defaultstyle:"LabelBlack",leftstyle:"LabelBlack",rightstyle:"LabelBlack"};
   static var List = {cellrendererstyle:"CellRenderer",scrollbarstyle:"ScrollBar",cellbgcolor:[16772812,15654331],cellselectedcolor:16750865,cellovercolor:13421704};
   static var ContainerGrid = {containerbackground:"DefaultBackground",containerhighlight:"DefaultHighlight",scrollbarstyle:"ScrollBar",labelstyle:"Label"};
   static var LookSelectorGrid = {containerbackground:"LookSelectorBackground",containerhighlight:"LookSelectorHighlight",scrollbarstyle:"ScrollBar",labelstyle:"Label"};
   static var Container = {labelstyle:"Label"};
   static var Window = {titlestyle:"Label",cornerradius:{tl:13,tr:13,br:13,bl:13},bordercolor:16777215,borderwidth:3,backgroundcolor:14012330,titlecolor:5327420,titleheight:22};
   static var ProgressBar = {bgcolor:5327420,upcolor:16737792};
   static var ToolTip = {font:"_sans",embedfonts:false,size:10,color:16777215,bold:false,italic:false,bgcolor:0,bgalpha:70};
   static var PopupMenu = {bordercolor:16777215,backgroundcolor:5327420,foregroundcolor:14012330,itembgcolor:5327420,itemovercolor:16737792,itemstaticbgcolor:5327420,labelstaticstyle:"Label",labelenabledstyle:"Label",labeldisabledstyle:"Label"};
   static var VolumeSlider = {oncolor:16777215,offcolor:13421772};
   static var CircleChrono = {bgcolor:16777215};
   static var StylizedRectangle = {cornerradius:{tl:0,tr:13,br:0,bl:0},bgcolor:16777215};
   static var MapNavigator = {buttonstyle:"Button",bordercolor:12104079,gridcolor:12104079,bgcolor:15066553};
   static var DataGrid = {labelstyle:"Label",liststyle:"List",titlebgcolor:"0x22FF00"};
   static var ConsoleLogger = {font:"_sans",embedfonts:false,size:12};
   static var Fps = {labelstyle:"Label",backalpha:50,backcolor:16711680};
   static var ComboBox = {labelstyle:"LabelBlack",buttonstyle:"Button",liststyle:"List",listbordercolor:5128232,bgcolor:16777215,bordercolor:5128232,highlightcolor:13421772};
   function DefaultStylePackage()
   {
      super();
   }
}
