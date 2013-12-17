CMCXmlParser._FilePathToXmlStringMap.Add(
	'Skin',
	'<?xml version=\"1.0\" encoding=\"utf-8\"?>' +
	'<!-- ' +
	'FILE:         _HP_WebHelpSkin_Experience.flskn' +
	'DESCRIPTION:  Skin for WebHelp without Index for HP Software Help' +
	'MODIFIED:     July 29, 2012' +
	'VERSION:      1.0' +
	'-->' +
	'<CatapultSkin Version=\"1\" Title=\"\" Top=\"0px\" Left=\"0px\" Bottom=\"0px\" Right=\"0px\" Width=\"860px\" Height=\"700px\" Tabs=\"TOC,Search,Favorites\" AutoSyncTOC=\"True\" Anchors=\"Right,Top\" BrowserSetup=\"Resizable\" UseDefaultBrowserSetup=\"True\" DefaultTab=\"TOC\" UseBrowserDefaultSize=\"True\" NavigationLinkTop=\"true\">' +
	'    <!-- saved from url=(0014)about:internet -->' +
	'    <Toc LinesBetweenItems=\"True\" LinesFromRoot=\"False\" SingleClick=\"False\" PlusMinusSquares=\"False\" AlwaysShowSelection=\"False\" UseFolderIcons=\"False\" ImageListWidth=\"16\" BinaryStorage=\"False\" />' +
	'    <Stylesheet Link=\"Stylesheet.xml\">' +
	'    </Stylesheet>' +
	'    <Toolbar EnableCustomLayout=\"true\" Buttons=\"Back|Forward|PreviousTopic|NextTopic|Print|AddTopicToFavorites|ToggleNavigationPane\" ExcludeAccordionTitle=\"true\">' +
	'        <Script>_HP_banner_format();' +
	'_HP_banner_delaySetText();' +
	'_HP_banner_delaySetButtonStyles();' +
	'' +
	'function _HP_banner_format()' +
	'{' +
	'	var toolbarTable = document.getElementsByTagName(\'TABLE\')[0];' +
	'	var toolbarTd = document.getElementById(\'ToolbarButtons\');' +
	'	var productNameTd = document.createElement(\'TD\');' +
	'	var logoImgTd = document.createElement(\'TD\');' +
	'	var logoImg = document.createElement(\'IMG\');' +
	'	' +
	'	document.styleSheets[0].disabled = true;' +
	'' +
	'	document.body.style.border = \"none\";' +
	'	document.body.style.margin = \"0\";' +
	'	document.body.style.padding = \"0\"; ' +
	'' +
	'	toolbarTable.style.width = \"100%\";' +
	'	toolbarTable.style.backgroundColor = \"#ffffff\";' +
	'	toolbarTable.style.cellPadding = \"0\";' +
	'	toolbarTd.setAttribute(\'align\',\'right\');' +
	'	toolbarTd.style.backgroundColor = \"#ffffff\";' +
	'	toolbarTd.style.cellSpacing =\"0\";' +
	'	toolbarTd.style.margin = \"0\";' +
	'	productNameTd.setAttribute(\'id\', \'productNameTd\');' +
	'	productNameTd.style.fontFamily = \"arial, geneva, sans-serif\";' +
	'	productNameTd.style.color = \"#333333\";' +
	'	productNameTd.style.fontWeight = \"bold\";' +
	'	productNameTd.style.fontSize = \"20px\";' +
	'	productNameTd.style.padding = \"0px 0px 0px 0px\";' +
	'	productNameTd.style.margin = \"0\";' +
	'	productNameTd.style.lineHeight = \"15px\";' +
	'	productNameTd.style.verticalAlign = \"middle\";' +
	'	productNameTd.style.whiteSpace = \"nowrap\";' +
	'	logoImg.src = \"../Content/Resources/MasterPages/_HP_logo_experience.png\";' +
	'	logoImg.style.verticalAlign = \"middle\";' +
	'	logoImg.style.marginRight = \"5px\";' +
	'	logoImg.style.marginLeft = \"5px\";' +
	'	logoImgTd.style.width = \"50px\";' +
	'	logoImgTd.appendChild(logoImg);' +
	'	toolbarTd.parentNode.insertBefore(logoImgTd, toolbarTd);' +
	'	toolbarTd.parentNode.insertBefore(productNameTd, toolbarTd);' +
	'}' +
	'' +
	'function _HP_banner_delaySetText()' +
	'{' +
	'	var topicLocation = parent.body.document.location.toString();' +
	'	var topicReady = parent.body.document.readyState.toString();' +
	'	if ((topicLocation.search(/Blank.htm$/) != -1) || (topicReady.search(/complete/i) == -1))' +
	'		setTimeout(\"_HP_banner_delaySetText()\", 250);' +
	'	else' +
	'		_HP_banner_setText();' +
	'}' +
	'' +
	'function _HP_banner_setText()' +
	'{' +
	'	var feedbackVariables = parent.body.document.getElementById(\"hp-feedback-variables\");' +
	'	var productName = feedbackVariables.getAttribute(\'productname\');' +
	'	var line1 = feedbackVariables.getAttribute(\'skinline1\');' +
	'	var line2 = feedbackVariables.getAttribute(\'skinline2\');' +
	'	var productNameTd = document.getElementById(\'productNameTd\');' +
	'' +
	'	parent.document.title = productName;' +
	'	' +
	'	if (line2.length == 0) ' +
	'		productNameTd.appendChild(document.createTextNode(line1));' +
	'	else {' +
	'		productNameTd.style.fontSize = \"12px\";' +
	'		productNameTd.style.lineHeight = \"14px\";' +
	'		productNameTd.appendChild(document.createTextNode(line1));' +
	'		productNameTd.appendChild(document.createElement(\'BR\'));' +
	'		productNameTd.appendChild(document.createTextNode(line2));' +
	'	}' +
	'}' +
	'' +
	'' +
	'function _HP_banner_delaySetButtonStyles()' +
	'{' +
	'	if (!gInit) {' +
	'		setTimeout(\"_HP_banner_delaySetButtonStyles()\", 10);' +
	'	}' +
	'	else' +
	'		_HP_banner_setButtonStyles();' +
	'}' +
	'' +
	'function _HP_banner_setButtonStyles () {' +
	'	var buttons = document.getElementsByTagName(\'button\');' +
	'	for (var i=0; i &lt; buttons.length; i++)' +
	'	{' +
	'		buttons[i].style.backgroundColor = \"#ffffff\";' +
	'		buttons[i].style.border = \"none\";' +
	'		buttons[i].style.margin = \"0\";' +
	'		buttons[i].style.padding =\"0\";' +
	'		buttons[i].style.width = \"100%\";' +
	'		buttons[i].style.height = \"100%\";' +
	'	}' +
	'}</Script>' +
	'    </Toolbar>' +
	'    <WebHelpOptions NavigationPaneWidth=\"225\" VisibleAccordionItemCount=\"3\" NavigationPanePosition=\"Left\" HideNavigationOnStartup=\"False\" />' +
	'    <TopicToolbar EnableCustomLayout=\"true\" Buttons=\"\" />' +
	'</CatapultSkin>'
);
