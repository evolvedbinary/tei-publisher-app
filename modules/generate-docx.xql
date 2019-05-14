xquery version "3.1";

module namespace gen="http://teipublisher.com/xquery/docx-generate";
import module namespace pm-config="http://www.tei-c.org/tei-simple/pm-config" at "pm-config.xql";

declare function gen:generate($doc as document-node(), $config as map(*)) {
    gen:content-types(),
    gen:properties-core(),
    gen:properties-app(),
    gen:relationships(),
    gen:websettings(),
    gen:settings(),
    (: gen:font-table(), :)
    gen:styles(),
    (: gen:theme(), :)
    gen:document($doc, $config),
    gen:rels()
};

declare function gen:document($doc as document-node(), $config as map(*)) {
    <entry name="word/document.xml" type="text" method="store">
        <w:document xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:o="urn:schemas-microsoft-com:office:office"
        xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
        xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
        xmlns:v="urn:schemas-microsoft-com:vml"
        xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
        xmlns:w10="urn:schemas-microsoft-com:office:word"
        xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
        xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">
            <w:body>
                { $pm-config:docx-transform($doc, map { "root": $doc }, $config?odd) }
            </w:body>
        </w:document>
    </entry>
};

declare function gen:rels() {
    <entry name="_rels/.rels" type="text" method="store">
        <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
            <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"
                          Target="word/document.xml"/>
        </Relationships>
    </entry>
};



declare function gen:content-types() {
    <entry name="[Content_Types].xml" type="text" method="store">
        <Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
            <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
            <Default Extension="xml" ContentType="application/xml"/>
            <Override PartName="/word/document.xml"
                ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
            <Override PartName="/word/styles.xml"
                ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
            <Override PartName="/docProps/app.xml"
                ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>
            <Override PartName="/word/settings.xml"
                ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml"/>
            <Override PartName="/word/theme/theme1.xml"
                ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>
            <Override PartName="/word/fontTable.xml"
                ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.fontTable+xml"/>
            <Override PartName="/word/webSettings.xml"
                ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.webSettings+xml"/>
            <Override PartName="/docProps/core.xml"
                ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
        </Types>
    </entry>
};

declare function gen:properties-core() {
    <entry name="docProps/core.xml" type="text" method="store">
        <cp:coreProperties
        xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
        xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"
        xmlns:dcmitype="http://purl.org/dc/dcmitype/"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <dc:creator/>
            <cp:lastModifiedBy/>
            <cp:revision>1</cp:revision>
            <dcterms:created xsi:type="dcterms:W3CDTF">2008-06-05T12:01:00Z</dcterms:created>
            <dcterms:modified xsi:type="dcterms:W3CDTF">2008-06-05T12:02:00Z</dcterms:modified>
        </cp:coreProperties>
    </entry>
};

declare function gen:properties-app() {
    <entry name="docProps/app.xml" type="text" method="store">
        <Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties"
        xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
            <Template>Normal.dotm</Template>
            <TotalTime>1</TotalTime>
            <Pages>1</Pages>
            <Words>0</Words>
            <Characters>0</Characters>
            <Application>Microsoft Office Word</Application>
            <DocSecurity>0</DocSecurity>
            <Lines>1</Lines>
            <Paragraphs>1</Paragraphs>
            <ScaleCrop>false</ScaleCrop>
            <Company/>
            <LinksUpToDate>false</LinksUpToDate>
            <CharactersWithSpaces>0</CharactersWithSpaces>
            <SharedDoc>false</SharedDoc>
            <HyperlinksChanged>false</HyperlinksChanged>
            <AppVersion>12.0000</AppVersion>
        </Properties>
    </entry>
};



declare function gen:relationships() {
    <entry name="word/_rels/document.xml.rels" type="text" method="store">
        <Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
            <Relationship Id="rId3"
                Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/webSettings"
                Target="webSettings.xml"/>
            <Relationship Id="rId2"
                Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings"
                Target="settings.xml"/>
            <Relationship Id="rId1"
                Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles"
                Target="styles.xml"/>
            <!--Relationship Id="rId5"
                Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"
                Target="theme/theme1.xml"/>
            <Relationship Id="rId4"
                Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable"
                Target="fontTable.xml"/-->
        </Relationships>
    </entry>
};

declare function gen:websettings() {
    <entry name="word/webSettings.xml" type="text" method="store">
        <w:webSettings xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
            xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
            <w:optimizeForBrowser/>
        </w:webSettings>
    </entry>
};

declare function gen:settings() {
    <entry name="word/settings.xml" type="text" method="store">
        <w:settings xmlns:o="urn:schemas-microsoft-com:office:office"
        xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
        xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
        xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w10="urn:schemas-microsoft-com:office:word"
        xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
        xmlns:sl="http://schemas.openxmlformats.org/schemaLibrary/2006/main">
            <w:zoom w:percent="100"/>
            <w:proofState w:spelling="clean" w:grammar="clean"/>
            <w:defaultTabStop w:val="708"/>
            <w:hyphenationZone w:val="425"/>
            <w:characterSpacingControl w:val="doNotCompress"/>
            <w:compat/>
            <w:rsids>
                <w:rsidRoot w:val="00770EF8"/>
                <w:rsid w:val="007231F9"/>
                <w:rsid w:val="00770EF8"/>
            </w:rsids>
            <m:mathPr>
                <m:mathFont m:val="Cambria Math"/>
                <m:brkBin m:val="before"/>
                <m:brkBinSub m:val="--"/>
                <m:smallFrac m:val="off"/>
                <m:dispDef/>
                <m:lMargin m:val="0"/>
                <m:rMargin m:val="0"/>
                <m:defJc m:val="centerGroup"/>
                <m:wrapIndent m:val="1440"/>
                <m:intLim m:val="subSup"/>
                <m:naryLim m:val="undOvr"/>
            </m:mathPr>
            <w:themeFontLang w:val="ro-RO"/>
            <w:clrSchemeMapping w:bg1="light1" w:t1="dark1" w:bg2="light2" w:t2="dark2" w:accent1="accent1"
                w:accent2="accent2" w:accent3="accent3" w:accent4="accent4" w:accent5="accent5"
                w:accent6="accent6" w:hyperlink="hyperlink" w:followedHyperlink="followedHyperlink"/>
            <w:shapeDefaults>
                <o:shapedefaults v:ext="edit" spidmax="1026"/>
                <o:shapelayout v:ext="edit">
                    <o:idmap v:ext="edit" data="1"/>
                </o:shapelayout>
            </w:shapeDefaults>
            <w:decimalSymbol w:val=","/>
            <w:listSeparator w:val=";"/>
        </w:settings>
    </entry>
};

declare function gen:font-table() {
    <entry name="word/fontTable.xml" type="text" method="store">
        <w:fonts xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
            xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
            <w:font w:name="Calibri">
                <w:panose1 w:val="020F0502020204030204"/>
                <w:charset w:val="EE"/>
                <w:family w:val="swiss"/>
                <w:pitch w:val="variable"/>
                <w:sig w:usb0="A00002EF" w:usb1="4000207B" w:usb2="00000000" w:usb3="00000000"
                    w:csb0="0000009F" w:csb1="00000000"/>
            </w:font>
            <w:font w:name="Times New Roman">
                <w:panose1 w:val="02020603050405020304"/>
                <w:charset w:val="EE"/>
                <w:family w:val="roman"/>
                <w:pitch w:val="variable"/>
                <w:sig w:usb0="E0002AEF" w:usb1="C0007841" w:usb2="00000009" w:usb3="00000000"
                    w:csb0="000001FF" w:csb1="00000000"/>
            </w:font>
            <w:font w:name="Cambria">
                <w:panose1 w:val="02040503050406030204"/>
                <w:charset w:val="EE"/>
                <w:family w:val="roman"/>
                <w:pitch w:val="variable"/>
                <w:sig w:usb0="A00002EF" w:usb1="4000004B" w:usb2="00000000" w:usb3="00000000"
                    w:csb0="0000009F" w:csb1="00000000"/>
            </w:font>
        </w:fonts>
    </entry>
};


declare function gen:styles() {
    <entry name="word/styles.xml" type="text" method="store">
        <w:styles xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
            <w:docDefaults>
                <w:rPrDefault>
                    <w:rPr>
                        <w:rFonts w:asciiTheme="minorHAnsi" w:eastAsiaTheme="minorHAnsi"
                            w:hAnsiTheme="minorHAnsi" w:cstheme="minorBidi"/>
                        <w:sz w:val="22"/>
                        <w:szCs w:val="22"/>
                        <w:lang w:val="ro-RO" w:eastAsia="en-US" w:bidi="ar-SA"/>
                    </w:rPr>
                </w:rPrDefault>
                <w:pPrDefault>
                    <w:pPr>
                        <w:spacing w:after="200" w:line="276" w:lineRule="auto"/>
                    </w:pPr>
                </w:pPrDefault>
            </w:docDefaults>
            <w:latentStyles w:defLockedState="0" w:defUIPriority="99" w:defSemiHidden="1"
                w:defUnhideWhenUsed="1" w:defQFormat="0" w:count="267">
                <w:lsdException w:name="Normal" w:semiHidden="0" w:uiPriority="0" w:unhideWhenUsed="0"
                    w:qFormat="1"/>
                <w:lsdException w:name="heading 1" w:semiHidden="0" w:uiPriority="9" w:unhideWhenUsed="0"
                    w:qFormat="1"/>
                <w:lsdException w:name="heading 2" w:uiPriority="9" w:qFormat="1"/>
                <w:lsdException w:name="heading 3" w:uiPriority="9" w:qFormat="1"/>
                <w:lsdException w:name="heading 4" w:uiPriority="9" w:qFormat="1"/>
                <w:lsdException w:name="heading 5" w:uiPriority="9" w:qFormat="1"/>
                <w:lsdException w:name="heading 6" w:uiPriority="9" w:qFormat="1"/>
                <w:lsdException w:name="heading 7" w:uiPriority="9" w:qFormat="1"/>
                <w:lsdException w:name="heading 8" w:uiPriority="9" w:qFormat="1"/>
                <w:lsdException w:name="heading 9" w:uiPriority="9" w:qFormat="1"/>
                <w:lsdException w:name="toc 1" w:uiPriority="39"/>
                <w:lsdException w:name="toc 2" w:uiPriority="39"/>
                <w:lsdException w:name="toc 3" w:uiPriority="39"/>
                <w:lsdException w:name="toc 4" w:uiPriority="39"/>
                <w:lsdException w:name="toc 5" w:uiPriority="39"/>
                <w:lsdException w:name="toc 6" w:uiPriority="39"/>
                <w:lsdException w:name="toc 7" w:uiPriority="39"/>
                <w:lsdException w:name="toc 8" w:uiPriority="39"/>
                <w:lsdException w:name="toc 9" w:uiPriority="39"/>
                <w:lsdException w:name="caption" w:uiPriority="35" w:qFormat="1"/>
                <w:lsdException w:name="Title" w:semiHidden="0" w:uiPriority="10" w:unhideWhenUsed="0"
                    w:qFormat="1"/>
                <w:lsdException w:name="Default Paragraph Font" w:uiPriority="1"/>
                <w:lsdException w:name="Subtitle" w:semiHidden="0" w:uiPriority="11" w:unhideWhenUsed="0"
                    w:qFormat="1"/>
                <w:lsdException w:name="Strong" w:semiHidden="0" w:uiPriority="22" w:unhideWhenUsed="0"
                    w:qFormat="1"/>
                <w:lsdException w:name="Emphasis" w:semiHidden="0" w:uiPriority="20" w:unhideWhenUsed="0"
                    w:qFormat="1"/>
                <w:lsdException w:name="Table Grid" w:semiHidden="0" w:uiPriority="59" w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Placeholder Text" w:unhideWhenUsed="0"/>
                <w:lsdException w:name="No Spacing" w:semiHidden="0" w:uiPriority="1" w:unhideWhenUsed="0"
                    w:qFormat="1"/>
                <w:lsdException w:name="Light Shading" w:semiHidden="0" w:uiPriority="60"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light List" w:semiHidden="0" w:uiPriority="61" w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Grid" w:semiHidden="0" w:uiPriority="62" w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 1" w:semiHidden="0" w:uiPriority="63"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 2" w:semiHidden="0" w:uiPriority="64"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 1" w:semiHidden="0" w:uiPriority="65"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 2" w:semiHidden="0" w:uiPriority="66"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 1" w:semiHidden="0" w:uiPriority="67"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 2" w:semiHidden="0" w:uiPriority="68"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 3" w:semiHidden="0" w:uiPriority="69"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Dark List" w:semiHidden="0" w:uiPriority="70" w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Shading" w:semiHidden="0" w:uiPriority="71"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful List" w:semiHidden="0" w:uiPriority="72"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Grid" w:semiHidden="0" w:uiPriority="73"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Shading Accent 1" w:semiHidden="0" w:uiPriority="60"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light List Accent 1" w:semiHidden="0" w:uiPriority="61"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Grid Accent 1" w:semiHidden="0" w:uiPriority="62"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 1 Accent 1" w:semiHidden="0" w:uiPriority="63"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 2 Accent 1" w:semiHidden="0" w:uiPriority="64"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 1 Accent 1" w:semiHidden="0" w:uiPriority="65"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Revision" w:unhideWhenUsed="0"/>
                <w:lsdException w:name="List Paragraph" w:semiHidden="0" w:uiPriority="34"
                    w:unhideWhenUsed="0" w:qFormat="1"/>
                <w:lsdException w:name="Quote" w:semiHidden="0" w:uiPriority="29" w:unhideWhenUsed="0"
                    w:qFormat="1"/>
                <w:lsdException w:name="Intense Quote" w:semiHidden="0" w:uiPriority="30"
                    w:unhideWhenUsed="0" w:qFormat="1"/>
                <w:lsdException w:name="Medium List 2 Accent 1" w:semiHidden="0" w:uiPriority="66"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 1 Accent 1" w:semiHidden="0" w:uiPriority="67"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 2 Accent 1" w:semiHidden="0" w:uiPriority="68"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 3 Accent 1" w:semiHidden="0" w:uiPriority="69"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Dark List Accent 1" w:semiHidden="0" w:uiPriority="70"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Shading Accent 1" w:semiHidden="0" w:uiPriority="71"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful List Accent 1" w:semiHidden="0" w:uiPriority="72"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Grid Accent 1" w:semiHidden="0" w:uiPriority="73"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Shading Accent 2" w:semiHidden="0" w:uiPriority="60"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light List Accent 2" w:semiHidden="0" w:uiPriority="61"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Grid Accent 2" w:semiHidden="0" w:uiPriority="62"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 1 Accent 2" w:semiHidden="0" w:uiPriority="63"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 2 Accent 2" w:semiHidden="0" w:uiPriority="64"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 1 Accent 2" w:semiHidden="0" w:uiPriority="65"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 2 Accent 2" w:semiHidden="0" w:uiPriority="66"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 1 Accent 2" w:semiHidden="0" w:uiPriority="67"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 2 Accent 2" w:semiHidden="0" w:uiPriority="68"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 3 Accent 2" w:semiHidden="0" w:uiPriority="69"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Dark List Accent 2" w:semiHidden="0" w:uiPriority="70"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Shading Accent 2" w:semiHidden="0" w:uiPriority="71"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful List Accent 2" w:semiHidden="0" w:uiPriority="72"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Grid Accent 2" w:semiHidden="0" w:uiPriority="73"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Shading Accent 3" w:semiHidden="0" w:uiPriority="60"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light List Accent 3" w:semiHidden="0" w:uiPriority="61"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Grid Accent 3" w:semiHidden="0" w:uiPriority="62"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 1 Accent 3" w:semiHidden="0" w:uiPriority="63"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 2 Accent 3" w:semiHidden="0" w:uiPriority="64"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 1 Accent 3" w:semiHidden="0" w:uiPriority="65"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 2 Accent 3" w:semiHidden="0" w:uiPriority="66"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 1 Accent 3" w:semiHidden="0" w:uiPriority="67"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 2 Accent 3" w:semiHidden="0" w:uiPriority="68"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 3 Accent 3" w:semiHidden="0" w:uiPriority="69"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Dark List Accent 3" w:semiHidden="0" w:uiPriority="70"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Shading Accent 3" w:semiHidden="0" w:uiPriority="71"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful List Accent 3" w:semiHidden="0" w:uiPriority="72"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Grid Accent 3" w:semiHidden="0" w:uiPriority="73"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Shading Accent 4" w:semiHidden="0" w:uiPriority="60"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light List Accent 4" w:semiHidden="0" w:uiPriority="61"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Grid Accent 4" w:semiHidden="0" w:uiPriority="62"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 1 Accent 4" w:semiHidden="0" w:uiPriority="63"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 2 Accent 4" w:semiHidden="0" w:uiPriority="64"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 1 Accent 4" w:semiHidden="0" w:uiPriority="65"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 2 Accent 4" w:semiHidden="0" w:uiPriority="66"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 1 Accent 4" w:semiHidden="0" w:uiPriority="67"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 2 Accent 4" w:semiHidden="0" w:uiPriority="68"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 3 Accent 4" w:semiHidden="0" w:uiPriority="69"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Dark List Accent 4" w:semiHidden="0" w:uiPriority="70"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Shading Accent 4" w:semiHidden="0" w:uiPriority="71"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful List Accent 4" w:semiHidden="0" w:uiPriority="72"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Grid Accent 4" w:semiHidden="0" w:uiPriority="73"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Shading Accent 5" w:semiHidden="0" w:uiPriority="60"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light List Accent 5" w:semiHidden="0" w:uiPriority="61"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Grid Accent 5" w:semiHidden="0" w:uiPriority="62"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 1 Accent 5" w:semiHidden="0" w:uiPriority="63"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 2 Accent 5" w:semiHidden="0" w:uiPriority="64"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 1 Accent 5" w:semiHidden="0" w:uiPriority="65"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 2 Accent 5" w:semiHidden="0" w:uiPriority="66"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 1 Accent 5" w:semiHidden="0" w:uiPriority="67"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 2 Accent 5" w:semiHidden="0" w:uiPriority="68"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 3 Accent 5" w:semiHidden="0" w:uiPriority="69"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Dark List Accent 5" w:semiHidden="0" w:uiPriority="70"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Shading Accent 5" w:semiHidden="0" w:uiPriority="71"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful List Accent 5" w:semiHidden="0" w:uiPriority="72"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Grid Accent 5" w:semiHidden="0" w:uiPriority="73"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Shading Accent 6" w:semiHidden="0" w:uiPriority="60"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light List Accent 6" w:semiHidden="0" w:uiPriority="61"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Light Grid Accent 6" w:semiHidden="0" w:uiPriority="62"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 1 Accent 6" w:semiHidden="0" w:uiPriority="63"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Shading 2 Accent 6" w:semiHidden="0" w:uiPriority="64"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 1 Accent 6" w:semiHidden="0" w:uiPriority="65"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium List 2 Accent 6" w:semiHidden="0" w:uiPriority="66"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 1 Accent 6" w:semiHidden="0" w:uiPriority="67"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 2 Accent 6" w:semiHidden="0" w:uiPriority="68"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Medium Grid 3 Accent 6" w:semiHidden="0" w:uiPriority="69"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Dark List Accent 6" w:semiHidden="0" w:uiPriority="70"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Shading Accent 6" w:semiHidden="0" w:uiPriority="71"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful List Accent 6" w:semiHidden="0" w:uiPriority="72"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Colorful Grid Accent 6" w:semiHidden="0" w:uiPriority="73"
                    w:unhideWhenUsed="0"/>
                <w:lsdException w:name="Subtle Emphasis" w:semiHidden="0" w:uiPriority="19"
                    w:unhideWhenUsed="0" w:qFormat="1"/>
                <w:lsdException w:name="Intense Emphasis" w:semiHidden="0" w:uiPriority="21"
                    w:unhideWhenUsed="0" w:qFormat="1"/>
                <w:lsdException w:name="Subtle Reference" w:semiHidden="0" w:uiPriority="31"
                    w:unhideWhenUsed="0" w:qFormat="1"/>
                <w:lsdException w:name="Intense Reference" w:semiHidden="0" w:uiPriority="32"
                    w:unhideWhenUsed="0" w:qFormat="1"/>
                <w:lsdException w:name="Book Title" w:semiHidden="0" w:uiPriority="33" w:unhideWhenUsed="0"
                    w:qFormat="1"/>
                <w:lsdException w:name="Bibliography" w:uiPriority="37"/>
                <w:lsdException w:name="TOC Heading" w:uiPriority="39" w:qFormat="1"/>
            </w:latentStyles>
            <w:style w:type="paragraph" w:default="1" w:styleId="Normal">
                <w:name w:val="Normal"/>
                <w:qFormat/>
                <w:rsid w:val="007231F9"/>
            </w:style>
            <w:style w:type="character" w:default="1" w:styleId="DefaultParagraphFont">
                <w:name w:val="Default Paragraph Font"/>
                <w:uiPriority w:val="1"/>
                <w:semiHidden/>
                <w:unhideWhenUsed/>
            </w:style>
            <w:style w:type="table" w:default="1" w:styleId="TableNormal">
                <w:name w:val="Normal Table"/>
                <w:uiPriority w:val="99"/>
                <w:semiHidden/>
                <w:unhideWhenUsed/>
                <w:qFormat/>
                <w:tblPr>
                    <w:tblInd w:w="0" w:type="dxa"/>
                    <w:tblCellMar>
                        <w:top w:w="0" w:type="dxa"/>
                        <w:left w:w="108" w:type="dxa"/>
                        <w:bottom w:w="0" w:type="dxa"/>
                        <w:right w:w="108" w:type="dxa"/>
                    </w:tblCellMar>
                </w:tblPr>
            </w:style>
            <w:style w:type="numbering" w:default="1" w:styleId="NoList">
                <w:name w:val="No List"/>
                <w:uiPriority w:val="99"/>
                <w:semiHidden/>
                <w:unhideWhenUsed/>
            </w:style>
        </w:styles>
    </entry>
};

declare function gen:theme() {
    <entry name="word/theme/theme1.xml" type="text" method="store">
        <a:theme xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" name="Office">
            <a:themeElements>
                <a:clrScheme name="Office">
                    <a:dk1>
                        <a:sysClr val="windowText" lastClr="000000"/>
                    </a:dk1>
                    <a:lt1>
                        <a:sysClr val="window" lastClr="FFFFFF"/>
                    </a:lt1>
                    <a:dk2>
                        <a:srgbClr val="44546A"/>
                    </a:dk2>
                    <a:lt2>
                        <a:srgbClr val="E7E6E6"/>
                    </a:lt2>
                    <a:accent1>
                        <a:srgbClr val="4472C4"/>
                    </a:accent1>
                    <a:accent2>
                        <a:srgbClr val="ED7D31"/>
                    </a:accent2>
                    <a:accent3>
                        <a:srgbClr val="A5A5A5"/>
                    </a:accent3>
                    <a:accent4>
                        <a:srgbClr val="FFC000"/>
                    </a:accent4>
                    <a:accent5>
                        <a:srgbClr val="5B9BD5"/>
                    </a:accent5>
                    <a:accent6>
                        <a:srgbClr val="70AD47"/>
                    </a:accent6>
                    <a:hlink>
                        <a:srgbClr val="0563C1"/>
                    </a:hlink>
                    <a:folHlink>
                        <a:srgbClr val="954F72"/>
                    </a:folHlink>
                </a:clrScheme>
                <a:fontScheme name="Office">
                    <a:majorFont>
                        <a:latin typeface="Calibri Light" panose="020F0302020204030204"/>
                        <a:ea typeface=""/>
                        <a:cs typeface=""/>
                        <a:font script="Jpan" typeface="游ゴシック Light"/>
                        <a:font script="Hang" typeface="맑은 고딕"/>
                        <a:font script="Hans" typeface="等线 Light"/>
                        <a:font script="Hant" typeface="新細明體"/>
                        <a:font script="Arab" typeface="Times New Roman"/>
                        <a:font script="Hebr" typeface="Times New Roman"/>
                        <a:font script="Thai" typeface="Angsana New"/>
                        <a:font script="Ethi" typeface="Nyala"/>
                        <a:font script="Beng" typeface="Vrinda"/>
                        <a:font script="Gujr" typeface="Shruti"/>
                        <a:font script="Khmr" typeface="MoolBoran"/>
                        <a:font script="Knda" typeface="Tunga"/>
                        <a:font script="Guru" typeface="Raavi"/>
                        <a:font script="Cans" typeface="Euphemia"/>
                        <a:font script="Cher" typeface="Plantagenet Cherokee"/>
                        <a:font script="Yiii" typeface="Microsoft Yi Baiti"/>
                        <a:font script="Tibt" typeface="Microsoft Himalaya"/>
                        <a:font script="Thaa" typeface="MV Boli"/>
                        <a:font script="Deva" typeface="Mangal"/>
                        <a:font script="Telu" typeface="Gautami"/>
                        <a:font script="Taml" typeface="Latha"/>
                        <a:font script="Syrc" typeface="Estrangelo Edessa"/>
                        <a:font script="Orya" typeface="Kalinga"/>
                        <a:font script="Mlym" typeface="Kartika"/>
                        <a:font script="Laoo" typeface="DokChampa"/>
                        <a:font script="Sinh" typeface="Iskoola Pota"/>
                        <a:font script="Mong" typeface="Mongolian Baiti"/>
                        <a:font script="Viet" typeface="Times New Roman"/>
                        <a:font script="Uigh" typeface="Microsoft Uighur"/>
                        <a:font script="Geor" typeface="Sylfaen"/>
                        <a:font script="Armn" typeface="Arial"/>
                        <a:font script="Bugi" typeface="Leelawadee UI"/>
                        <a:font script="Bopo" typeface="Microsoft JhengHei"/>
                        <a:font script="Java" typeface="Javanese Text"/>
                        <a:font script="Lisu" typeface="Segoe UI"/>
                        <a:font script="Mymr" typeface="Myanmar Text"/>
                        <a:font script="Nkoo" typeface="Ebrima"/>
                        <a:font script="Olck" typeface="Nirmala UI"/>
                        <a:font script="Osma" typeface="Ebrima"/>
                        <a:font script="Phag" typeface="Phagspa"/>
                        <a:font script="Syrn" typeface="Estrangelo Edessa"/>
                        <a:font script="Syrj" typeface="Estrangelo Edessa"/>
                        <a:font script="Syre" typeface="Estrangelo Edessa"/>
                        <a:font script="Sora" typeface="Nirmala UI"/>
                        <a:font script="Tale" typeface="Microsoft Tai Le"/>
                        <a:font script="Talu" typeface="Microsoft New Tai Lue"/>
                        <a:font script="Tfng" typeface="Ebrima"/>
                    </a:majorFont>
                    <a:minorFont>
                        <a:latin typeface="Calibri" panose="020F0502020204030204"/>
                        <a:ea typeface=""/>
                        <a:cs typeface=""/>
                        <a:font script="Jpan" typeface="游明朝"/>
                        <a:font script="Hang" typeface="맑은 고딕"/>
                        <a:font script="Hans" typeface="等线"/>
                        <a:font script="Hant" typeface="新細明體"/>
                        <a:font script="Arab" typeface="Arial"/>
                        <a:font script="Hebr" typeface="Arial"/>
                        <a:font script="Thai" typeface="Cordia New"/>
                        <a:font script="Ethi" typeface="Nyala"/>
                        <a:font script="Beng" typeface="Vrinda"/>
                        <a:font script="Gujr" typeface="Shruti"/>
                        <a:font script="Khmr" typeface="DaunPenh"/>
                        <a:font script="Knda" typeface="Tunga"/>
                        <a:font script="Guru" typeface="Raavi"/>
                        <a:font script="Cans" typeface="Euphemia"/>
                        <a:font script="Cher" typeface="Plantagenet Cherokee"/>
                        <a:font script="Yiii" typeface="Microsoft Yi Baiti"/>
                        <a:font script="Tibt" typeface="Microsoft Himalaya"/>
                        <a:font script="Thaa" typeface="MV Boli"/>
                        <a:font script="Deva" typeface="Mangal"/>
                        <a:font script="Telu" typeface="Gautami"/>
                        <a:font script="Taml" typeface="Latha"/>
                        <a:font script="Syrc" typeface="Estrangelo Edessa"/>
                        <a:font script="Orya" typeface="Kalinga"/>
                        <a:font script="Mlym" typeface="Kartika"/>
                        <a:font script="Laoo" typeface="DokChampa"/>
                        <a:font script="Sinh" typeface="Iskoola Pota"/>
                        <a:font script="Mong" typeface="Mongolian Baiti"/>
                        <a:font script="Viet" typeface="Arial"/>
                        <a:font script="Uigh" typeface="Microsoft Uighur"/>
                        <a:font script="Geor" typeface="Sylfaen"/>
                        <a:font script="Armn" typeface="Arial"/>
                        <a:font script="Bugi" typeface="Leelawadee UI"/>
                        <a:font script="Bopo" typeface="Microsoft JhengHei"/>
                        <a:font script="Java" typeface="Javanese Text"/>
                        <a:font script="Lisu" typeface="Segoe UI"/>
                        <a:font script="Mymr" typeface="Myanmar Text"/>
                        <a:font script="Nkoo" typeface="Ebrima"/>
                        <a:font script="Olck" typeface="Nirmala UI"/>
                        <a:font script="Osma" typeface="Ebrima"/>
                        <a:font script="Phag" typeface="Phagspa"/>
                        <a:font script="Syrn" typeface="Estrangelo Edessa"/>
                        <a:font script="Syrj" typeface="Estrangelo Edessa"/>
                        <a:font script="Syre" typeface="Estrangelo Edessa"/>
                        <a:font script="Sora" typeface="Nirmala UI"/>
                        <a:font script="Tale" typeface="Microsoft Tai Le"/>
                        <a:font script="Talu" typeface="Microsoft New Tai Lue"/>
                        <a:font script="Tfng" typeface="Ebrima"/>
                    </a:minorFont>
                </a:fontScheme>
                <a:fmtScheme name="Office">
                    <a:fillStyleLst>
                        <a:solidFill>
                            <a:schemeClr val="phClr"/>
                        </a:solidFill>
                        <a:gradFill rotWithShape="1">
                            <a:gsLst>
                                <a:gs pos="0">
                                    <a:schemeClr val="phClr">
                                        <a:lumMod val="110000"/>
                                        <a:satMod val="105000"/>
                                        <a:tint val="67000"/>
                                    </a:schemeClr>
                                </a:gs>
                                <a:gs pos="50000">
                                    <a:schemeClr val="phClr">
                                        <a:lumMod val="105000"/>
                                        <a:satMod val="103000"/>
                                        <a:tint val="73000"/>
                                    </a:schemeClr>
                                </a:gs>
                                <a:gs pos="100000">
                                    <a:schemeClr val="phClr">
                                        <a:lumMod val="105000"/>
                                        <a:satMod val="109000"/>
                                        <a:tint val="81000"/>
                                    </a:schemeClr>
                                </a:gs>
                            </a:gsLst>
                            <a:lin ang="5400000" scaled="0"/>
                        </a:gradFill>
                        <a:gradFill rotWithShape="1">
                            <a:gsLst>
                                <a:gs pos="0">
                                    <a:schemeClr val="phClr">
                                        <a:satMod val="103000"/>
                                        <a:lumMod val="102000"/>
                                        <a:tint val="94000"/>
                                    </a:schemeClr>
                                </a:gs>
                                <a:gs pos="50000">
                                    <a:schemeClr val="phClr">
                                        <a:satMod val="110000"/>
                                        <a:lumMod val="100000"/>
                                        <a:shade val="100000"/>
                                    </a:schemeClr>
                                </a:gs>
                                <a:gs pos="100000">
                                    <a:schemeClr val="phClr">
                                        <a:lumMod val="99000"/>
                                        <a:satMod val="120000"/>
                                        <a:shade val="78000"/>
                                    </a:schemeClr>
                                </a:gs>
                            </a:gsLst>
                            <a:lin ang="5400000" scaled="0"/>
                        </a:gradFill>
                    </a:fillStyleLst>
                    <a:lnStyleLst>
                        <a:ln w="6350" cap="flat" cmpd="sng" algn="ctr">
                            <a:solidFill>
                                <a:schemeClr val="phClr"/>
                            </a:solidFill>
                            <a:prstDash val="solid"/>
                            <a:miter lim="800000"/>
                        </a:ln>
                        <a:ln w="12700" cap="flat" cmpd="sng" algn="ctr">
                            <a:solidFill>
                                <a:schemeClr val="phClr"/>
                            </a:solidFill>
                            <a:prstDash val="solid"/>
                            <a:miter lim="800000"/>
                        </a:ln>
                        <a:ln w="19050" cap="flat" cmpd="sng" algn="ctr">
                            <a:solidFill>
                                <a:schemeClr val="phClr"/>
                            </a:solidFill>
                            <a:prstDash val="solid"/>
                            <a:miter lim="800000"/>
                        </a:ln>
                    </a:lnStyleLst>
                    <a:effectStyleLst>
                        <a:effectStyle>
                            <a:effectLst/>
                        </a:effectStyle>
                        <a:effectStyle>
                            <a:effectLst/>
                        </a:effectStyle>
                        <a:effectStyle>
                            <a:effectLst>
                                <a:outerShdw blurRad="57150" dist="19050" dir="5400000" algn="ctr" rotWithShape="0">
                                    <a:srgbClr val="000000">
                                        <a:alpha val="63000"/>
                                    </a:srgbClr>
                                </a:outerShdw>
                            </a:effectLst>
                        </a:effectStyle>
                    </a:effectStyleLst>
                    <a:bgFillStyleLst>
                        <a:solidFill>
                            <a:schemeClr val="phClr"/>
                        </a:solidFill>
                        <a:solidFill>
                            <a:schemeClr val="phClr">
                                <a:tint val="95000"/>
                                <a:satMod val="170000"/>
                            </a:schemeClr>
                        </a:solidFill>
                        <a:gradFill rotWithShape="1">
                            <a:gsLst>
                                <a:gs pos="0">
                                    <a:schemeClr val="phClr">
                                        <a:tint val="93000"/>
                                        <a:satMod val="150000"/>
                                        <a:shade val="98000"/>
                                        <a:lumMod val="102000"/>
                                    </a:schemeClr>
                                </a:gs>
                                <a:gs pos="50000">
                                    <a:schemeClr val="phClr">
                                        <a:tint val="98000"/>
                                        <a:satMod val="130000"/>
                                        <a:shade val="90000"/>
                                        <a:lumMod val="103000"/>
                                    </a:schemeClr>
                                </a:gs>
                                <a:gs pos="100000">
                                    <a:schemeClr val="phClr">
                                        <a:shade val="63000"/>
                                        <a:satMod val="120000"/>
                                    </a:schemeClr>
                                </a:gs>
                            </a:gsLst>
                            <a:lin ang="5400000" scaled="0"/>
                        </a:gradFill>
                    </a:bgFillStyleLst>
                </a:fmtScheme>
            </a:themeElements>
            <a:objectDefaults/>
            <a:extraClrSchemeLst/>
            <a:extLst>
                <a:ext uri="{{05A4C25C-085E-4340-85A3-A5531E510DB2}}">
                    <thm15:themeFamily xmlns:thm15="http://schemas.microsoft.com/office/thememl/2012/main" name="Office Theme"
                        id="{{62F939B6-93AF-4DB8-9C6B-D6C7DFDC589F}}" vid="{{4A3C46E8-61CC-4603-A589-7422A47A8E4A}}"/>
                </a:ext>
            </a:extLst>
        </a:theme>

    </entry>
};
