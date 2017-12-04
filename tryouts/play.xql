xquery version "3.0";
declare namespace functx = "http://www.functx.com";
import module namespace xmldb="http://exist-db.org/xquery/xmldb";
import module namespace config="http://www.digital-archiv.at/ns/rundbriefe-app/config" at "../modules/config.xqm";
import module namespace app="http://www.digital-archiv.at/ns/rundbriefe-app/templates" at "../modules/app.xql";
declare namespace tei = "http://www.tei-c.org/ns/1.0";


for $x in collection($app:editions)//tei:TEI//*[@* castable as xs:date]
let $before := $x/preceding::text()[1]
let $after := $x/following::text()[1]
let $snippet := string-join(($before, $x/text(), $after))
return $snippet