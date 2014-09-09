#! /bin/sh

#根目录
RootDir=`dirname $0`

#加载配置文件
.  $RootDir/config.txt

#加载自动更新SVN脚本
.  $RootDir/script/update_svn.sh

#加载拷贝资源脚本
#.  $RootDir/script/copy_resouce.sh

#加载压缩PNG脚本
#.  $RootDir/script/compress_png.sh

#加载压缩PNG脚本
#.  $RootDir/script/encrypt.sh

#lua脚本编译成字节码
.  $RootDir/script/compile_luajit.sh

#加载编译工程函数库
.  $RootDir/script/build_ipa.sh

function main()
{
	updateSvn
	#copyResource
	#compressPNG
	#encryptPNG
	#encryptTableData
	#complieLuajit
	buildProject
}

main
