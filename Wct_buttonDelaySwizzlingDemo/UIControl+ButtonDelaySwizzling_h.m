//
//  UIControl+ButtonDelaySwizzling_h.m
//  MobileFixCar
//
//  Created by Wcting on 2019/9/25.
//  Copyright © 2019年 全球e家电子商务有限公司. All rights reserved.
//

#import "UIControl+ButtonDelaySwizzling_h.h"
#import "objc/runtime.h"

static const void *timeInteralOfClickButtonKey = &timeInteralOfClickButtonKey;

static const void *timeInteralEventLastTimeKey = &timeInteralEventLastTimeKey;

static const void *isNeedDelayClickKey = &isNeedDelayClickKey;

@implementation UIControl (ButtonDelaySwizzling_h)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSel = @selector(sendAction:to:forEvent:);
        SEL swizzlingSel = @selector(em_sendAction:to:forEvent:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSel);
        Method swizzlingMethod = class_getInstanceMethod(class, swizzlingSel);
        
        BOOL isAddMethod = class_addMethod(class, swizzlingSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
        if (isAddMethod) {
            class_replaceMethod(class, originalSel, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzlingMethod);
        }
        
        
    });
}

-(void)em_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([self isKindOfClass:[UIButton class]]) {//wct20190925 textfield输入时候崩溃添加判断，只管理button的点击事件
        if (self.isNeedDelayClick) {//需要延迟点击
            
            if (self.timeInteralOfClickButton <= 0) {//没设置时间间隔，默认为0.4秒
                self.timeInteralOfClickButton = 0.4;
            }
            
            //当前时间减上次点击时间，间隔大于规定时间间隔，button可点击
            BOOL isCanAction = NSDate.date.timeIntervalSince1970 - self.timeInteralEventLastTime >= self.timeInteralOfClickButton;
            
            if (self.timeInteralOfClickButton > 0) {//更新当前点击时间
                self.timeInteralEventLastTime = NSDate.date.timeIntervalSince1970;
            }
            
            if (isCanAction) {
                [self em_sendAction:action to:target forEvent:event];
            }
        }else{
            [self em_sendAction:action to:target forEvent:event];
        }
    }else{
        [self em_sendAction:action to:target forEvent:event];
    }
    
}

#pragma mark - association
-(void)setTimeInteralOfClickButton:(NSTimeInterval)timeInteralOfClickButton
{
    objc_setAssociatedObject(self, timeInteralOfClickButtonKey, @(timeInteralOfClickButton), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)timeInteralOfClickButton
{
    return [objc_getAssociatedObject(self, timeInteralOfClickButtonKey) doubleValue];
}

-(void)setTimeInteralEventLastTime:(NSTimeInterval)timeInteralEventLastTime
{
    objc_setAssociatedObject(self, timeInteralEventLastTimeKey, @(timeInteralEventLastTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)timeInteralEventLastTime
{
    return [objc_getAssociatedObject(self, timeInteralEventLastTimeKey) doubleValue];
}

-(void)setIsNeedDelayClick:(BOOL)isNeedDelayClick
{
    objc_setAssociatedObject(self, isNeedDelayClickKey, @(isNeedDelayClick), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isNeedDelayClick
{
    return [objc_getAssociatedObject(self, isNeedDelayClickKey) boolValue];
}

@end
