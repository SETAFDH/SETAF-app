xquery version "3.1";

(: 
 : Module for app-specific template functions
 :
 : Add your own templating functions here, e.g. if you want to extend the template used for showing
 : the browsing view.
 :)
module namespace app="teipublisher.com/app";

import module namespace templates="http://exist-db.org/xquery/html-templating";
import module namespace config="http://www.tei-c.org/tei-simple/config" at "config.xqm";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";

declare
    %templates:wrap
function app:foo($node as node(), $model as map(*)) {
    <p>Dummy templating function.</p>
};

declare function app:breadcrumb-corpus($node as node(), $model as map(*)) {
    let $ID := $model?doc
    =>substring-after("/")
    =>substring-before("_")
    
    return
        <span><a href="../accueil.html" class="link"><pb-i18n key="pages.home">Accueil</pb-i18n></a> > <a href="../index.html?collection=corpus" class="link">Corpus</a> > {$ID}</span>
};

declare function app:breadcrumb-engraving($node as node(), $model as map(*)) {
    let $ID := $model?doc
    let $doc := doc($config:data-root || '/' || $ID)
    let $title := $doc//tei:titleStmt/tei:title/text()
    
    return
        <span class="breadcrumb"><a href="../accueil.html"><pb-i18n key="pages.home">Accueil</pb-i18n></a> > <a href="../index_gravures.html"><pb-i18n key="pages.engravings">Gravures</pb-i18n></a> > {$title}</span>
};

declare function app:download-tei($node as node(), $model as map(*)) {
    let $ID := $model?doc
    =>substring-after("/")
    
    return 
        <paper-button style="padding:0; min-width:0;"><span style="color:white;">.</span><a style="margin-top:4px" href="https://github.com/SETAFDH/SETAF-app-data/blob/main/data/corpus/{$ID}" 
               target="_blank">
               <svg style="width:40px;" viewBox="0 0 512 512" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" fill="#000000">
                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                    <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                    <g id="SVGRepo_iconCarrier"> <title>xml-document</title> 
                        <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"> 
                            <g id="icon" fill="#6A1D44" transform="translate(62.077867, 42.666667)"> 
                                <path d="M257.922133,7.10542736e-15 L23.2554667,7.10542736e-15 L23.2554667,234.666667 L65.9221333,234.666667 L65.9221333,192 L65.9221333,169.6 L65.9221333,42.6666667 L240.215467,42.6666667 L321.922133,124.373333 L321.922133,169.6 L321.922133,192 L321.922133,234.666667 L364.5888,234.666667 L364.5888,106.666667 L257.922133,7.10542736e-15 L257.922133,7.10542736e-15 Z M95.936,277.568 L65.728,319.338667 L35.904,277.568 L2.34666667,277.568 L47.3813333,339.946667 L-2.13162821e-14,405.696 L34.0693333,405.696 L64.2986667,362.922667 L94.6773333,405.696 L129.472,405.696 L82.3893333,340.672 L128.938667,277.568 L95.936,277.568 Z M231.0848,346.606933 C228.9088,353.284267 226.4128,361.924267 223.575467,372.462933 C220.759467,361.796267 218.263467,353.1776 216.1728,346.606933 L194.0288,277.3376 L151.255467,277.3376 L151.255467,405.4656 L177.922133,405.4656 L177.922133,301.742933 C180.866133,312.7936 183.447467,321.646933 185.602133,328.3456 L210.562133,405.4656 L235.330133,405.4656 L261.015467,326.1696 C263.6608,318.084267 266.0288,309.956267 268.055467,301.742933 L268.055467,405.4656 L295.831467,405.4656 L295.831467,277.3376 L253.527467,277.3376 L231.0848,346.606933 Z M324.951467,277.568 L324.951467,405.696 L408.855467,405.696 L408.855467,383.082667 L353.815467,383.082667 L353.815467,277.568 L324.951467,277.568 Z" id="XLS"></path>
                            </g>
                        </g>
                   </g>
               </svg>
        </a></paper-button>
};

declare function app:display-view($node as node(), $model as map(*)) {
    let $ID := $model?doc
    let $doc := doc($config:data-root || '/' || $ID)
    let $reg := $doc//tei:profileDesc//tei:term[@type="intermediary_reg_quality"]
    
    return
        if($reg = 'gold')
            then <pb-panel emit="transcription" id="view1" label="Options de consultation">
                        <template title="Normalisée">
                            <pb-view src="document1" class=".transcription" subscribe="transcription" emit="transcription">
                                <pb-param name="view" value="normalized"/>
                            </pb-view>
                        </template>
                        <template title="Graphématique">
                            <pb-view id="view1" src="document1" class=".transcription" subscribe="transcription" emit="transcription">
                                <pb-param name="view" value="original"/>
                            </pb-view>
                        </template>
                    </pb-panel>
            else <pb-panel emit="transcription" id="view1" label="Options de consultation">
                        <template title="Graphématique">
                            <pb-view id="view1" src="document1" class=".transcription" subscribe="transcription" emit="transcription">
                                <pb-param name="view" value="original"/>
                            </pb-view>
                        </template>
                    </pb-panel>
            
};

declare function app:annotation-ling($node as node(), $model as map(*)) {
    let $ID := $model?doc
    let $doc := doc($config:data-root || '/' || $ID)
    let $annotation := $doc//tei:profileDesc//tei:term[@type="ling_annotation"]
    
    return
        if($annotation = 'oui')
            then <a href="https://github.com/SETAFDH/Annotation-linguistique-SETAF" target="_blank">
                    <paper-button id="annotationToggle" class="toc-toggle" raised="raised">
                        <pb-i18n key="buttons.ling">Annotations linguistiques</pb-i18n>
                    </paper-button>
                 </a>
        else ()
};

declare function app:citation($node as node(), $model as map(*)) {
    let $ID := $model?doc
    let $doc := doc($config:data-root || '/' || $ID)
    
    let $auteur := 
        if ($doc//tei:author/tei:persName[1]/tei:surname = "Anonyme")
        then ""
        else
            if ($doc//tei:author/tei:persName[1][@role='presumed_author']) 
                then '[' || $doc//tei:author/tei:persName[1]/tei:surname || ', ' || 
                $doc//tei:author/tei:persName[1]/tei:forename || ']. ' 
            else $doc//tei:author/tei:persName[1]/tei:surname || ', ' || 
                $doc//tei:author/tei:persName[1]/tei:forename || '. '
    
    let $auteur_short :=
        if ($doc//tei:author/tei:persName[1]/tei:surname = "Anonyme")
        then ""
        else
            $doc//tei:author/tei:persName[1]/tei:surname || ', ' || $doc//tei:author/tei:persName[1]/tei:forename || '. '
        
    let $titre := $doc//tei:title[@type="short_title"]/text()
    
    let $lieu := 
        if ($doc//tei:imprint/tei:pubPlace[@cert="low"]) 
            then ' [' || $doc//tei:imprint/tei:pubPlace[1] || '?]'
        else if ($doc//tei:imprint/tei:pubPlace[@cert="medium"]) 
            then ' [' || $doc//tei:imprint/tei:pubPlace[1] || ']'  
        else ' ' || $doc//tei:imprint/tei:pubPlace[1]
        
    let $lieu_short :=
        if ($doc//tei:imprint/tei:pubPlace[@cert="low"]) 
            then ' ' || $doc//tei:imprint/tei:pubPlace[1] || '? '  
        else ' ' || $doc//tei:imprint/tei:pubPlace[1]
        
    let $imprimeur :=
        if ($doc//tei:imprint/tei:respStmt/tei:persName[1][@role='presumed_printer'])
            then '[' || $doc//tei:imprint/tei:respStmt/tei:persName[1]/tei:forename ||
            ' ' || $doc//tei:imprint/tei:respStmt/tei:persName[1]/tei:surname || ']' 
        else $doc//tei:imprint/tei:respStmt/tei:persName[1]/tei:forename ||
            ' ' || $doc//tei:imprint/tei:respStmt/tei:persName[1]/tei:surname
    
    let $imprimeur_short := 
        if ($doc//tei:imprint/tei:respStmt/tei:persName[1]/tei:surname = '[s.n.]')
        then 's.n.'
        else $doc//tei:imprint/tei:respStmt/tei:persName[1]/tei:forename || ' ' || $doc//tei:imprint/tei:respStmt/tei:persName[1]/tei:surname
    
    let $date :=
        if ($doc//tei:imprint/tei:date[@cert='low']) 
            then '[' || $doc//tei:imprint/tei:date || '?]'  
        else if ($doc//tei:imprint/tei:date[@cert='medium']) 
            then '[' || $doc//tei:imprint/tei:date || ']'  
        else $doc//tei:imprint/tei:date
        
    let $date_short :=
        if ($doc//tei:imprint/tei:date[@cert='low']) 
            then '' || $doc//tei:imprint/tei:date || '?' 
        else $doc//tei:imprint/tei:date
        
    let $editrice := 
        for $resp in $doc//tei:fileDesc/tei:titleStmt/tei:respStmt/tei:resp
            return
                if($resp[contains(., "Supervision")])
                then normalize-space($resp/following-sibling::tei:persName)
                else ''
    
    let $editrice_short := 
        for $resp in $doc//tei:fileDesc/tei:titleStmt/tei:respStmt/tei:resp
            return
                if($resp[contains(., "Supervision")] and starts-with($resp/following-sibling::tei:persName/tei:forename, "S"))
                then "S. " || $resp/following-sibling::tei:persName/tei:surname
                else ''
    
    let $contributeur :=
        for $name in $doc//tei:fileDesc/tei:titleStmt/tei:respStmt/tei:persName
            return
                if($name[not(matches(@xml:id, "^SG|^D|^E"))] )
                then normalize-space($name) || ', '
                else ''
    
    let $currentDate := fn:format-date(fn:current-date(), "[D,2]-[M,2]-[Y,4]")
    
    return
        <div class="citations">
            <div>
                <h3>Citation courte</h3>
                <pb-clipboard label="">
                    <div>
                        {$auteur_short} {$titre} {$lieu_short} : {$imprimeur_short}, {$date_short}. Éd. num. par {$editrice_short} et al.
                        Projet SETAF, dir. D. Solfaroli Camillocci. &lt;https://setaf.unige.ch&gt;, consulté le {$currentDate}.
                    </div>
                </pb-clipboard>
            </div>
            
            <div>
                <h3>Citation longue</h3>
                <pb-clipboard label="">
                    <div>
                        {$auteur} <i>{$titre}</i> {$lieu} : {$imprimeur}, {$date}. Édition numérique réalisée par {$contributeur} Simon Gabay et Elina Leblanc. 
                        Projet SETAF, dir. Daniela Solfaroli Camillocci. &lt;https://setaf.unige.ch&gt;, consulté le {$currentDate}.
                    </div>
                </pb-clipboard>
            </div>
        </div>
};

declare function app:resp($node as node(), $model as map(*)) {
    let $ID := $model?doc
    let $doc := doc($config:data-root || '/' || $ID)
    let $names := $doc//tei:titleStmt//tei:persName
    
    for $name in $names
        return <li><span class="bold">{$name}</span> : {$name/preceding-sibling::tei:resp}</li>
        
};

declare function app:display-illustration($node as node(), $model as map(*)) {
    let $ID := $model?doc
    let $doc := doc($config:data-root || '/' || $ID)
    let $URI := $doc//tei:p/tei:figure/tei:graphic/string(@url)
    let $desc := $doc//tei:p/tei:figure/tei:figDesc/tei:title[@type="titre_gravure"]/text()
    
    return
        <img class="magnify-image" src="{$URI}" alt="{$desc}" width="460" height="701"/>
};

declare function app:image-gallery($node as node(), $model as map(*)) {
    let $ID := $model?doc
    let $doc := doc($config:data-root || '/' || $ID)
    
    let $images := $doc//tei:list[@type="exemplaires_similaires"]//tei:graphic
    
    for $image in $images
        let $url-small := 
            if ($image/@url[contains(., "/full/max")])
            then replace($image/@url, "/full/max/", "/full/400,/")
            else replace($image/@url, "/full/full/", "/full/400,/")
        let $url-large := 
            if ($image/@url[contains(., "/full/max")])
            then replace($image/@url, "/full/max/", "/full/700,/")
            else replace($image/@url, "/full/full/", "/full/700,/")
        
        return
            if($image/parent::tei:item[@n="faits"])
                then
                    <div class="faits-img">
                        <img src="{$url-small}" height="200px" alt="Gravure des Faits, édition de Genève"/>
                    </div>
            
            else
            <div class="one-img">
                {
                    if($image[@type="large"])
                    then <img src="{$url-small}" height="110px" loading="lazy" onclick="openPopUp(this)" 
                              alt="{$image/following-sibling::tei:figDesc/tei:bibl/tei:title/text()} - {$image/following-sibling::tei:figDesc/tei:bibl/tei:date}"/>
                    
                    else
                    <img src="{$url-small}" height="200px" loading="lazy" onclick="openPopUp(this)" 
                         alt="{$image/following-sibling::tei:figDesc/tei:bibl/tei:title/text()} - {$image/following-sibling::tei:figDesc/tei:bibl/tei:date}"/>
                }
            
                <!--<img src="{$url-small}" height="200px" loading="lazy" onclick="openPopUp(this)" 
                alt="{$image/following-sibling::tei:figDesc/tei:bibl/tei:title/text()} - {$image/following-sibling::tei:figDesc/tei:bibl/tei:date}"/>-->
                
                <!--<div class="overlay" onclick="this.nextElementSibling.style.display='block'">
                    <div class="text">{$image/following-sibling::tei:figDesc/tei:bibl/tei:title/text()}</div>
                </div>-->
                
                <div class="overlay-gravure" onclick="openPopUp(this)">
                    <div class="text">{$image/following-sibling::tei:figDesc/tei:bibl/tei:title/text()} <br/>{$image/following-sibling::tei:figDesc/tei:bibl/tei:date}</div>
                </div>
                
                <div class="pop-up-content">
                    <div>
                        <!--<div class="image-container">-->
                        <img class="img-pop-up" src="{$url-large}"/>
                        <!--</div>-->
                        <div class="text-pop-up">
                            <div>
                                <p class="bold">Source</p>
                                <p>
                                   { 
                                    if ($image/following-sibling::tei:figDesc/tei:objectType = "Gravure sur bois")
                                     then <span><a href="{$image/following-sibling::tei:figDesc/tei:bibl/@source}" target="blank_">{$image/following-sibling::tei:figDesc/tei:bibl/tei:title[@type="titre_ouvrage"]/text()}</a>.
                                          {$image/following-sibling::tei:figDesc/tei:bibl/tei:pubPlace} : {$image/following-sibling::tei:figDesc/tei:bibl/tei:publisher}, 
                                          {$image/following-sibling::tei:figDesc/tei:bibl/tei:date}, {$image/following-sibling::tei:figDesc/tei:locus}.</span>
                                    
                                    else if ($image/following-sibling::tei:figDesc/tei:objectType = "Gravure sur métal")
                                     then <span><a href="{$image/following-sibling::tei:figDesc/tei:bibl/@source}" target="blank_">{$image/following-sibling::tei:figDesc/tei:bibl/tei:title[@type="titre_ouvrage"]/text()}</a>.
                                          {$image/following-sibling::tei:figDesc/tei:bibl/tei:pubPlace} : {$image/following-sibling::tei:figDesc/tei:bibl/tei:publisher}, 
                                          {$image/following-sibling::tei:figDesc/tei:bibl/tei:date}, {$image/following-sibling::tei:figDesc/tei:locus}.</span>
                                    
                                    else if ($image/following-sibling::tei:figDesc/tei:objectType = "Gravure sur cuivre ")
                                    then <span><a href="{$image/following-sibling::tei:figDesc/tei:bibl/@source}" target="blank_">{$image/following-sibling::tei:figDesc/tei:bibl/tei:title[@type="titre_ouvrage"]/text()}</a>.
                                          {$image/following-sibling::tei:figDesc/tei:bibl/tei:pubPlace} : {$image/following-sibling::tei:figDesc/tei:bibl/tei:publisher}, 
                                          {$image/following-sibling::tei:figDesc/tei:bibl/tei:date}, {$image/following-sibling::tei:figDesc/tei:locus}.</span>
                                    
                                    else <span><a href="{$image/following-sibling::tei:figDesc/tei:bibl/@source}" target="blank_">{$image/following-sibling::tei:figDesc/tei:bibl/tei:title[@type="titre_ouvrage"]/text()}</a>,
                                          {$image/following-sibling::tei:figDesc/tei:bibl/tei:date} ({$image/following-sibling::tei:figDesc/tei:locus}).</span>
                                   }
                                </p>
                            </div>
                            <div>
                                <p class="bold"><pb-i18n key="metadata.artist">Artiste</pb-i18n></p>
                                <p>
                                    { if ($image/following-sibling::tei:figDesc/tei:bibl/tei:author/text())
                                        then $image/following-sibling::tei:figDesc/tei:bibl/tei:author/text()
                                     else("Inconnu")
                                    }
                                </p>
                            </div>
                            <div>
                                <p class="bold">Technique</p>
                                <p>{$image/following-sibling::tei:figDesc/tei:objectType/text()}</p>
                            </div>
                            
                            {
                                if ($image/following-sibling::tei:figDesc/tei:dim/text())
                                    then <div><p class="bold">Dimensions</p><p>{$image/following-sibling::tei:figDesc/tei:dim/text() || " mm"}</p></div>
                                else ()
                            }
                            
                            {
                                if($image/following-sibling::tei:figDesc/tei:title[@type="titre_courant"]/text() and $image/following-sibling::tei:figDesc/tei:title[@type="manchette"]/text())
                                    then <div>
                                            <p class="bold">Inscriptions</p>
                                            <p>
                                                <pb-i18n key="metadata.running">Titre courant</pb-i18n> : {$image/following-sibling::tei:figDesc/tei:title[@type="titre_courant"]/text()}
                                                <br/>Manchette : {$image/following-sibling::tei:figDesc/tei:title[@type="manchette"]/text()}
                                            </p>
                                         </div>
                                else if ($image/following-sibling::tei:figDesc/tei:title[@type="manchette"]/text())
                                    then <div>
                                            <p class="bold">Inscriptions</p>
                                            <p>
                                                Manchette : {$image/following-sibling::tei:figDesc/tei:title[@type="manchette"]/text()}
                                            </p>
                                         </div>
                                else if ($image/following-sibling::tei:figDesc/tei:title[@type="titre_courant"]/text())
                                    then <div>
                                            <p class="bold">Inscriptions</p>
                                            <p>
                                                <pb-i18n key="metadata.running">Titre courant</pb-i18n> : {$image/following-sibling::tei:figDesc/tei:title[@type="titre_courant"]/text()}
                                            </p>
                                         </div>
                                else()
                            }
                            
                            <div class="description_engraving">
                                <p class="bold"><pb-i18n key="metadata.desc">Description</pb-i18n></p>
                                <p>{$image/following-sibling::tei:note[@type="commentaire"]}</p>
                                <p style="margin-top:0;">{$image/following-sibling::tei:note/following-sibling::tei:note[@type="biblio"]}</p>
                            </div>
                            
                            {
                                if($image/following-sibling::tei:figDesc/tei:bibl/tei:idno)
                                    then <div>
                                            <p class="bold"><pb-i18n key="metadata.ref">Références</pb-i18n></p>
                                            <ul>
                                                { for $idno in $image/following-sibling::tei:figDesc/tei:bibl/tei:idno
                                                  return <li><a href="{$idno/@corresp}" target="_blank">{$idno/text()}</a></li>
                                                }
                                                </ul>
                                        </div>
                                else()
                            }
                            
                            <!--<div>
                                <p class="bold"><pb-i18n key="metadata.biblio">Bibliographie</pb-i18n></p>
                                <p>
                                    { if ($image/following-sibling::tei:figDesc/tei:bibl/tei:bibl)
                                             then $image/following-sibling::tei:figDesc/tei:bibl/tei:bibl
                                         else(<span></span>)
                                    }
                                </p>
                            </div>-->
                            
                            <div>
                                <p class="bold"><pb-i18n key="metadata.credits">Crédits</pb-i18n></p>
                                <p>{$image/following-sibling::tei:figDesc/tei:bibl/tei:availability/tei:licence/text()}</p>
                            </div>
                        </div>
                    </div>
                    
                    <span onclick="this.parentElement.style.display='none'" class="closebtn">X</span>
                </div>
            </div>
};

declare function app:title-engraving($node as node(), $model as map(*)) {
    let $ID := $model?doc
    let $doc := doc($config:data-root || '/' || $ID)
    let $title := $doc//tei:fileDesc/tei:titleStmt/tei:title/text()
    
    return
        <span>{$title}</span>
};