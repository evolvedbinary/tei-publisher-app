xquery version "3.1";

import module namespace xproc="http://exist-db.org/xproc";

let $simple-xproc as document-node() := document {
    <p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0">
            <p:input port="source">
                    <p:inline>
                            <doc>Hello world!</doc>
                    </p:inline>
            </p:input>
            <p:output port="result"/>
            <p:identity/>
    </p:declare-step>
}

return
    xproc:process($simple-xproc)
