for $s in //sentence

return <sentence id="{$s/@id}"  document_id="{$s/@document_id}">

{for $w in $s/word
let $wr := data($w/@relation)
let $o := $w/parent::sentence/word[@id = $w/@head]
let $or :=data($o/@relation)
let $p := $w/parent::sentence/word[@id = $o/@head]
let $pr := data($p/@relation)
let $q := $w/parent::sentence/word[@id = $p/@head]
let $qr := data($q/@relation)
let $r := $w/parent::sentence/word[@id = $q/@head]
let $rr :=data($r/@relation)
let $a := $w/parent::sentence/word[@id = $r/@head]
let $ar := data($a/@relation)
let $b := $w/parent::sentence/word[@id = $a/@head]
let $br := data($b/@relation)
let $c := $w/parent::sentence/word[@id = $b/@head]
let $cr := data($c/@relation)
let $d := $w/parent::sentence/word[@id = $c/@head]
let $dr := data($d/@relation)
let $e := $w/parent::sentence/word[@id = $d/@head]
let $er := data($e/@relation)
let $f := $w/parent::sentence/word[@id = $e/@head]
let $fr := data($f/@relation)
let $g := $w/parent::sentence/word[@id = $f/@head]
let $gr := data($g/@relation)
let $h := $w/parent::sentence/word[@id = $g/@head]
let $i := $w/parent::sentence/word[@id = $h/@head]
let $j := $w/parent::sentence/word[@id = $i/@head]
let $k := $w/parent::sentence/word[@id = $j/@head]

let $aa := $w/parent::sentence/word[@id = $k/@head]
let $ab := $w/parent::sentence/word[@id = $aa/@head]
let $ac := $w/parent::sentence/word[@id = $ab/@head]
let $ad := $w/parent::sentence/word[@id = $ac/@head]
let $ae := $w/parent::sentence/word[@id = $ad/@head]
let $af := $w/parent::sentence/word[@id = $ae/@head]
let $ag := $w/parent::sentence/word[@id = $af/@head]


return <sword> {$wr}-{$or}-{$pr}-{$qr}-{$rr}-{$ar}-{$br}-{$cr}-{$dr}-{$er}-{$fr}-{$gr}-# </sword> }

</sentence>

