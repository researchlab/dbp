gitbook docker  
--- 

Usage 

base: researchboy/gitbook:latest

1.初始化 GitBook 项目

```
docker run --rm -v "$PWD/gitbook:/gitbook" researchboy/gitbook:latest gitbook init
```

2.构建 GitBook 项目

```
docker run --rm -v "$PWD/gitbook:/gitbook" researchboy/gitbook:latest gitbook build
```

3.启动 GitBook 服务

```
docker run --rm -v "$PWD/gitbook:/gitbook" -p 4000:4000 researchboy/gitbook:latest gitbook serve
```

4.安装gitbook 插件

```
docker run --rm -v "$PWD/gitbook:/gitbook" researchboy/gitbook:latest gitbook install 
```

5.转换成pdf 

```
docker run --rm -v "$PWD/gitbook:/gitbook" researchboy/gitbook:latest gitbook pdf . {output-name}.pdf
# or
docker run --rm -v "$PWD/gitbook:/gitbook" researchboy/gitbook:latest gitbook pdf
```

6.转换成epub

```
docker run --rm -v "$PWD/gitbook:/gitbook" researchboy/gitbook:latest gitbook epub 
```

将gitbook 发布到github pages 

https://yangjh.oschina.io/gitbook/UsingPages.html

转换成pdf 或epub 都需要安装插件

```
InstallRequiredError: "ebook-convert" is not installed.
Install it from Calibre: https://calibre-ebook.com
```

References 
- docs https://docs.gitbook.com/
- gitbook 学习笔记 https://yangjh.oschina.io/gitbook/
