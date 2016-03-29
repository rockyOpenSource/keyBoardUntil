//
//  ViewController.m
//  键盘处理事件
//
//  Created by qishang on 16/3/29.
//  Copyright © 2016年 Rocky. All rights reserved.
//

#import "ViewController.h"
#import "ZYKeyboardUtil.h"

#define MARGIN_KEYBOARD 20

@interface ViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *testTF;
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUntil;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testTF.delegate = self;
    [self configKeyBoardRespond];
}

- (void)configKeyBoardRespond {
    self.keyboardUntil = [[ZYKeyboardUtil alloc] init];
    
    __weak ViewController *weakSelf = self;
    
    //自定义键盘弹出处理
#pragma explain - use animateWhenKeyboardAppearAutomaticAnimBlock, animateWhenKeyboardAppearBlock must be nil.
    /*
     [_keyboardUtil setAnimateWhenKeyboardAppearBlock:^(int appearPostIndex, CGRect keyboardRect, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement) {
     
     NSLog(@"\n\n键盘弹出来第 %d 次了~  高度比上一次增加了%0.f  当前高度是:%0.f"  , appearPostIndex, keyboardHeightIncrement, keyboardHeight);
     
     //处理
     UIWindow *window = [UIApplication sharedApplication].keyWindow;
     CGRect convertRect = [weakSelf.mainTextField.superview convertRect:weakSelf.mainTextField.frame toView:window];
     
     if (CGRectGetMinY(keyboardRect) - MARGIN_KEYBOARD < CGRectGetMaxY(convertRect)) {
     CGFloat signedDiff = CGRectGetMinY(keyboardRect) - CGRectGetMaxY(convertRect) - MARGIN_KEYBOARD;
     //updateOriginY
     CGFloat newOriginY = CGRectGetMinY(weakSelf.view.frame) + signedDiff;
     weakSelf.view.frame = CGRectMake(weakSelf.view.frame.origin.x, newOriginY, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
     }
     }];
     */
    
    
    //全自动键盘弹出处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
#pragma explain - use animateWhenKeyboardAppearBlock, animateWhenKeyboardAppearAutomaticAnimBlock will be invalid.
    [_keyboardUntil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.testTF, nil];
    }];
    
    
    //自定义键盘收起处理(如不配置，则默认启动自动收起处理)
#pragma explain - if not configure this Block, automatically itself.
    /*
     [_keyboardUtil setAnimateWhenKeyboardDisappearBlock:^(CGFloat keyboardHeight) {
     NSLog(@"\n\n键盘在收起来~  上次高度为:+%f", keyboardHeight);
     
     //uodateOriginY
     CGFloat newOriginY = 0;
     weakSelf.view.frame = CGRectMake(weakSelf.view.frame.origin.x, newOriginY, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
     }];
     
     */
    
    //获取键盘信息
    [_keyboardUntil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
        NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
    }];
}
#pragma mark delegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.testTF resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.testTF resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
