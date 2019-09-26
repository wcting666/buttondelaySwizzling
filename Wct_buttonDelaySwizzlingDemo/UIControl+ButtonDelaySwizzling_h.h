//
//  UIControl+ButtonDelaySwizzling_h.h
//  MobileFixCar
//
//  Created by Wcting on 2019/9/25.
//  Copyright © 2019年 全球e家电子商务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 wct20190925 通过runtime swizzling特性，操作UIButton的点击方法sendAction:to:forEvent:，限制重复点击问题;
 这里为什么用UIControl呢？因为替换方法是sendAction:to:forEvent:方法，这个方法是controller的方法，且UITextfield的代理方法也是通过这个
 方法实现的。如果用UIButton的分类(原来实现方式)，在UITextfield输入的时候会因为找不到方法而崩溃；
 而UIButton和UITextfield等使用到sendAction:to:forEvent:方法的类都继承自UIControl，所以通过UIControl分类实现UIButton的重复点击拦截，内部只需一个类判断就行。
 如：[self isKindOfClass:[UIButton class]]
 */
@interface UIControl (ButtonDelaySwizzling_h)

@property (nonatomic, assign) NSTimeInterval timeInteralOfClickButton;/**<wct20190925 点击时间间隔，默认0.4s，在该时间间隔内点击btn无效*/

@property (nonatomic, assign) NSTimeInterval timeInteralEventLastTime;/**<wct20190925 上次事件时间，时间戳*/

@property (nonatomic, assign) BOOL isNeedDelayClick;/**<wct20190925 是否需要防止f重复点击*/

@end

NS_ASSUME_NONNULL_END
