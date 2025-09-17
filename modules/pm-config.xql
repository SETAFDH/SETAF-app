
xquery version "3.1";

module namespace pm-config="http://www.tei-c.org/tei-simple/pm-config";

import module namespace pm-setaf-web="http://www.tei-c.org/pm/models/setaf/web/module" at "../transform/setaf-web-module.xql";
import module namespace pm-setaf-print="http://www.tei-c.org/pm/models/setaf/print/module" at "../transform/setaf-print-module.xql";
import module namespace pm-setaf-latex="http://www.tei-c.org/pm/models/setaf/latex/module" at "../transform/setaf-latex-module.xql";
import module namespace pm-setaf-epub="http://www.tei-c.org/pm/models/setaf/epub/module" at "../transform/setaf-epub-module.xql";
import module namespace pm-setaf-fo="http://www.tei-c.org/pm/models/setaf/fo/module" at "../transform/setaf-fo-module.xql";
import module namespace pm-docx-tei="http://www.tei-c.org/pm/models/docx/tei/module" at "../transform/docx-tei-module.xql";

declare variable $pm-config:web-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "setaf.odd" return pm-setaf-web:transform($xml, $parameters)
    default return pm-setaf-web:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:print-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "setaf.odd" return pm-setaf-print:transform($xml, $parameters)
    default return pm-setaf-print:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:latex-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "setaf.odd" return pm-setaf-latex:transform($xml, $parameters)
    default return pm-setaf-latex:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:epub-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "setaf.odd" return pm-setaf-epub:transform($xml, $parameters)
    default return pm-setaf-epub:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:fo-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "setaf.odd" return pm-setaf-fo:transform($xml, $parameters)
    default return pm-setaf-fo:transform($xml, $parameters)
            
    
};
            


declare variable $pm-config:tei-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    switch ($odd)
    case "docx.odd" return pm-docx-tei:transform($xml, $parameters)
    default return error(QName("http://www.tei-c.org/tei-simple/pm-config", "error"), "No default ODD found for output mode tei")
            
    
};
            
    