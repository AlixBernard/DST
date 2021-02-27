#!/usr/bin/env gawk

BEGIN {
	
	FS=";"
	nodes=""
	edges=""
	
	print "digraph G {\n\trankdir=BT;"
	print "\tedge [arrowhead=diamond];"
	
}
/^[\s\t]*$/ {
	next
}
{
	
	nodes=nodes"\n\tn"$1" [label=\""$2"\"];";
	if($3 != "0")edges=edges"\n\tn"$1" -> n"$3";";
	
}
END {

	print nodes;
	print edges;
	print "\n}"
	
}
