//
//  ViewController.m
//  LSNotificationCenter01
//
//  Created by 李山 on 16/8/5.
//  Copyright © 2016年 lishan. All rights reserved.
//

#import "ViewController.h"
#import "LSNotificationCenterHeader.h"
#define TEXTString @"textStr"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITextField *messageText;

@property (weak, nonatomic) IBOutlet UIButton *sendMessageBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [LSNotificationCenter notificationCenterAddObserver:self
                                               NewsName:@"TextChange"
                                               Selector:@selector(showChangeText:)];
    
}
- (void) showChangeText:(LSNotification *)notification
{
    self.messageLabel.text = notification.userInfoDict[TEXTString];
}

- (IBAction)sendMessageBtnClick:(id)sender {
    [LSNotificationCenter postNews:@{TEXTString:self.messageText.text} NewsName:@"TextChange"];
}

- (IBAction)removeBtnClick:(id)sender {
    [LSNotificationCenter removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
