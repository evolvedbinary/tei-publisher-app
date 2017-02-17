xquery version "3.0";

module namespace docxtei="http://existsolutions.com/apps/teipublisher/docxtei";

import module namespace config="http://www.tei-c.org/tei-simple/config" at "config.xqm";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function docxtei:mkcol-recursive($collection, $components) {
    if (exists($components)) then
        let $newColl := concat($collection, "/", $components[1])
        return (
            xmldb:create-collection($collection, $components[1]),
            docxtei:mkcol-recursive($newColl, subsequence($components, 2))
        )
    else
        $collection
};

declare function docxtei:unzip-file($targetCol as xs:string, $path as xs:anyURI, $type as xs:string,
    $data as item()?, $param as item()*) {
    let $fileName := replace($path, "^.*?/?([^/]+)$", "$1")
    let $target :=
        if (contains($path, "/")) then
            let $relPath := replace($path, "^(.*?)/[^/]+$", "$1")
            let $newPath :=
                docxtei:mkcol-recursive($targetCol, tokenize($relPath, "/"))
            return
                $targetCol || "/" || $relPath
        else
            $targetCol
    return
        xmldb:store($target, xmldb:encode-uri($fileName), $data)
};


declare function docxtei:unzip($collection as xs:string, $docx as xs:string) {
    let $name := xmldb:encode-uri(replace($docx, "^([^\.]+)\..*$", "$1"))
    let $targetCol := $collection || "/" || $name
    let $createCol :=
        if (not(xmldb:collection-available($targetCol))) then
            xmldb:create-collection($collection, $name)
        else
            ()
    let $unzipped :=
        compression:unzip(util:binary-doc($collection || "/" || $docx),
            function($path as xs:anyURI, $type as xs:string, $param as item()*) { true() },
            (),
            docxtei:unzip-file($targetCol, ?, ?, ?, ?),
            ()
        )
    return
        $targetCol
};

declare function docxtei:transform($collection as xs:string, $name as xs:string) {
    let $xml := transform:transform(doc($collection || "/word/document.xml"),
        doc($config:app-root || "/resources/xsl/docx/from/docxtotei.xsl"),
        <parameters>
            <param name="word-directory" value="xmldb:exist://{$collection}"/>
            <param name="convertGraphics" value="false()"/>
        </parameters>
    )
    let $raw := docxtei:add-id("vol_130", $xml)
    let $imported := transform:transform($raw, doc($config:app-root || "/resources/xsl/wordtei2gsktei.xsl"), ())
    return
        $imported
};

declare function docxtei:add-id($id as xs:string, $xml as element(tei:TEI)) {
    if ($xml/@xml:id) then
        $xml
    else
        element { node-name($xml) } {
            attribute xml:id { $id },
            $xml/@*,
            $xml/node()
        }
};