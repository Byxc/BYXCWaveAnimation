//
//  WaveAnimationView.h
//  BYXCWaveAnimation
//
//  Created by 白云 on 2016/11/5.
//  Copyright © 2016年 白云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveAnimationView : UIView

@property(nonatomic,strong)UIColor *waveColor;

-(void)startPathAnimation;

-(void)startAnimation;

@end
