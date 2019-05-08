xquery version "3.1";

module namespace docx = "http://existsolutions.com/teipublisher/docx";

declare namespace w="http://schemas.openxmlformats.org/wordprocessingml/2006/main";

import module namespace config="http://www.tei-c.org/tei-simple/config" at "/db/apps/tei-publisher/modules/config.xqm";
import module namespace compression="http://exist-db.org/xquery/compression" at "java:org.exist.xquery.modules.compression.CompressionModule";
import module namespace pm="http://www.tei-c.org/pm/models/docx/web/module" at "/db/apps/tei-publisher/transform/docx-web-module.xql";

declare variable $docx:TEMP := $config:data-root || "/temp";

declare function docx:process($path as xs:string) {
    if (util:binary-doc-available($path)) then
        let $tempColl := docx:mkcol-recursive($config:data-root, "temp")
        let $unzipped := docx:unzip($docx:TEMP, $path)
        let $document := doc($unzipped || "/word/document.xml")
        let $styles := docx:extract-styles(doc($unzipped || "/word/styles.xml")/w:styles)
        let $numbering := doc($unzipped || "/word/numbering.xml")/w:numbering
        let $params := map {
            "styles": $styles,
            "pstyle": function($node as element()) {
                for $styleId in $node/w:pPr/w:pStyle/@w:val
                return
                    $styles($styleId)
            },
            "cstyle": function($node as element()) {
                for $styleId in $node/w:rPr/w:rStyle/@w:val
                return
                    $styles($styleId)
            },
            "nstyle": function($node as element()) {
                let $ref := $node/w:pPr/w:numPr
                let $lvl := $ref/w:ilvl/@w:val
                let $num := $numbering/w:num[@w:numId = $ref/w:numId/@w:val]
                let $abstractNumRef := $num/w:abstractNumId/@w:val
                let $abstractNum := $numbering/w:abstractNum[@w:abstractNumId = $abstractNumRef]
                return
                    $abstractNum/w:lvl[@w:ilvl = $lvl]
            }
        }
        return
            <html>
                <head>
                    <link rel="stylesheet" href="../transform/docx.css"/>
                </head>
                { pm:transform($document, $params) }
            </html>
    else
        ()
};

declare function docx:extract-styles($doc as element()?) {
    map:merge(
        for $style in $doc/w:style
        return
            map:entry($style/@w:styleId/string(), $style)
    )
};


declare %private function docx:unzip($collection as xs:string, $docx as xs:string) {
    let $fileName := replace($docx, "^.*?/([^/]+)$", "$1")
    let $name := xmldb:encode-uri(replace($fileName, "^([^\.]+)\..*$", "$1"))
    let $targetCol := $collection || "/" || $name
    let $createCol :=
        if (not(xmldb:collection-available($targetCol))) then
            xmldb:create-collection($collection, $name)
        else
            ()
    let $unzipped :=
        compression:unzip(util:binary-doc($docx),
            function($path as xs:anyURI, $type as xs:string, $param as item()*) { true() },
            (),
            docx:unzip-file($targetCol, ?, ?, ?, ?),
            ()
        )
    return
        $targetCol
};

declare %private function docx:unzip-file($targetCol as xs:string, $path as xs:anyURI, $type as xs:string,
    $data as item()?, $param as item()*) {
    let $fileName := replace($path, "^.*?/?([^/]+)$", "$1")
    let $target :=
        if (contains($path, "/")) then
            let $relPath := replace($path, "^(.*?)/[^/]+$", "$1")
            let $newPath := docx:mkcol-recursive($targetCol, tokenize($relPath, "/"))
            return
                $targetCol || "/" || $relPath
        else
            $targetCol
    return
        xmldb:store($target, xmldb:encode-uri($fileName), $data)
};

declare %private function docx:mkcol-recursive($collection, $components) {
    if (exists($components)) then
        let $newColl := concat($collection, "/", $components[1])
        return (
            xmldb:create-collection($collection, $components[1]),
            docx:mkcol-recursive($newColl, subsequence($components, 2))
        )
    else
        $collection
};
