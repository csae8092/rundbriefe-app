xquery version "3.1";
import module namespace config="http://www.digital-archiv.at/ns/rundbriefe-app/config" at "../modules/config.xqm";

let $collection :=  $config:app-root||'/data/'
let $repoDir := request:get-parameter('repoDir', '/opt/exist/webapp/WEB-INF/data/repos/Rundbriefe/')
let $importDir := $repoDir||'data/'
let $pull := exgit:pull($repoDir, 'origin', 'username', 'pw')
let $import := exgit:import($importDir, $collection)

return
    <pre>
        <pull>{$pull}</pull>
        <import>{$import}</import>
    </pre>
