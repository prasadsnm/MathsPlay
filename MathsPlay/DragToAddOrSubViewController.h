//
//  DragToAddOrSubViewController
//  KidsLearningGame
//
//  Created by QA Infotech on 11/07/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface DragToAddOrSubViewController : UIViewController
{
    UILabel *currentLevelLabel,*numberOfCorrectAnsLabel,*numberOfInCorrectAnsLabel,*firstNumberLabel,*secondNumberLabel;
    UIImageView *smileLogo, *sadLogo, *hangmanImage;
    //--------- ORANGE BUBBLE ------
    UIView *optionView1,*optionView2,*optionView3,*optionView4;
    //UIImageView *optionImage1,*optionImage2,*optionImage3,*optionImage4;
    UILabel *optionLabel1,*optionLabel2,*optionLabel3,*optionLabel4;
    NSArray *optionViewArray; // stores the bubble views
    
    UITouch *touch;
    CGRect originalFrameOfOptionView1,originalFrameOfOptionView2,originalFrameOfOptionView3,originalFrameOfOptionView4;
    UIView *ansBoxView;
    int ans; // contains the ans for the sum
    int correctAnsCount , wrongAnsCount;
    int wrongOrRightValue; // 1 is for right 0 if for wrong; it is used so that I can zoom the smile or sad logo and den unzoom it
}
@property(nonatomic,copy)NSString *addOrSub;
@end
