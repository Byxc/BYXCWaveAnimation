//
//  ViewController.m
//  BYXCWaveAnimation
//
//  Created by 白云 on 2016/11/5.
//  Copyright © 2016年 白云. All rights reserved.
//

#import "ViewController.h"
#import "WaveAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

-(void)setUp
{
    WaveAnimationView *animaView = [[WaveAnimationView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    
    animaView.center = self.view.center;
    
    animaView.waveColor = [UIColor orangeColor];
    
    [self.view addSubview:animaView];
    
    [animaView startPathAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
