#!/usr/bin/env bash

##################################################################
#                                                                #
# Created by Denis Bondarenko <bond.den@gmail.com> on 2017.02.26 #
#                                                                #
##################################################################

function init {
	echo "
	Preparing tests
	"
}

function testDot {
	echo "
	Graphviz Dot installed:
	"
	
	dot -V
	
	echo ""
}

function testJava {
	echo "
	Java installed:
	"
	
	java -version
	
	echo ""
}

function testJq {
	echo "
	Jq installed:
	"
	
	jq --version
	
	echo ""
}

function testXMLStarlet {
	echo "
	XMLStarlet installed:
	"
	
	xmlstarlet --version
	
	echo ""
}

function testGit {
	echo "
	Git installed:
	"
	
	git --version
	
	echo ""
}

init
testJava
testJq
testXMLStarlet
testDot
testGit

