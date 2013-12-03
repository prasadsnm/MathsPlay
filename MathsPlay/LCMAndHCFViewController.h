//
//  LCMAndHCFViewController.h
//  KidsLearningGame
//
//  Created by qainfotech on 09/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCMAndHCFViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

    UITableView *_tableView;
    UILabel *questionLabel;
    UIButton * submitButton;
    NSMutableDictionary *optionDict;
    int answer;
    BOOL selection;
    BOOL isCorrect;
    UISegmentedControl *segmentControl;
}
-(NSMutableArray *)getShuffledArrayWithAnswer:(NSString *)correctAnswer;
-(void)refreshQuestion;
- (int)getRandomNumber:(int)from to:(int)to;
-(void)submitMethod;

int lcm(int a, int b);
int gcd(int a, int b);

@end
