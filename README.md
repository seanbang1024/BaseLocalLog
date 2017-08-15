# BaseLocalLog
iOS记录log

使用步骤
1.添加MessageUI.framework
2.在需要的地方引入 #import "FileMananer.h"
3. //写入log日志
     -(void)writeLogMessageToTXT:(NSString *) message;
   //发送邮件到指定邮箱
     -(void)sendEmailToUsers:(UIViewController *) vc;
注意：
    发送邮件需要用真机测试，因用苹果手机自带软件：邮件， 需要先把你自己邮箱登录，然后才能发送成功，否则会提示没发邮件权限
  
