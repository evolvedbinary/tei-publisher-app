xquery version "3.1";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html5";
declare option output:media-type "text/html";

import module namespace docx="http://existsolutions.com/teipublisher/docx" at "/db/apps/tei-publisher/modules/lib/docx.xql";

docx:process("/db/apps/tei-publisher/data/test.docx")