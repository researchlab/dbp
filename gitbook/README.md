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

将gitbook 发布到github pages 

https://yangjh.oschina.io/gitbook/UsingPages.html

References 
- docs https://docs.gitbook.com/
- gitbook 学习笔记 https://yangjh.oschina.io/gitbook/
