for $s in //sentence

return <sentence StndRef="Sophocles Ajax" id="{$s/@id}"  document_id="{$s/@document_id}">

{for $w in $s/word
let $wr := data($w/@relation)
let $wp := data($w/@postag)
let $wl := data($w/@lemma)
let $o := $w/parent::sentence/word[@id = $w/@head]
let $or :=data($o/@relation)
let $op :=data($o/@postag)
let $ol := data($o/@lemma)
let $p := $w/parent::sentence/word[@id = $o/@head]
let $pr := data($p/@relation)
let $pp := data($p/@postag)
let $pl := data($p/@lemma)
let $q := $w/parent::sentence/word[@id = $p/@head]
let $qr := data($q/@relation)
let $qp := data($q/@postag) 
let $ql := data($q/@lemma)
let $r := $w/parent::sentence/word[@id = $q/@head]
let $rr := data($r/@relation)
let $rp := data($r/@postag)
let $rl := data($r/@lemma)
let $a := $w/parent::sentence/word[@id = $r/@head]
let $ar := data($a/@relation)
let $ap := data($a/@postag)
let $al := data($a/@lemma)
let $b := $w/parent::sentence/word[@id = $a/@head]
let $br := data($b/@relation)
let $bp := data($b/@postag)
let $bl := data($b/@lemma)
let $c := $w/parent::sentence/word[@id = $b/@head]
let $cr := data($c/@relation)
let $cp := data($c/@postag)
let $cl := data($c/@lemma)
let $d := $w/parent::sentence/word[@id = $c/@head]
let $dr := data($d/@relation)
let $dp := data($d/@postag)
let $dl := data($d/@lemma)
let $e := $w/parent::sentence/word[@id = $d/@head]
let $er := data($e/@relation)
let $ep := data($e/@postag)
let $el := data($e/@lemma)
let $f := $w/parent::sentence/word[@id = $e/@head]
let $fr := data($f/@relation)
let $fp := data($f/@postag)
let $fl := data($f/@lemma)

let $g := $w/parent::sentence/word[@id = $f/@head]
let $gr := data($g/@relation)
let $gp := data($g/@postag)
let $gl := data($g/@lemma)

let $h := $w/parent::sentence/word[@id = $g/@head]
let $hr := data($h/@relation)
let $hp := data($h/@postag)

let $i := $w/parent::sentence/word[@id = $h/@head]
let $ir := data($i/@relation)
let $ip := data($i/@postag)

let $j := $w/parent::sentence/word[@id = $i/@head]
let $jr := data($j/@relation)
let $jp := data($j/@postag)

let $k := $w/parent::sentence/word[@id = $j/@head]

let $aa := $w/parent::sentence/word[@id = $k/@head]
let $ab := $w/parent::sentence/word[@id = $aa/@head]
let $ac := $w/parent::sentence/word[@id = $ab/@head]
let $ad := $w/parent::sentence/word[@id = $ac/@head]
let $ae := $w/parent::sentence/word[@id = $ad/@head]
let $af := $w/parent::sentence/word[@id = $ae/@head]
let $ag := $w/parent::sentence/word[@id = $af/@head]


return <sword> {$wr};{substring($wp, 1, 1)}*{$or};{substring($op, 1, 1)}*{$pr};{substring($pp, 1, 1)}*{$qr};{substring($qp, 1, 1)}*{$rr};{substring($rp, 1, 1)}*{$ar};{substring($ap, 1, 1)}*{$br};{substring($bp, 1, 1)}*{$cr};{substring($cp, 1, 1)}*{$dr};{substring($dp, 1, 1)}*{$er};{substring($ep, 1, 1)}*{$fr};{substring($fp, 1, 1)}*{$gr};{substring($gp, 1, 1)}*{$hr};{substring($hp, 1, 1)}*{$ir};{substring($ip, 1, 1)}#</sword> }

</sentence>

