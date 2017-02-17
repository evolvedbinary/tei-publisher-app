xquery version "3.1";

import module namespace config="http://www.tei-c.org/tei-simple/config" at "../config.xqm";
import module namespace docxtei="http://existsolutions.com/apps/teipublisher/docxtei" at "../docx2tei.xql";
import module namespace console="http://exist-db.org/xquery/console" at "java:org.exist.console.xquery.ConsoleModule";

declare namespace json="http://www.json.org";

declare option exist:serialize "method=json media-type=application/json";

declare function local:upload($root, $paths, $payloads) {
    let $paths :=
        for-each-pair($paths, $payloads, function($path, $data) {
            if (ends-with($path, ".docx")) then
                 let $stored := xmldb:store($config:data-root || "/" || $root, xmldb:encode-uri($path), $data)
                 let $outputCol := docxtei:unzip($config:data-root || "/" || $root, $path)
                 let $name := replace($outputCol, "^.*?/([^/]+)$", "$1")
                 let $log := console:log("Output: " || $outputCol || " name: " || $name)
                 let $transformed := docxtei:transform($outputCol, $name)
                 return (
                     xmldb:store($config:data-root || "/" || $root, $name || ".xml", $transformed),
                     xmldb:remove($outputCol)
                 )
            else if (ends-with($path, ".odd")) then
                xmldb:store($config:odd-root, $path, $data)
            else
                xmldb:store($config:data-root || "/" || $root, $path, $data)
        })
    return
        map {
            "files": array {
                for $path in $paths
                return
                    map {
                        "name": $path,
                        "type": xmldb:get-mime-type($path),
                        "size": 93928
                    }
            }
        }
};

let $name := request:get-uploaded-file-name("files[]")
let $data := request:get-uploaded-file-data("files[]")
let $root := request:get-parameter("root", "")
return
    try {
        local:upload($root, $name, $data)
    } catch * {
        map {
            "name": $name,
            "error": $err:description
        }
    }
