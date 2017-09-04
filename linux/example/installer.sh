#!/bin/sh
#author kaloquan@163.com

save_dir=$(cd;pwd)/downloads
tar_dir=$(cd;pwd)/programs

jdk_url=http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
maven_url=http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
tomcat_url=http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.16/bin/apache-tomcat-8.5.16.tar.gz

jdk_java_home=$tar_dir/jdk1.8.0_131
jdk_class_path=$jdk_java_home/lib/dt.jar:$jdk_java_home/lib/tools.jar
jdk_path=$jdk_java_home/jre/bin:$jdk_java_home/bin

maven_home=$tar_dir/apache-maven-3.5.0
maven_path=$maven_home/bin

function install(){
	echo "###===步骤1：下载软件包===###"
	echo "文件将被下载到$save_dir中"

	if [ ! -d $save_dir ] ; then
			echo "没检测到你的下载目录，将为你自动创建"
			mkdir -p $save_dir
	fi

	echo "======================================="
	echo "开始下载$(basename $jdk_url)" 
	echo "======================================="
	wget -P $save_dir --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $jdk_url

	echo "======================================="
	echo "开始下载$(basename $maven_url)"
	echo "======================================="
	wget -P $save_dir $maven_url

	echo "======================================="
	echo "开始下载$(basename $tomcat_url)"
	echo "======================================="
	wget -P $save_dir $tomcat_url

	echo "###===步骤2：解压软件包===###"
	echo "文件将被解压到$tar_dir中"

	if [ ! -d $tar_dir ] ; then
		echo "没检测到你的解压目录，将为你自动创建"
		mkdir -p $tar_dir
	fi

	echo "======================================="
	echo "解压$(basename $jdk_url)"
	echo "======================================="
	tar -zxf $save_dir/$(basename $jdk_url) -C $tar_dir

	echo "======================================="
	echo "解压$(basename $maven_url)"
	echo "======================================="
	tar -zxf $save_dir/$(basename $maven_url) -C $tar_dir

	echo "======================================="
	echo "解压$(basename $tomcat_url)"
	echo "======================================="
	tar -zxf $save_dir/$(basename $tomcat_url) -C $tar_dir

	echo "======================================="
	echo "导入环境变量"
	echo "======================================="
	echo "export JAVA_HOME=$jdk_java_home" > /etc/profile.d/setenv.sh
	echo "export CLASSPATH=$jdk_class_path" >> /etc/profile.d/setenv.sh
	echo "" >> /etc/profile.d/setenv.sh
	echo "export MAVEN_HOME=$maven_home" >> /etc/profile.d/setenv.sh
	echo "export PATH=$PATH:$jdk_path:$maven_path" >> /etc/profile.d/setenv.sh

        export JAVA_HOME=$jdk_java_home
        export CLASSPATH=$jdk_class_path
        export MAVEN_HOME=$maven_home
        export PATH=$PATH:$jdk_path:$maven_path
}

function remove(){
	rm -rf $save_dir/$(basename $jdk_url)
	rm -rf $save_dir/$(basename $maven_url)
	rm -rf $save_dir/$(basename $tomcat_url)
	
	rm -rf $tar_dir/jdk1.8.0_131
	rm -rf $tar_dir/apache-maven-3.5.0
	rm -rf $tar_dir/apache-tomcat-8.5.16

	unset JAVA_HOME
	unset CLASSPATH
	unset MAVEN_HOME

	rm -rf /etc/profile.d/setenv.sh
}

option=$1

if [ "$option" = "install" ] ; then
	install
elif [ "$option" = "remove" ] ; then
	remove
else 
	exit
fi
