xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:media-type "application/json";

(:
 : returns a list of elmentSpec idents for use in odd editor  
 :)


(:let $rules := map:)
(:    {:)
(:        "foo":"bar":)
(:    }:)
(:return $rules:)
  
  
array{  
let $simpleOdd := collection('/db/apps/tei-publisher/odd')//tei:schemaSpec[@ident='teipublisher']//tei:elementSpec
    for $spec in $simpleOdd
    let $var := data($spec/@ident)
    return
          $var
        
}
