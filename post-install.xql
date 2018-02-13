xquery version "3.0";
import module namespace config="http://www.digital-archiv.at/ns/rundbriefe-app/config" at "modules/config.xqm";

declare variable $app-user := "rundbriefe";
(: create 'glaser' group :)
if (not(sm:group-exists($app-user)))
then sm:create-group($app-user)
else (),

(: grant general execution rights to all scripts in analyze and modules collection :)
for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/analyze/"))
    let $changed := sm:add-group-ace(xs:anyURI($config:app-root||"/analyze/"||$resource), $app-user, true(), "rwx")
    return sm:chmod(xs:anyURI($config:app-root||'/analyze/'||$resource), "rwxrwxr-x"),

for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/modules/"))
    let $changed := sm:add-group-ace(xs:anyURI($config:app-root||"/modules/"||$resource), $app-user, true(), "rwx")
    return sm:chmod(xs:anyURI($config:app-root||'/modules/'||$resource), "rwxrwxr-x"),
   
for $collection in xmldb:get-child-collections($config:app-root||"/data")
    let $changed := sm:add-group-ace(xs:anyURI($config:app-root||"/data/"||$collection), $app-user, true(), "rwx")
    for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/data/"||$collection))
        return
            sm:add-group-ace(xs:anyURI($config:app-root||"/data/"||$collection||"/"||$resource), $app-user, true(), "rwx"),

for $resource in xmldb:get-child-resources(xs:anyURI($config:app-root||"/exgit/"))
    let $changed := sm:add-group-ace(xs:anyURI($config:app-root||"/exgit/"||$resource), $app-user, true(), "rwx")
    return sm:chmod(xs:anyURI($config:app-root||'/exgit/'||$resource), "rwxrwxr--")
