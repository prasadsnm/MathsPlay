//
//  CircularProgressView.h
//  MathsPlay
//
//  Created by qainfotech on 06/02/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularProgressView : UIView
@property(nonatomic, assign) CGFloat strokeWidth;
@property(nonatomic, strong) UIColor *fillColor;
@property(nonatomic, strong) UIColor *fillBackgroundColor;
@property(nonatomic, assign) CGFloat progress;
- (id)init;
@end
