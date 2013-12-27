//
//  DivisibiltyCheckViewController.h
//  KidsLearningGame
//
//  Created by qainfotech on 01/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "Goodies.h"

#import "CustomModalBox.h"

@interface DivisibiltyCheckViewController : UIViewController<ModalDelegate>
{
    int dividend;
    int divisor;
    UILabel *questionLabel;
    UIImageView *ant;
    CustomModalBox *modal;
    UILabel *builiding;
    UIButton *helpButton;

}
-(void)winMusicStart;
-(void)displayQuestion;
-(void)correctAnswer;
-(void)incorrectAnswer;
-(void)answerClicked:(BOOL)answer;
- (int)getRandomNumber:(int)from to:(int)to;
-(void)initialAnimation;
-(void)startMethod:(UIButton *)sender;
@end
