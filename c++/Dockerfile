FROM centos:centos7.6.1810

MAINTAINER lihong leehongitrd@163.com

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

ADD gcc-7.5.0.tar.gz /opt/
ADD gdb-10.1.tar.gz /opt/ 

RUN  yum -y install bzip2 wget gcc gcc-c++ gmp-devel mpfr-devel libmpc-devel make cmake autoconf automake libtool which zlib zlib-devel texinfo  && yum clean all && \
#      wget -P /opt/ https://ftp.gnu.org/gnu/gcc/gcc-7.5.0/gcc-7.5.0.tar.gz && \
#			 wget -P /opt/ http://ftp.gnu.org/gnu/gdb/gdb-10.1.tar.gz && \
#		   cd /opt/ && tar -zxvf gcc-7.5.0.tar.gz && tar -xzvf gdb-10.1.tar.gz && \
		   wget -P /opt/ https://github.com/google/googletest/archive/release-1.10.0.tar.gz && \
			 wget -P /opt/ https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/protobuf-all-3.14.0.tar.gz && \
		   # install gcc
		   cd /opt/gcc-7.5.0 && \
			 ./contrib/download_prerequisites  && mkdir gcc-build-7.5 &&  cd gcc-build-7.5 && \
			 ../configure --prefix=/usr/local/gcc7 --enable-bootstrap --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-linker-hash-style=gnu --enable-languages=c,c++,go,lto --enable-plugin --enable-initfini-array --disable-libgcj --enable-gnu-indirect-function --with-tune=generic --disable-multilib && \
			 make -j4  && make install  && \ 
       # install gdb 
			 cd /opt/gdb-10.1 && \
				 ./configure && make && make install && \
       ln -sf /usr/local/gcc7/bin/gcc /usr/bin/gcc && \
       ln -sf /usr/local/gcc7/bin/g++ /usr/bin/g++ && \
       ln -sf /usr/local/gcc7/bin/c++ /usr/bin/c++ && \
       ln -sf /usr/local/gcc7/include/c++/7.5.0 /usr/include/c++/7.5.0 && \
       ln -sf /usr/local/gcc7/lib64/libstdc++.so.6.0.24 /usr/lib64/libstdc++.so.6 && \
			 ln -sf /usr/local/gcc7/lib64/libstdc++.so.6.0.24 /lib64/libstdc++.so.6 && \
       # install gtest
			 cd /opt/ && tar -xvf release-1.10.0.tar.gz && \
			 cd /opt/googletest-release-1.10.0 && cmake -DCMAKE_CXX_COMPILER=$(which g++) -DCMAKE_C_COMPILER=$(which gcc) CMakeLists.txt && \
			 make && make install && \
       # install protobuf
			 # reference https://www.cnblogs.com/WindSun/p/12543821.html
			 cd /opt/ && tar zxvf protobuf-all-3.14.0.tar.gz  && \
			 cd /opt/protobuf-3.14.0/ && ./autogen.sh && ./configure && make && make install && protoc --version && \
			 echo "/usr/local/lib" >> /etc/ld.so.conf && ldconfig  && \
	
       # clean
			 rm -rf /opt/gcc-7.5.0 && \
			 rm -rf /opt/gdb-10.1 && \
			 rm -rf /opt/googletest-release-1.10.0 && \
			 rm -rf /opt/protobuf-3.14.0 
