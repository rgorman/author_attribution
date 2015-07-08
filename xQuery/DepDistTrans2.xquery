
for $t in //treebank
for $s in $t/sentence
let $w := $s/word

return
<treebank> {$t}
    <sentence
        
        subdoc="{$s/@subdoc}"
        depDist="{
                (sum(for $w in $s/word
                let $wi := data($w/@id)
                let $wh := data($w/@head)
                
                where $wh > 0
                
                return
                    abs($wh - $wi)
                )) div (count($w) - 2)
            }"
        id="{$s/@id}"
        document_id="{$s/@document_id}">
        
        {$w}
    </sentence>
    </treebank>


