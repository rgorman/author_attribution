let $t := //treebank
let $c := $t/comment
let $a := $t/annotator
return
    <treebank>{$t/@*}
        <comment>{$c}</comment>
        <annotator>{$a}</annotator>
{
for $s in //sentence
order by $s/@depDist
return
    $s }
</treebank>