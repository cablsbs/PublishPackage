#!/bin/sh

#svn代码目录
SvnPath_Code=$SVN_Code
#svn资源目录
#SvnPath_Resource=$SVN_Resource

function updateSvn()
{
	echo  "-------Start Update Svn : " $SvnPath_Code " ---------------"
	svn update $SvnPath_Code
	echo  "-------End   Update Svn ---------------"
}

