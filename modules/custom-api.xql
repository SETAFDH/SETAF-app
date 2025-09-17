xquery version "3.1";

(:~
 : This is the place to import your own XQuery modules for either:
 :
 : 1. custom API request handling functions
 : 2. custom templating functions to be called from one of the HTML templates
 :)
module namespace api="http://teipublisher.com/api/custom";

(: Add your own module imports here :)
import module namespace rutil="http://e-editiones.org/roaster/util";
import module namespace app="teipublisher.com/app" at "app.xql";
import module namespace config = "http://www.tei-c.org/tei-simple/config" at "config.xqm";
import module namespace vapi="http://teipublisher.com/api/view" at "lib/api/view.xql";
import module namespace tpu="http://www.tei-c.org/tei-publisher/util" at "lib/util.xql";
import module namespace templates="http://exist-db.org/xquery/html-templating";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

(:~
 : Keep this. This function does the actual lookup in the imported modules.
 :)
declare function api:lookup($name as xs:string, $arity as xs:integer) {
    try {
        function-lookup(xs:QName($name), $arity)
    } catch * {
        ()
    }
};

(: New endpoint for static pages : based on the code of the Escher Briefedition project :)
declare function api:view-about($request as map(*)) {
    let $id := xmldb:decode($request?parameters?doc)
    let $docid := if (ends-with($id, '.xml')) then $id else $id || '.xml'
    let $template := doc($config:app-root || "/templates/pages/static.html")
    let $title := (doc($config:data-root || "/static/" || $docid)//tei:text//tei:head)[1]
    let $model := map {
        "doc": 'static/' || $docid,
        "template": "static",
        "title": $title,
        "docid": $id,
        "uri": "static/" || $id
    }
    return
        templates:apply($template, vapi:lookup#2, $model, tpu:get-template-config($request))
};
