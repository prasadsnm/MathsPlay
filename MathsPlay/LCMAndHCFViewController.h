//
//  LCMAndHCFViewController.h
//  KidsLearningGame
//
//  Created by qainfotech on 09/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
#import "CustomAudioToolBox.h"
#import "Goodies.h"
#import "CircularProgressView.h"
#import "CustomSpeechSynthesizer.h"


@interface LCMAndHCFViewController : UIViewController<UIViewControllerTransitioningDelegate>
{
    UITableView *_tableView;
    UILabel *questionLabel;
    UIButton * submitButton;
    NSMutableDictionary *optionDict;
    int answer;
    BOOL selection;
    BOOL isCorrect;
    UISegmentedControl *segmentControl;
    Util *util;
    UITapGestureRecognizer *tapGestureRecognizer;
    UIPanGestureRecognizer *panGestureRecognizer;
    CustomAudioToolBox *audioToolBox;
    Goodies *goodies;
    CircularProgressView *circularProgressView;
    UIButton *helpButton;
    NSArray *optionArray;
    int selectedIndex;
    int selectedAnswer;
    UIImageView *tanker;
    BOOL isALligned;
    int currentHighlightedTag;
    int correctAnswerLabelTag,totalGiftObject;    //totalGiftObject is gift earned (1 in 5 correct)
    int scoreCount,totalQuestionCount;             //
    UIViewController *modal;
    UILabel *resultLabel;
    UILabel *progresslabel;
    CustomSpeechSynthesizer *speechsynthesizer;
    
    
}

- (int)getRandomNumber:(int)from to:(int)to;
-(NSMutableArray *)getShuffledArrayWithAnswer:(NSString *)correctAnswer;
-(NSArray *)refreshQuestion;


int lcm(int a, int b);
int gcd(int a, int b);

@end
