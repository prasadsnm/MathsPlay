//
//  HelpMeAdditionViewController.h
//  MathsPlay
//
//  Created by qainfotech on 11/27/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpMeAdditionViewController : UIViewController
{
    UILabel *firstNumberLabel, *secondNumberLabel, *thirdNumberLabel, *operatorLabel1, *equalToLabel, *answerLabel, *operatorLabel2;
    UILabel *bugKilledLabel;
    UIView *spiderLineView;
    UIImageView *bugImage;
    NSString *levelString;
    
    // data objects
    NSMutableArray *optionButtonArray;
    NSInteger ansValue,numberOfCorrectAns;
    
    NSTimer *bugMoveTimer, *bugFallTimer, *axeFallTimer;
}
@end
