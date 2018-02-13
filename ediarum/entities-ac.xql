xquery version "3.0";
import module namespace app="http://www.digital-archiv.at/ns/rundbriefe-app/templates" at "../modules/app.xql";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xml media-type=text/xml omit-xml-declaration=no indent=yes";

let $type := request:get-parameter('entity', 'person')

let $return := 
    if($type eq 'person') then
        <list>{
        let $entities := doc($app:personIndex)//tei:person
        
        for $x in $entities
            return 
                <item>
                    <name>{normalize-space(string-join($x/tei:persName//text(), ' '))}</name>
                    <id>{data($x/@xml:id)}</id>
                </item>
        }</list>
    else if($type eq 'place') then
        <list>{
        let $entities := doc($app:placeIndex)//tei:place
        
        for $x in $entities
            return 
                <item>
                    <name>{normalize-space(string-join($x/tei:placeName//text(), ' '))}</name>
                    <id>{data($x/@xml:id)}</id>
                </item>
        }</list>
    else if($type eq 'org') then
        <list>{
        let $entities := doc($app:orgIndex)//tei:org
        for $x in $entities
            return 
                <item>
                    <name>{normalize-space(string-join($x/tei:orgName//text(), ' '))}</name>
                    <id>{data($x/@xml:id)}</id>
                </item>
        }</list>
    else if($type eq 'work') then
        <list>{
        let $entities := doc($app:workIndex)//tei:bibl
        for $x in $entities
            return 
                <item>
                    <name>{normalize-space(string-join($x/tei:title//text(), ' '))}</name>
                    <id>{data($x/@xml:id)}</id>
                </item>
        }</list>
    else ()

return $return
