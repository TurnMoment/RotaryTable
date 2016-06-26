//
//  WheelButton.m
//  转盘学习
//
//  Created by daozhang on 16/6/25.
//  Copyright © 2016年 ksfc. All rights reserved.
//

#import "WheelButton.h"

@implementation WheelButton

/**< 按钮的下半部分有很多重叠 可以设置按钮只可以点击的范围*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGFloat btnW = self.bounds.size.width;
    CGFloat btnH = self.bounds.size.height;
    
    CGFloat x = 0;
    CGFloat y = btnH/2;
    CGFloat w = btnW;
    CGFloat h = y;
    CGRect rect = CGRectMake(x, y, w, h);
    if (CGRectContainsPoint(rect, point)) {
        return nil;
    }else{
        return [super hitTest:point withEvent:event];
    }

}



//设置UIImageView的尺寸
//contentRect:按钮的尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    //计算UIImageView的控件尺寸
    CGFloat imageW = 40;
    CGFloat imageH = 40;
    CGFloat imageX = (contentRect.size.width - imageW)*0.5;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
 
}

//取消高亮的状态
- (void)setHighlighted:(BOOL)highlighted{

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
