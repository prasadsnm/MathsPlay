//
//  SubViewController.h
//  KidsLearningGame
//
//  Created by QA Infotech on 21/08/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SubViewController : UIViewController<UIAlertViewDelegate>
{
    NSMutableDictionary *dic;
    UIImageView *avatarImage,*orangeImage,*hintPopupImage,*livesRemainingImage1,*livesRemainingImage2,*heartbroken;
    UILabel *username,*noOfLives,*level,*stageZoomOut;
    UIButton *hintButton, *startButton,*clickedBtn1,*clickedBtn2,*clickedBtn3;
    int popupshowvariable,stage,livesremaining,buttonclick_count_in_a_row,countForNextStage;
    NSString *levelString;
    UIView *easyMatrixView;
    
}

-(int)getRandomNumber:(int)from to:(int)to;

@end
