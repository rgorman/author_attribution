
for $t in //treebank
let $c := $t/comment
let $a := $t/annotator


return
    <DepDist_document>
    <treebank xml:lang="{$t/@xml:lang}" format="{$t/@format}" version="{$t/@version}">
        {$c} 
        {$a}
        {for $s in $t/sentence
let $w := $s/word
return
        <sentence
            id="{$s/@id}"
            document_id="{$s/@document_id}"
            subdoc="{$s/@subdoc}"
            span="{$s/@span}"
            depDist="{
                    (sum(for $w in $s/word
                    let $wi := data($w/@id)
                    let $wh := data($w/@head)
                    
                    where $wh > 0
                    
                    return
                        abs($wh - $wi)
                    )) div (count($w) - 1)
                }"
            >
            
            {$w}
        </sentence>}
        </treebank>
    </DepDist_document>


