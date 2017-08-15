//
//  FileMananer.m
//  NashShopping
//
//  Created by 郭榜 on 2017/8/9.
//  Copyright © 2017年 com.test.work. All rights reserved.
//

#import "FileMananer.h"

@interface FileMananer()
{
    UIViewController *viewController;
}
@end
@implementation FileMananer

+(instancetype)sharedInstance {
    
    static FileMananer *fileMananer = nil;
    if (! fileMananer)
    {
        fileMananer = [[self alloc] init];
    }
    return fileMananer;
}



-(void)writeLogMessageToTXT:(NSString *) message {
    
    NSString *filePath = [self getFilePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if(![fileManager fileExistsAtPath:filePath]) //如果不存在
    {
        NSString *str = @"LogMessage\n";
        [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
    }
//文件格式按照个人需求修改
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *str = [NSString stringWithFormat:@"\n%@\n%@",datestr,message];
    NSData* stringData  = [str dataUsingEncoding:NSUTF8StringEncoding];
    [fileHandle writeData:stringData]; //追加写入数据
    [fileHandle closeFile];
    
    
}

//沙盒文件路径
-(NSString *)getFilePath {
    
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *homePath = [paths objectAtIndex:0];
//    文件类型
    NSString *filePath = [homePath stringByAppendingPathComponent:@"log.text"];

    return filePath;
}
//发送邮件
-(void)sendEmailToUsers:(UIViewController *) vc {
    viewController = vc;
    if ([MFMailComposeViewController canSendMail] == YES) {
        
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        //  设置代理(与以往代理不同,不是"delegate",千万不能忘记呀,代理有3步)
        mailVC.mailComposeDelegate = self;
        //  收件人 可添加抄送 附件等
        NSArray *sendToPerson = @[@"guobang@nash.work"];
        [mailVC setToRecipients:sendToPerson];
        
        NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *homePath = [paths objectAtIndex:0];
        
        NSString *filePath = [homePath stringByAppendingPathComponent:@"log.text"];
        NSData* data = [NSData dataWithContentsOfFile:filePath];
        [mailVC addAttachmentData:data mimeType:@"txt" fileName:@"log.txt"];
        //  主题
        [mailVC setSubject:@"百宝门开锁LOG"];
        [mailVC setMessageBody:@"百宝门开锁LOG查看" isHTML:YES];
        [vc presentViewController:mailVC animated:YES completion:^{
            
            
        }];
    }else{
        
        NSLog(@"此设备不支持邮件发送");
        
    }
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: Mail sending canceled");  // 邮件发送取消
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: Mail saved");  // 邮件保存成功
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: Mail sent");  // 邮件发送成功
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: Mail sending failed");  // 邮件发送失败
            break;
        default:
            NSLog(@"Result: Mail not sent");
            break;
    }
    
    [viewController dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}


@end
