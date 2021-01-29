### c++ dev env 

GCC7.5完全支持C++17

gcc-7.5.0.tar.gz
链接: https://pan.baidu.com/s/1fZxsj8RPTYu7-vfQKOkmJQ  密码: eaar

gdb-10.1.tar.gz
链接: https://pan.baidu.com/s/1YICfDBfT-vdARAUjxThcQg  密码: scdq


```
➜ docker run -it --rm researchboy/cppdev:1.0-gcc7.5.0 /bin/sh
sh-4.2# gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/local/gcc7/libexec/gcc/x86_64-pc-linux-gnu/7.5.0/lto-wrapper
Target: x86_64-pc-linux-gnu
Configured with: ../configure --prefix=/usr/local/gcc7 --enable-bootstrap --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-linker-hash-style=gnu --enable-languages=c,c++,go,lto --enable-plugin --enable-initfini-array --disable-libgcj --enable-gnu-indirect-function --with-tune=generic --disable-multilib
Thread model: posix
gcc version 7.5.0 (GCC)
sh-4.2# g++ -v
Using built-in specs.
COLLECT_GCC=g++
COLLECT_LTO_WRAPPER=/usr/local/gcc7/libexec/gcc/x86_64-pc-linux-gnu/7.5.0/lto-wrapper
Target: x86_64-pc-linux-gnu
Configured with: ../configure --prefix=/usr/local/gcc7 --enable-bootstrap --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-linker-hash-style=gnu --enable-languages=c,c++,go,lto --enable-plugin --enable-initfini-array --disable-libgcj --enable-gnu-indirect-function --with-tune=generic --disable-multilib
Thread model: posix
gcc version 7.5.0 (GCC)
sh-4.2# c++ -v
Using built-in specs.
COLLECT_GCC=c++
COLLECT_LTO_WRAPPER=/usr/local/gcc7/libexec/gcc/x86_64-pc-linux-gnu/7.5.0/lto-wrapper
Target: x86_64-pc-linux-gnu
Configured with: ../configure --prefix=/usr/local/gcc7 --enable-bootstrap --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-linker-hash-style=gnu --enable-languages=c,c++,go,lto --enable-plugin --enable-initfini-array --disable-libgcj --enable-gnu-indirect-function --with-tune=generic --disable-multilib
Thread model: posix
gcc version 7.5.0 (GCC)
sh-4.2# gdb -v
GNU gdb (GDB) 10.1
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
sh-4.2# protoc --version
libprotoc 3.14.0
```

### 与vscode 集成远程c++ 开发环境

vscode 安装Remote - Containers 插件

在左下角选择><, 选择Remote-Containers: Attach to running container...  

vscode 为Editor, 编辑调试都在远程的container中;

Reference

[使用 VSCode 远程开发调试](https://www.qikqiak.com/post/use-vscode-remote-dev-debug/)

```
#cmd
strings /usr/lib64/libstdc++.so.6 | grep GLIBC
```

Reference

- [centos7 ./code-server: /lib64/libstdc++.so.6: version `GLIBCXX_3.4.20' not found 解决方法](https://blog.csdn.net/sinat_36008080/article/details/89604382)

- [Centos 7安装protobuf3.6.1](https://www.cnblogs.com/WindSun/p/12543821.html)
