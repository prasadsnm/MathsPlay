//
//  SquareRootViewController.h
//  KidsLearningGame
//
//  Created by qainfotech on 30/09/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModalBox.h"
#import "CustomAudioToolBox.h"

@interface SquareRootViewController : UIViewController<UITextFieldDelegate>
{
    int correctCount;
    int incorrectCount;
    UILabel *sqrtLabel,*equalTolabel;
    UITextField *answer;
    UILabel *correctCountLabel;
    UILabel *incorrectCountLabel;
    NSMutableArray *tempArray;
    int complexity;
    int level;
    int QuestionCount;
    UIImageView *moodImage;
    NSArray *questionArray;
    int Counter;
    UIButton *helpButton;
    CustomAudioToolBox *audioToolBox;


}
-(int)getRandomPerfectSquare;
-(void)showQuestion;
-(void)submitClicked;
@property(nonatomic,strong)CustomModalBox *modal;

@end
