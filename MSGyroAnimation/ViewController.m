//
//  ViewController.m
//  MSGyroAnimation
//
//  Created by mr.scorpion on 16/8/12.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "ViewController.h"
#import "MSBallView.h"

#define kUpdateInterval (1.f / 60.f) // 更新频率高一点

@interface ViewController ()
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) NSOperationQueue *quene;
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MSBallView *ballView = [[MSBallView alloc] initWithFrame:self.view.bounds];
    ballView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:ballView];
    
    self.motionManager = [[CMMotionManager alloc]init];
    self.quene = [[NSOperationQueue alloc] init];
    self.motionManager.deviceMotionUpdateInterval = kUpdateInterval;
    [self.motionManager startDeviceMotionUpdatesToQueue:_quene withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        //此处也可以传入motion.userAcceleration。（用户移动手机产生的加速度）这样就可以实现摇动来控制（ballView里面的放大倍数记得要改大一点）
//        [ballView setAcceleration:motion.gravity];
        [ballView setAcceleration:motion.userAcceleration];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ballView updateWithEnlarge:10000];
        });
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
