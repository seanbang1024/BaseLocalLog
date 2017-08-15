//
//  ViewController.m
//  BaseLocalLog
//
//  Created by 郭榜 on 2017/8/15.
//  Copyright © 2017年 com.Mad_bg.init. All rights reserved.
//

#import "ViewController.h"
#import "FileMananer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    注意：
//        发送邮件需要用真机测试，因用苹果手机自带软件：邮件， 需要先把你自己邮箱登录，然后才能发送成功，否则会提示没发邮件权限
    
    
#if DEBUG
//写入log文件
    [[FileMananer sharedInstance] writeLogMessageToTXT:@"当前VC：。。。  方法：viewDidLoad  是否成功：。。。   原因：。。。  等，格式自己定义"];
//在debug模式下，创建发送邮件按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
#endif
    
    
}

-(void)testAction {
//    发送log到指定邮箱
    [[FileMananer sharedInstance] sendEmailToUsers:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
