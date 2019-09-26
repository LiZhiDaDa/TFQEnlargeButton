//
//  UIButton+TFQClickArea.m
//  TFQTabelView
//
//  Created by 王立志 on 2019/9/17.
//  Copyright © 2019 Thread_Fight_Queue. All rights reserved.
//

#import "UIButton+TFQClickArea.h"
#import <objc/runtime.h>
#import "TFQClickAreaButton.h"

//用static修饰，防止与当前项目中重名的变量冲突
static char *TFQClickEdgeInsets = "clickEdgeInsets";
static char *TFQClickScale = "clickScale";
static char *TFQClickWidthScale = "clickWidthScale";
static char *TFQClickHeightScale = "clickHeightScale";
static char *TFQShowClickArea = "showClickArea";

@implementation UIButton (TFQClickArea)

//因为分类是不能给原来的类添加属性的，所以我们要手动实现属性的set、get方法
#pragma mark - set method
- (void)setClickEdgeInsets:(UIEdgeInsets)clickEdgeInsets{
    NSValue *value = [NSValue value:&clickEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, TFQClickEdgeInsets, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setClickScale:(CGFloat)clickScale{
    objc_setAssociatedObject(self, TFQClickScale, @(clickScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(clickScale <= 1){
        return;
    }
    clickScale -= 1;
    CGFloat width = self.bounds.size.width * clickScale;
    CGFloat height = self.bounds.size.height * clickScale;
    self.clickEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
}

- (void)setClickWidthScale:(CGFloat)clickWidthScale{
    objc_setAssociatedObject(self, TFQClickWidthScale, @(clickWidthScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(clickWidthScale <= 1){
        return;
    }
    clickWidthScale -= 1;
    CGFloat width = self.bounds.size.width * clickWidthScale;
    CGFloat height = self.bounds.size.height;
    self.clickEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
}

- (void)setClickHeightScale:(CGFloat)clickHeightScale{
    objc_setAssociatedObject(self, TFQClickHeightScale, @(clickHeightScale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(clickHeightScale <= 1){
        return;
    }
    clickHeightScale -= 1;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height * clickHeightScale;
    self.clickEdgeInsets = UIEdgeInsetsMake(-height, -width,-height, -width);
}

- (void)setShowClickArea:(BOOL)showClickArea{
    objc_setAssociatedObject(self, TFQShowClickArea, @(showClickArea), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//其实我们只需要实现属性的set方法就可以满足需求了，但是我们还是提供get方法用来方便我们打印数据
#pragma mark - get method
- (UIEdgeInsets)clickEdgeInsets{
    NSValue *value = objc_getAssociatedObject(self, TFQClickEdgeInsets);
    UIEdgeInsets edgeInsets;
    [value getValue:&edgeInsets];
    return value ? edgeInsets : UIEdgeInsetsZero;
}

- (CGFloat)clickScale{
    return [objc_getAssociatedObject(self, TFQClickScale) floatValue];
}

- (CGFloat)clickWidthScale{
    return [objc_getAssociatedObject(self, TFQClickWidthScale) floatValue];
}

- (CGFloat)clickHeightScale{
    return [objc_getAssociatedObject(self, TFQClickHeightScale) floatValue];
}

- (BOOL)showClickArea{
    return [objc_getAssociatedObject(self, TFQShowClickArea) intValue];
}

#pragma mark - system method
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if(!self.showClickArea){
        return;
    }
    TFQClickAreaButton *btn = [[TFQClickAreaButton alloc] init];
    if(UIEdgeInsetsEqualToEdgeInsets(self.clickEdgeInsets, UIEdgeInsetsZero) || self.hidden || !self.userInteractionEnabled || self.alpha<0.01){
        btn.frame = self.bounds;
    }else{
        CGRect frame = self.bounds;
        //UIEdgeInsetsInsetRect 在原先的rect上内切出另一个rect出来，-为变大，+为变小
        CGRect clickFrame = UIEdgeInsetsInsetRect(frame, self.clickEdgeInsets);
        btn.frame = clickFrame;
    }
    btn.backgroundColor = [UIColor redColor];
    btn.alpha = 0.5;
    [self addSubview:btn];
}

///重写系统方法
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if(UIEdgeInsetsEqualToEdgeInsets(self.clickEdgeInsets, UIEdgeInsetsZero) || self.hidden || !self.userInteractionEnabled || self.alpha<0.01){
        return [super pointInside:point withEvent:event];
    }else{
        CGRect frame = self.bounds;
        //UIEdgeInsetsInsetRect 在原先的rect上内切出另一个rect出来，-为变大，+为变小
        CGRect clickFrame = UIEdgeInsetsInsetRect(frame, self.clickEdgeInsets);
        return CGRectContainsPoint(clickFrame, point);
    }
}

///是否可以响应点击事件
- (BOOL)canResponseClickEvent{
    /**
    *   在系统的UIView中，以下4个条件不执行时间响应
    *  1、hidden=YES的view
    *  2、userinteractionEnabled=NO的view
    *  3、alpha<0.01的view
    *  4、子view超出superView的区域
    */
    //UIEdgeInsetsEqualToEdgeInsets 判断两个值是否相等
    if(UIEdgeInsetsEqualToEdgeInsets(self.clickEdgeInsets, UIEdgeInsetsZero) || self.hidden || !self.userInteractionEnabled || self.alpha==0){
        return NO;
    }else{
        return YES;
    }
}

@end
