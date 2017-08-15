//
//  FileMananer.h
//  NashShopping
//
//  Created by 郭榜 on 2017/8/9.
//  Copyright © 2017年 com.test.work. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <Messages/Messages.h>
#import<MessageUI/MFMailComposeViewController.h>

@interface FileMananer : NSObject<MFMailComposeViewControllerDelegate>

+(instancetype)sharedInstance;
-(void)writeLogMessageToTXT:(NSString *) message;
-(void)sendEmailToUsers:(UIViewController *) vc;

@end
