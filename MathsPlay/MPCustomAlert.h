//
//  MPCustomAlert.h
//  MathsPlay
//
//  Created by qainfotech on 11/22/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

// PROTOCOL BEGINS
@protocol MPCustomAlertDelegate <NSObject>
@required
- (void)customAlertClicked:(NSInteger)index;

@end

// PROTOCOL ENDS

@interface MPCustomAlert : UIView

- (id)initWithFrame:(CGRect)frame message:(NSString *)_message andDelegate:(id<MPCustomAlertDelegate>)delegateObject titleA:(NSString *)titleA titleB:(NSString *)titleB;

// PROTOCOL PROPERTY
@property (nonatomic,weak) id<MPCustomAlertDelegate> alertdelegate;

@end
