//
//  DropDownAlert.h
//  MathsPlay
//
//  Created by qainfotech on 04/02/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownAlert : UIView
-(id)initWithFrame:(CGRect)frame message:(NSString *)message;
-(void)show;
-(void)hide;
@property(nonatomic,strong)UILabel *textLabel;  //if weak it will be released very soon after assignment.
@end
