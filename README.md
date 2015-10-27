# ZMMagicalRecordViewer
ZMMagicalRecordViewer可以直接在IOS应用中查看数据库的表及数据.
本工程演示了如何使用ZMMagicalRecordViewer展示数据。
使用说明：
1.将文件夹ZMMagicalRecordViewer添加到工程中，该文件夹包括两个文件，ZMMagicalRecordViewer.h和ZMMagicalRecordViewer.m。
2.启动该功能，在按钮的响应函数中，添加以下代码即可：
ZMMagicalRecordViewer *view = [[ZMMagicalRecordViewer alloc] init];
[self.navigationController pushViewController:view animated:YES];

效果图：
![image](https://github.com/kongcup/ZMConfuse/raw/master/video.gif)
