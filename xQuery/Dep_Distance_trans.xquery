for $s in //sentence
let $sw := $s/word
let $swc := count($sw)
let $wi := data($sw/@id)
let $wh := data($sw/@head)
let $dd := $wh - $wi


return
    <sentence
        
        subdoc="{$s/@subdoc}"
        DepDist=" "
        id="{$s/@id}"
        document_id="{$s/@document_id}">
        
        (: {
            for $w in $s/word
            let $wi := data($w/@id)
            let $wh := data($w/@head)
            let $dd := $wh - $wi
            
            let $dda := abs($dd)
            let $sdd := count($w)
            
            where $wh > 0
            
            
            return
                <DepDist></DepDist>
        } :)
        {$swc}
    </sentence>

