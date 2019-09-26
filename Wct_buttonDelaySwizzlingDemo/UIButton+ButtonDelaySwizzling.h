//
//  UIButton+ButtonDelaySwizzling.h
//  Wct_buttonDelaySwizzlingDemo
//
//  Created by Wcting on 2019/9/26.
//  Copyright © 2019年 EJIAJX_wct. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
想测试崩溃，把UIControl的b代码注释，把此类的注释解开
 */
@interface UIButton (ButtonDelaySwizzling)

@property (nonatomic, assign) NSTimeInterval timeInteralOfClickButton;/**<wct20190925 点击时间间隔，默认0.4s，在该时间间隔内点击btn无效*/

@property (nonatomic, assign) NSTimeInterval timeInteralEventLastTime;/**<wct20190925 上次事件时间，时间戳*/

@property (nonatomic, assign) BOOL isNeedDelayClick;/**<wct20190925 是否需要防止f重复点击*/

@end
NS_ASSUME_NONNULL_END
