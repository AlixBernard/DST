#!/usr/bin/env bash

##################################################################
#                                                                #
# Created by Denis Bondarenko <bond.den@gmail.com> on 2017.02.26 #
#                                                                #
##################################################################

# Installs dependecies used in DST course tasks solving

function setRepos {

	epelRpm=epel-release-latest-6.noarch.rpm
	iusRpm=ius-release.rpm

	for i in "https://dl.fedoraproject.org/pub/epel/$epelRpm" "https://centos6.iuscommunity.org/$iusRpm"
	do

		curl -L -o '.tmprpo.rpm' "$i"
		sudo rpm -ivh './.tmprpo.rpm'
		unlink './.tmprpo.rpm'

	done

	sudo yum clean all
	sudo yum update

}

function installGit {

	# 1. install dev deps

	echo 'Installing dependencies'

	sudo yum update
	sudo yum groupinstall 'Development Tools'
	sudo yum install -y gettext unzip gcc gcc-c++ make openssl-devel curl-devel expat-devel perl-devel

	# 2. download src

	echo 'Downloading the actual sources'

	# get the latest version from:
	# https://github.com/git/git/releases

	lastVersion=2.12.0
	srcUrl="https://github.com/git/git/archive/v$lastVersion.zip"

	echo "Last version: $lastVersion"

	wget $srcUrl -O git.zip

	# 3. build

	echo 'Building'

	unzip git.zip
	cd git-*

	make prefix=/usr/local all
	sudo make prefix=/usr/local install

	echo 'Ready'

	echo '
	To update Git use:
	git clone https://github.com/git/git.git
	make prefix=/usr/local all
	sudo make prefix=/usr/local install
	'

}

function installJq {

	v='1.5'

	t='/bin/jq'
	sudo curl -L -o "$t" "https://github.com/stedolan/jq/releases/download/jq-$v/jq-linux64"
	sudo chmod 755 "$t"

	cDir="$PWD"

	sudo yum install oniguruma autoconf
	curl -L -O http://ftp.gnu.org/gnu/autoconf/autoconf-latest.tar.xz
	tar -xvf autoconf-latest.tar.xz
	cd autoconf-2.69
	./configure
	make
	sudo make install
	
	cd "$cDir"
	
	curl -L -O http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz
	tar -xvf utomake-1.15.tar.gz
	cd utomake-1.15
	./configure
	make
	sudo make install
	
	cd "$cDir"
	
#	git clone https://github.com/stedolan/jq.git
#	cd jq
#	autoreconf -i
#	./configure
#	make -j8
#	make check
#	make LDFLAGS=-all-static
#	sudo make install
	 
#	cd "$cDir"

}

function installJava {

	echo 'Installing Java'
	v='8u121'
	
	cd ~
	wget --no-cookies --no-check-certificate \
	--header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
	"http://download.oracle.com/otn-pub/java/jdk/$v-b13/e9e7ea248e2c4826b92b3f075a80e441/jre-$v-linux-x64.rpm"
	
	sudo yum localinstall "jre-$v-linux-x64.rpm"
	rm "$HOME/jre-$v-linux-x64.rpm"
	
	sudo alternatives --config java
	# 
	
}

function updatePython2 {

	sudo yum update
	sudo yum install scl-utils
	sudo yum install centos-release-scl-rh
	sudo yum install python27
	sudo scl enable python27 bash
	export PYTHONPATH="/usr/lib/python2.7/site-packages/":$PYTHONPATH

}

# setRepos
# installGit
# installJq
# installJava
updatePython2


