//
//  WaveAnimationView.m
//  BYXCWaveAnimation
//
//  Created by 白云 on 2016/11/5.
//  Copyright © 2016年 白云. All rights reserved.
//

#import "WaveAnimationView.h"

@interface WaveAnimationView ()

@property(nonatomic,weak)CAShapeLayer *shapeLayer;
@property(nonatomic,strong)CADisplayLink *displayLink;

@end

@implementation WaveAnimationView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setOfView];
    }
    return self;
}

-(void)setOfView
{
    //创建shapeLayer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    //设置layer背景颜色
    shapeLayer.backgroundColor = self.backgroundColor.CGColor;
    
    //添加到根图层
    [self.layer addSublayer:shapeLayer];
    
    _shapeLayer = shapeLayer;
}

-(void)startPathAnimation
{
    //绘图参数
    CGFloat waveHeight = self.bounds.size.height/2;
    CGFloat waveWidth = self.bounds.size.width;
    
    //贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, waveHeight)];
    
    [path addQuadCurveToPoint:CGPointMake(waveWidth*0.5, waveHeight) controlPoint:CGPointMake(waveWidth*0.25, 0)];
    [path addQuadCurveToPoint:CGPointMake(waveWidth, waveHeight) controlPoint:CGPointMake(waveWidth*0.75, waveHeight*2)];
    [path addQuadCurveToPoint:CGPointMake(waveWidth*1.5, waveHeight) controlPoint:CGPointMake(waveWidth*1.25, 0)];
    [path addQuadCurveToPoint:CGPointMake(waveWidth*2, waveHeight) controlPoint:CGPointMake(waveWidth*1.75, waveHeight*2)];
    
    [path addLineToPoint:CGPointMake(waveWidth*2, waveHeight*2)];
    [path addLineToPoint:CGPointMake(0, waveHeight*2)];
    
    [path closePath];
    
    //设置shapeLayer的path
    _shapeLayer.path = path.CGPath;
    
    //设置填充颜色
    _shapeLayer.fillColor = self.waveColor.CGColor;
    
    //创建动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(-waveWidth, 0)];
    
    anim.duration = 1.0;
    
    anim.repeatCount = CGFLOAT_MAX;
    
    [_shapeLayer addAnimation:anim forKey:@"waveAnimation"];
    
}

-(void)startAnimation
{
    //创建displayLink定时器
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(doAnimation)];
    
    //添加到主循环
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)stopAnimation
{
    //关闭定时器
    [_displayLink invalidate];
    //销毁定时器
    _displayLink = nil;
}

-(void)doAnimation
{
    //绘图参数
    CGFloat waveHeight = self.bounds.size.height/3;
    CGFloat waveWidth = self.bounds.size.width;
    static CGFloat offsetX = 0;
    CGFloat offsetY = waveHeight;
    
    CGFloat positionY = 0;
    
    //产生相移
    offsetX++;
    
    //绘制曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, waveHeight/2)];
    
    for (int i = 0; i < waveWidth; i++)
    {
        positionY = waveHeight * sinf(2*M_PI/waveWidth*i+2*M_PI/waveWidth*offsetX);
        
        //向曲线添加点
        [path addLineToPoint:CGPointMake(i, positionY-offsetY)];
    }
    
    //闭合曲线
    [path addLineToPoint:CGPointMake(waveWidth, waveHeight)];
    [path addLineToPoint:CGPointMake(0, waveHeight)];
    [path closePath];
    
    //设置shapeLayer的path
    _shapeLayer.path = path.CGPath;
    
    //设置填充颜色
    _shapeLayer.fillColor = self.waveColor.CGColor;
    
}

@end
