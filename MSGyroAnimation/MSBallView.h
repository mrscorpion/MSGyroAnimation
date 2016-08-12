//
//  MSBallView.h
//  MSGyroAnimation
//
//  Created by mr.scorpion on 16/8/12.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MSBallView : UIView
@property (nonatomic, assign) CMAcceleration acceleration;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

- (void)updateWithEnlarge:(NSInteger)enlarge;
@end
