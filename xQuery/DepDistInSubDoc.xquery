let $t := //treebank
let $c := $t/comment
let $a := $t/annotator
return
    <treebank>{$t/@*}
        <comment>{$c}</comment>
        <annotator>{$a}</annotator>
        {
            for $s in //sentence
            let $w := $s/word
            return
                <sentence
                    id="{$s/@id}"
                    document_id="{$s/@document_id}"
                    subdoc="{$s/@subdoc} DepDist {round-half-to-even($s/@depDist, 3)}"
                    span="{$s/@span}">
                    
                    {$w}
                </sentence>}
    </treebank>

