//
//  ViewController.m
//  转盘学习
//
//  Created by daozhang on 16/6/25.
//  Copyright © 2016年 ksfc. All rights reserved.
//

#import "ViewController.h"
#import "WheelView.h"


@interface ViewController ()

@property (nonatomic,strong)WheelView *wheelView;

@end

@implementation ViewController

- (IBAction)startRotation:(UIButton *)sender
{
    [self.wheelView start];
}


- (IBAction)pauseRotation:(UIButton *)sender
{
    [self.wheelView pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wheelView = [WheelView wheelView];
    self.wheelView.center = self.view.center;
    [self.view addSubview:self.wheelView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
