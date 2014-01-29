//
//  RadioButton.h
//  MathsPlay
//
//  Created by qainfotech on 29/01/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RadioDelegate <NSObject>
@required
-(void)didSelectedOption:(NSInteger)option;
@end



@interface RadioButton : UIButton
@property (nonatomic,weak) id<RadioDelegate> delegate;
@end



