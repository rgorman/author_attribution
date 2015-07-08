let $t := //treebank
let $c := $t/comment
let $a := $t/annotator

 return <treebank>{$t/@*} 
 <comment>{$c}</comment>
 <annotator>{$a}</annotator>
{for $s in //sentence
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
                )) div (count($w) - (for $w in $s/word
                return
                count($w[@head = 0])))
            }"
        >
        
        {$w}
    </sentence>
   } </treebank> 


