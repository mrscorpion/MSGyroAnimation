//
//  MSBallView.m
//  MSGyroAnimation
//
//  Created by mr.scorpion on 16/8/12.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSBallView.h"

@interface MSBallView()
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, assign) CGPoint currentPoint;//当前ImageView位置
@property (nonatomic, assign) CGFloat ballXVelocity;//X方向速度
@property (nonatomic, assign) CGFloat ballYVelocity;//Y方向速度
@end

@implementation MSBallView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commoninit];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)commoninit
{
    self.image = [UIImage imageNamed:@"zq"];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.imageWidth, self.imageHeight)];
    self.imageView.image = _image;
    [self addSubview:self.imageView];
    self.currentPoint = CGPointMake(self.bounds.size.width/2.f+self.image.size.width/2.f, self.bounds.size.height/2.f+self.image.size.height/2.f);
    self.imageView.center = _currentPoint;
}

- (void)setCurrentPoint:(CGPoint)newPoint
{
    _currentPoint = newPoint;
    //边缘判断
    if (self.currentPoint.x <= self.imageWidth/2.f) {
        _currentPoint.x = self.imageWidth/2.f;
        self.ballXVelocity = -_ballXVelocity/2.f;
        //反弹效果，接触边缘后加速度反向减半
    }
    if (self.currentPoint.y <= self.imageHeight/2.f) {
        _currentPoint.y = self.imageHeight/2.f;
        self.ballYVelocity = -_ballYVelocity/2.f;
        //反弹效果，接触边缘后加速度反向减半
    }
    if (self.currentPoint.x >= self.width -self.imageWidth/2.f ) {
        _currentPoint.x = self.width -self.imageWidth/2.f;
        self.ballXVelocity = -_ballXVelocity/2.f;
        //反弹效果，接触边缘后加速度反向减半
    }
    if (self.currentPoint.y >= self.height -self.imageHeight/2.f ) {
        _currentPoint.y = self.height -self.imageHeight/2.f;
        self.ballYVelocity = -_ballYVelocity/2.f;
        //反弹效果，接触边缘后加速度反向减半
    }
    [self updateCenter];
}
- (void)updateCenter{
    self.imageView.center = _currentPoint;
}

- (void)updateWithEnlarge:(NSInteger)enlarge
{
    static NSDate *lastUpdateTime = nil;
    CGFloat multiple = enlarge ? enlarge : 1000;
    if (lastUpdateTime != nil)
    {
        NSTimeInterval secondsSinceLastDraw = [[NSDate date] timeIntervalSinceDate:lastUpdateTime];//两次更新的时间差
        self.ballXVelocity = self.ballXVelocity + (self.acceleration.x * secondsSinceLastDraw);
        //X方向上原速度加上加速度乘以时间，计算当前速度
        self.ballYVelocity = self.ballYVelocity - (self.acceleration.y * secondsSinceLastDraw);
        //Y方向上原速度加上加速度乘以时间，计算当前速度
        CGFloat xAccel = secondsSinceLastDraw * self.ballXVelocity * multiple;//secondsSinceLastDraw * self.ballXVelocity * 1000;
        //计算位置变化量。由于这个值很小，所以我们要放大一些才更加真实此处
        //若想使用摇动，要把放大倍数调大，10000效果不错
        CGFloat yAccel = secondsSinceLastDraw * self.ballYVelocity * multiple;//secondsSinceLastDraw * self.ballYVelocity * 1000;
        self.currentPoint = CGPointMake(self.currentPoint.x + xAccel, self.currentPoint.y + yAccel);
    }
    lastUpdateTime = [NSDate date];
}


#pragma mark - widthAndHeight
- (CGFloat)width
{
    return self.bounds.size.width;
}
- (CGFloat)height
{
    return self.bounds.size.height;
}
- (CGFloat)imageWidth
{
    return self.image.size.width;
}
- (CGFloat)imageHeight
{
    return self.image.size.height;
}
@end
