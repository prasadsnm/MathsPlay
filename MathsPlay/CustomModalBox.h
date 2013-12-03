//
//  CustomModalBox.h
//  KidsLearningGame
//
//  Created by qainfotech on 03/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol ModalDelegate <NSObject>
@required
-(void)answerClicked:(BOOL)answer;
@end

@interface CustomModalBox : UIView
{
    UILabel *questionlabel;
__unsafe_unretained id<ModalDelegate> delegate;
}
-(void)setQuestionLabelColor:(UIColor *)color;
-(void)setQuestion:(NSString *)question;
-(void)buttonClicked:(UIButton *)sender;
-(void)show;
-(void)hide;
@property (nonatomic,assign) id<ModalDelegate> delegate;
@property(nonatomic,strong)UIButton *yesButton;
@property(nonatomic,strong)UIButton *noButton;

@end
