xquery version "3.1";

import module namespace gen="http://teipublisher.com/xquery/docx-generate" at "generate-docx.xql";
import module namespace pages="http://www.tei-c.org/tei-simple/pages" at "lib/pages.xql";
import module namespace tpu="http://www.tei-c.org/tei-publisher/util" at "lib/util.xql";

declare function local:tei2docx($doc as document-node()) {
    let $docConfig := map:merge((tpu:parse-pi($doc, "div"), map { "view": "div" }))
    let $config := map:merge((map { "docConfig": $docConfig }, map { "type": $docConfig?type }))
    return
        gen:generate($doc, $config)
};


let $id := replace(request:get-parameter("id", ""), "^(.*)\..*", "$1")
let $lang := request:get-parameter("lang", ())
let $work := pages:get-document($id)
let $entries := local:tei2docx($work)
return
    (
        response:set-header("Content-Disposition", concat("attachment; filename=", concat($id, '.docx'))),
        response:stream-binary(
            compression:zip( $entries, true() ),
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
            concat($id, '.docx')
        )
    )
