//
//  WheelView.m
//  转盘学习
//
//  Created by daozhang on 16/6/25.
//  Copyright © 2016年 ksfc. All rights reserved.
//

#import "WheelView.h"
#import "WheelButton.h"

@interface WheelView ()

@property (strong, nonatomic) IBOutlet UIImageView *centerView; //转盘中间的那个图片

@property (nonatomic,strong)UIButton *selBtn;  //记录上次选中的按钮

@property (nonatomic,strong)CADisplayLink *link;

@end

@implementation WheelView

- (CADisplayLink *)link
{
    if (_link == nil) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(angleChange)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _link;
}


+ (instancetype)wheelView
{

    return [[NSBundle mainBundle]loadNibNamed:@"WheelView" owner:nil options:nil][0];
}

#pragma mark - 开始旋转
- (void)start
{
    self.link.paused = NO;
}

#pragma mark - 暂停旋转
- (void)pause
{
    self.link.paused = YES;
}

- (void)awakeFromNib
{

    _centerView.userInteractionEnabled = YES;
    CGFloat btnW = 68;
    CGFloat btnH = 143;
    
    CGFloat wh = self.bounds.size.width;
 
    //加载大图片
    UIImage *bigImg = [UIImage imageNamed:@"LuckyAstrology"];
    
    //加载大图片
    UIImage *selBigImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    //获取当前使用的图片像素和点的比例
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat imageW = bigImg.size.width/12*scale;
    CGFloat imageH = bigImg.size.height*scale;
    
    //CGImagef image:需要裁剪的 照片
    //rect:裁剪区域
    //裁剪区域是以像素为基准
    //CGImageCreateWithImageInRect(CGImageRef  _Nullable image, CGRect rect);
    
    //添加按钮
    for (int i = 0; i < 12; i++)
    {
        WheelButton *btn = [WheelButton buttonWithType:UIButtonTypeCustom ];
        
        //设置按钮的位置
        btn.layer.anchorPoint = CGPointMake(0.5,1);  //锚点（0，0）-（1，1）bounds的中心是（0.5，0.5）
        
        btn.bounds = CGRectMake(0, 0, btnW, btnH);
        btn.layer.position = CGPointMake(wh*0.5, wh*0.5);
        //btn.backgroundColor = [UIColor yellowColor]; //观察按钮的重叠效果
        
        //按钮旋转的角度n
        CGFloat radio = (30*i)/180.0 * M_PI;
        btn.transform = CGAffineTransformMakeRotation(radio);
        
        [_centerView addSubview:btn];
        
        //加载按钮的图片
        //计算裁剪区域
        CGRect clipR = CGRectMake(i * imageW, 0, imageW, imageH);
        
        //裁剪图片
        CGImageRef imgR = CGImageCreateWithImageInRect(bigImg.CGImage, clipR);
        UIImage *image = [UIImage imageWithCGImage:imgR];
        
        //设置按钮的图片
        [btn setImage:image forState:UIControlStateNormal];
        
        //设置选中状态下的图片
        imgR = CGImageCreateWithImageInRect(selBigImage.CGImage, clipR);
        
        image = [UIImage imageWithCGImage:imgR];
        
        //设置选中按钮的图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        //监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [self btnClick:btn];
        }
    }

}



- (void)btnClick:(UIButton*)btn
{
    _selBtn.selected = NO;
    btn.selected = YES;
    _selBtn = btn;
}

#pragma mark - 每隔一段时间旋转一定的角度
- (void)angleChange
{
    //每一次调动旋转多少45度  45/60
    CGFloat angle = (45/60.0)*M_PI/180.0;
    _centerView.transform = CGAffineTransformRotate(_centerView.transform,angle);
}

#pragma mark - 点击开始选号
- (IBAction)startPicker:(UIButton *)sender
{
    //不需要定时器旋转
    self.link.paused = YES;
    
    //中间的转盘快速的旋转，并且不需要与用户交互
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI*2*3);
    
    anim.duration = 0.5;
    anim.delegate = self;
    
    [_centerView.layer addAnimation:anim forKey:nil];
    
    //点击那个星座，就把当前指针指向中心点上面
    
    // M_PI 3.14
    // 根据选中的按钮获取旋转的度数
    //通过transform获取角度
    CGFloat angle = atan2(_selBtn.transform.b, _selBtn.transform.a);
    
    //旋转转盘
    _centerView.transform = CGAffineTransformMakeRotation(-angle);
    
}

//快速旋转之后执行的代理方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.link.paused = YES;
    });

}





@end









