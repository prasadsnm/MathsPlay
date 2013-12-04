//
//  GeometricGrowthViewController.h
//  KidsLearningGame
//
//  Created by qainfotech on 04/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <math.h>
#import "CountDownTimer.h"

@interface GeometricGrowthViewController : UIViewController<CountDownTimerDelegate>
{
    UIButton *firstOptionButton,*secondOptionButton,*thirdOptionButton,*fourthOptionButton;
}
-(void)TimeUp;
-(void)startMethod;
- (int)getRandomNumber:(int)from to:(int)to;

-(NSArray *)getPatternArray:(double)baseNumber operationCode:(int)opCode;
-(UIView *)makeDisplayGrid :(NSArray *)arrayToDisplay;
-(void)refreshQuestion;
-(void)showOptions:(NSMutableArray *)arrayWithAnswer;
-(void)optionChoosen:(UIButton *)sender;
-(NSMutableArray *)getShuffledArrayWithAnswer:(NSString *)correctAnswer;
@end
