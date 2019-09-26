//
//  ViewController.m
//  Wct_buttonDelaySwizzlingDemo
//
//  Created by Wcting on 2019/9/26.
//  Copyright © 2019年 EJIAJX_wct. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+ButtonDelaySwizzling_h.h"


@interface ViewController ()
@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViews];
}

- (void)loadViews
{
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 100, 100, 200, 50)];
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.layer.cornerRadius = 5;
    self.textField.layer.borderColor = [UIColor grayColor].CGColor;
    self.textField.layer.borderWidth = 0.5;
    self.textField.placeholder = @"测试button延迟实现崩溃";
    
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;

    [self.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:self.textField];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 100, 200, 200, 50)];
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    btn.layer.borderWidth = 0.5;
    
    [btn setTitle:@"疯狂点击无效" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    btn.isNeedDelayClick = YES;//需要延迟点击
    [self.view addSubview:btn];
}

- (void)textFieldChange:(UITextField*)textField
{
    NSLog(@"输入了:%@",textField.text);
}

- (void)buttonAction
{
    NSLog(@"点击了");
}

@end
