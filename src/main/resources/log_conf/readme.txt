系统日志输出，日志组件切换：

当前日志配置:
log4j.properties

若要更换为slf4j+logback日志组件实现日志输出，操作如下：
使用：logback-classic-0.9.26.jar、logback-core-0.9.26.jar、slf4j-api-1.6.1.jar替换log4j.jar,
将logback.xml放入src根目录下,slf4j_conf.properties不动，
若移动slf4j_conf.properties到跟目录下，则修改logback.xml中的<property resource="slf4j_conf.properties"/>