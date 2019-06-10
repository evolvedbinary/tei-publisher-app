xquery version "3.1";

import module namespace docx="http://existsolutions.com/teipublisher/docx";
import module namespace config="http://www.tei-c.org/tei-simple/config" at "../config.xqm";
import module namespace pages="http://www.tei-c.org/tei-simple/pages" at "pages.xql";
import module namespace pm-config="http://www.tei-c.org/tei-simple/pm-config" at "../pm-config.xql";
import module namespace tpu="http://www.tei-c.org/tei-publisher/util" at "lib/util.xql";

declare namespace tei="http://www.tei-c.org/ns/1.0";

let $id := replace(request:get-parameter("id", ()), "^(.*)\..*", "$1")
let $token := request:get-parameter("token", ())
let $doc := root(pages:get-document($id))
let $config := tpu:parse-pi(root($doc), ())
let $output := $pm-config:docx-transform($doc, map { "root": $doc }, $config?odd)
let $docx := docx:create($config:app-root || "/templates/docx/basic.docx", $config:data-root, $output)
return
    (
        (: response:set-cookie("simple.token", $token), :)
        response:set-header("Content-Disposition", concat("attachment; filename=", concat($id, '.docx'))),
        response:stream-binary(
            $docx,
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
            replace($id, "^.*/(.*?)\..*", "$1") || '.docx'
        )
    )
