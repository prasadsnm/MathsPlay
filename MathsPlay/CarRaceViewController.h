//
//  CarRaceViewController.h
//  KidsLearningGame
//
//  Created by QA Infotech on 30/08/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface CarRaceViewController : UIViewController
{
    
    UIImageView *carImage1,*carImage2,*carImage3,*carImage4, *yourCarArrow, *rightOrWrong, *finishLine;
    UILabel *questionLabel, *clockLabel, *correctAnsLabel, *inCorrectAnsLabel;
    NSArray *balloonArray, *fakeArray1, *fakeArray2, *fakeArray3;
    UIButton *balloonBtn1, *balloonBtn2, *balloonBtn3, *balloonBtn4;
    
    // Variable For Question , Answer , Fake_Ans
    NSInteger question, rightAnsPart1, rightAnsPart2, fakeAns1Part1, fakeAns1Part2, fakeAns2Part1, fakeAns2Part2, fakeAns3Part1, fakeAns3Part2, correctAns, wrongAns;
    NSDictionary *plistDict;
    
    NSTimer *clockTimer, *balloonMoveTimer;
    
    // carTimers
    NSTimer *carTimer1, *carTimer2, *carTimer3, *myCarTimer, *myCarTimerAtDoubleSpeed;
    
    // variables to check which car came first, second, third
    NSInteger firstCar, secondCar, myCar;
}
- (void)goButtonClicked:(UIButton *)btn ;
- (void)backButtonPressed;
- (int)getRandomNumber:(int)from to:(int)to;
- (void)clockTimer ;
- (void)moveArrow ;
-(void)balloonClicked:(UIButton *)sender ;
- (void)moveBalloonUpwards;
-(void) showQuestionAndAnswer;
- (void)generateQuestion ;
- (void)myCarMoveWithNormalSpeedAgain;
- (void)myCarMoveWithDoubleSpeed ;
- (void)myCarMoveWithNormalSpeed;
- (void)thirdAutoCar;
- (void)secondAutoCar;
- (void)firstAutoCar;
@end
