//
//  FollowViewController.m
//  KidsLearning
//
//  Created by QA Infotech on 23/07/12.
//  Copyright (c) 2012 ithelpdesk@qainfotech.net. All rights reserved.
//

#import "FollowViewController.h"
#import "FollowTPModel.h"
#import "FollowTPView.h"

#define COUNTDOWNEASY 250;
#define COUNTDOWNMEDIUM 300;
#define COUNTDOWNHARD 350;

@implementation FollowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
  
    }
    return self;
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    if ([countdownTimer isValid]) {
        [countdownTimer invalidate];
        countdownTimer = nil;
    }
    [countdownPlayer stop];
    countdownPlayer = nil;
    
    [dic setObject:[NSString stringWithFormat:@"%d",highscore] forKey:@"highscore"];
    
    [Util writeToPlist:dic];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dic = [Util readPListData];
    levelString = [dic objectForKey:@"level"];
    if ([levelString isEqualToString:@"EASY"]) {
        countdown = COUNTDOWNEASY;
    }
    else if ([levelString isEqualToString:@"MEDIUM"])
    {
        countdown = COUNTDOWNMEDIUM;
    }
    else
    {
        countdown = COUNTDOWNHARD;
    }
    roundValue = 1;
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1) {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    }
    else
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }
    self.navigationController.navigationBar.translucent = NO;
    // set bar title color
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor : [UIColor whiteColor]};
    // set  button color
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    
    self.title = @"Miscellaneous";
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *back = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
    back.image = [UIImage imageNamed:@"followBackground.jpg"];
    back.alpha = 0.7;
    [self.view addSubview:back];
    
    numberContainingArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    UILabel *timeLeft = [[UILabel alloc]initWithFrame:CGRectMake(25, 8, 170, 60)];
    timeLeft.text = @"TIME Left :";
    timeLeft.backgroundColor = [UIColor clearColor];
    timeLeft.textAlignment = NSTextAlignmentCenter;
    timeLeft.textColor = InstaGreen;
    timeLeft.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:32.0];
    [self.view addSubview:timeLeft];
    
    timeleftValue = [[UILabel alloc]initWithFrame:CGRectMake(190, 6, 110, 60)];
    timeleftValue.text = [NSString stringWithFormat:@"%d",countdown];
    timeleftValue.backgroundColor = [UIColor clearColor];
    timeleftValue.font = [UIFont fontWithName:@"Noteworthy-Light" size:40.0];
    timeleftValue.textAlignment = NSTextAlignmentCenter;
    timeleftValue.textColor = [UIColor yellowColor];
    [self.view addSubview:timeleftValue];

    
    currentScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 75, 270, 60)];
    currentScoreLabel.text = [NSString stringWithFormat:@"Your Score : %d",currentscore];
    currentScoreLabel.backgroundColor = [UIColor clearColor];
    currentScoreLabel.font = [UIFont fontWithName:@"Helvetica Light" size:25];
    currentScoreLabel.textAlignment = NSTextAlignmentCenter;
    currentScoreLabel.textColor = blueThemeColor;
    [self.view addSubview:currentScoreLabel];
    
    highScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 135, 270, 60)];
    if ([[Util readPListData] objectForKey:@"highscore"] ==nil ) {
        highScoreLabel.text = [NSString stringWithFormat:@"High Score : 0"];
    }else
    highScoreLabel.text = [NSString stringWithFormat:@"High Score : %@",[[Util readPListData] objectForKey:@"highscore"]];
    highScoreLabel.backgroundColor = [UIColor clearColor];
    highScoreLabel.font = [UIFont fontWithName:@"Helvetica Light" size:25];
    highScoreLabel.textAlignment = NSTextAlignmentCenter;
    highScoreLabel.textColor = InstaGreen;
    [self.view addSubview:highScoreLabel];
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1)
    {
        currentScoreLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:25];
        highScoreLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:25];
    }
    
    
    UIImageView *avatarImage = [[UIImageView alloc]initWithFrame:CGRectMake(450, 90, 140, 140)];
    NSData *imageData;
    imageData = [dic objectForKey:@"avatarImage"];
    avatarImage.image = [UIImage imageWithData:imageData];
    [self.view addSubview:avatarImage];
    
    UILabel *avatarLabel = [[UILabel alloc]initWithFrame:CGRectMake(450, 210, 140, 60)];
    avatarLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"username"]];
    avatarLabel.textAlignment = NSTextAlignmentCenter;
    avatarLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:205/255.0 alpha:1.0];
    avatarLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19.0];
    avatarLabel.backgroundColor = [UIColor clearColor];
    avatarLabel.numberOfLines = 0;
    avatarLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:avatarLabel];
    
    level = [[UILabel alloc]initWithFrame:CGRectMake(380, 8, 220, 60)];
    level.text = [NSString stringWithFormat:@"%@ Round :",levelString];
    level.backgroundColor = [UIColor clearColor];
    level.textAlignment = NSTextAlignmentCenter;
    level.textColor = InstaGreen;
    level.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:30.0];
    [self.view addSubview:level];
    
    levelValue = [[UILabel alloc]initWithFrame:CGRectMake(600, 6, 100, 60)];
    levelValue.text = [NSString stringWithFormat:@"%d/25",roundValue];
    levelValue.backgroundColor = [UIColor clearColor];
    levelValue.font = [UIFont fontWithName:@"Noteworthy-Light" size:35.0];
    levelValue.textAlignment = NSTextAlignmentCenter;
    levelValue.textColor = [UIColor yellowColor];
    [self.view addSubview:levelValue];
    
    cheatCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(1,938, 20, 15)];
    cheatCodeLabel.backgroundColor = [UIColor clearColor];
    cheatCodeLabel.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:cheatCodeLabel];
    cheatCodeLabel.textColor = [UIColor darkGrayColor];
    
    zigzagView = [[UIView alloc]initWithFrame:CGRectMake(65, 300, 680, 300)];
    zigzagView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:zigzagView];
    
    for (NSUInteger i1 = 0; i1<3; i1++) {
        FollowTPView *box = [[FollowTPView alloc]initWithFrame:CGRectMake(0+i1*100, 0, 100, 100)];
        box.text = @"11";
        box.tag = i1 + 10;
        [zigzagView addSubview:box];
    }
    for (NSUInteger j1 = 0; j1<2; j1++) {
        FollowTPView *box = [[FollowTPView alloc]initWithFrame:CGRectMake(200, 100+j1*100, 100, 100)];
        box.text = @"22";
        box.tag = j1 + 21;
        [zigzagView addSubview:box];
    }
    for (NSUInteger i2 = 0; i2<2; i2++) {
        FollowTPView *box = [[FollowTPView alloc]initWithFrame:CGRectMake(300+i2*100, 200, 100, 100)];
        box.text = @"33";
        box.tag = i2 + 31;
        [zigzagView addSubview:box];
    }
    
    ansField = [[UITextField alloc]initWithFrame:CGRectMake(520, 200, 160, 100)];
    ansField.backgroundColor = [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255.0/255.0 alpha:0.7];
    ansField.tag = 1;
    ansField.delegate=self;
    ansField.layer.cornerRadius = 20.0;
    ansField.keyboardType=UIKeyboardTypeNumberPad;
    ansField.font=[UIFont fontWithName:@"Helvetica" size:42];
    ansField.placeholder=@"?";
    ansField.textAlignment=NSTextAlignmentCenter;
    ansField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [zigzagView addSubview:ansField];
    
    [self numberArrayBasedOnLevel];
    arrayForOperators = @[@"+",@"-"];
    
    [self showQuestion];
    [ansField becomeFirstResponder];
    
    countdownPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/waitingaudio.mp3", [[NSBundle mainBundle] resourcePath]]] error:nil];
    countdownPlayer.numberOfLoops = -1;
    [countdownPlayer play];
    
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerForCountdown) userInfo:nil repeats:YES];
    
    submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:40];
    [submitBtn setBackgroundColor:[UIColor whiteColor]];
    [submitBtn setFrame:CGRectMake(200, zigzagView.frame.origin.y + zigzagView.frame.size.height + 20, 400, 75)];
    submitBtn.layer.cornerRadius = 20.0;
    [submitBtn addTarget:self action:@selector(submitButtonCLicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    water = [[UIImageView alloc]initWithFrame:CGRectMake(440, 230, 160, 0)];
    water.image = [UIImage imageNamed:@"water"];
    water.alpha = 0.7;
    [water setHidden:YES];
    [self.view addSubview:water];
    
}

- (void)timerForCountdown
{
    countdown--;
    timeleftValue.text = [NSString stringWithFormat:@"%d",countdown];
    if (countdown == 0) {
        // stop your time is up
        [countdownTimer invalidate];
        countdownTimer = nil;
        [ansField resignFirstResponder];
        ansField.userInteractionEnabled = NO;
        MPCustomAlert *customAlert = [[MPCustomAlert alloc]initWithFrame:CGRectMake(0, 0, 400, 380) message:@"OOPS ! Your Time Is Up" andDelegate:self titleA:@"My Home" titleB:@"Restart This Level"];
        customAlert.center = self.view.center;
        [self.view addSubview:customAlert];
    }
}


- (void)customAlertClicked:(NSInteger)index
{
    if(index == 1)
    {
        // my home
        [self viewWillDisappear:YES];
        [self.navigationController popViewControllerAnimated:YES];

    }
    else
    {
        // play again
        if (countdown!=0)
        {
            // i.e user drowned
            water.frame = CGRectMake(440, 230, 160, 0);
            [water setHidden:YES];
        }
        
        if ([levelString isEqualToString:@"EASY"]) {
            countdown = COUNTDOWNEASY;
        }
        else if ([levelString isEqualToString:@"MEDIUM"])
        {
            countdown = COUNTDOWNMEDIUM;
        }
        else
        {
            countdown = COUNTDOWNHARD;
        }

        [dic setObject:[NSString stringWithFormat:@"%d",highscore] forKey:@"highscore"];
        [Util writeToPlist:dic];
        currentscore = 0;
        currentScoreLabel.text = [NSString stringWithFormat:@"Your Score : %d",currentscore];
        highScoreLabel.text = [NSString stringWithFormat:@"High Score : %@",[[Util readPListData] objectForKey:@"highscore"]];
        [self basicGameCondition];
        
    }
}


- (void)basicGameCondition
{
    roundValue = 1;
    
    if ([countdownTimer isValid]) {
        [countdownTimer invalidate];
        countdownTimer = nil;
    }
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerForCountdown) userInfo:nil repeats:YES];
    timeleftValue.text = [NSString stringWithFormat:@"%d",countdown];
    level.text = [NSString stringWithFormat:@"%@ Round :",levelString];
    levelValue.text = [NSString stringWithFormat:@"%d/25",roundValue];
    submitBtn.userInteractionEnabled = YES;
    ansField.userInteractionEnabled = YES;
    ansField.placeholder=@"?";
    ansField.text = @"";
    [ansField becomeFirstResponder];
    [self numberArrayBasedOnLevel];
    [self showQuestion];
    
}


- (void)numberArrayBasedOnLevel
{
    if ([levelString isEqualToString:@"EASY"])
    {
        arrayForNos = [FollowTPModel easyValues];
    }
    else if ([levelString isEqualToString:@"MEDIUM"])
    {
        arrayForNos = [FollowTPModel mediumValues];
    }
    else
    {
        arrayForNos = [FollowTPModel hardValues];
    }
}

-(void)showQuestion
{
    [numberContainingArray removeAllObjects];
    for (UILabel *boxLabel in zigzagView.subviews) {
        if (boxLabel.tag % 2 == 0) { // i.e even tag
            boxLabel.text = [NSString stringWithFormat:@"%@",[arrayForNos objectAtIndex:(arc4random() % [arrayForNos count])]];
            [numberContainingArray addObject:boxLabel.text];
        }
        else if(boxLabel.tag !=1)
        {
            boxLabel.text = [NSString stringWithFormat:@"%@",[arrayForOperators objectAtIndex:(arc4random() % [arrayForOperators count])]];
            [numberContainingArray addObject:boxLabel.text];
        }
        
    }
    [self calculateFinalAnswer];
}


- (void)calculateFinalAnswer
{
    NSInteger temp=0;
    BOOL isPositive = YES;
    finalAns = 0;
    for (NSInteger i=0; i<numberContainingArray.count; i++) {
        if (i%2==0) { // even index
            temp = [[numberContainingArray objectAtIndex:i]integerValue];
            if (isPositive) {
                finalAns = finalAns + temp;
            }
            else finalAns = finalAns - temp;
        }
        else // odd index
        {
            if ([[numberContainingArray objectAtIndex:i]isEqualToString:@"+"]) isPositive = YES;
            else isPositive = NO;
        }
        
    }
}

-(void) submitButtonCLicked:(UIButton *)sender
{
    [ansField resignFirstResponder];
    
    if (ansField.text == nil || [ansField.text isEqualToString:@""])
    {
        // empty
        popupbox = [[UIImageView alloc]initWithFrame:CGRectMake(380,120,370,80)];
        popupbox.image =[ UIImage imageNamed:@"popoverBg@2x.png"];
         nilValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(100,20,185,35)];
         nilValueLabel.text = @"Please insert any value";
        nilValueLabel.textAlignment = NSTextAlignmentCenter;
        nilValueLabel.backgroundColor = [UIColor clearColor];
        nilValueLabel.textColor = [UIColor whiteColor];
        [popupbox addSubview:nilValueLabel];
        [zigzagView addSubview:popupbox];
        
        arrow = [[UIImageView alloc]initWithFrame:CGRectMake(500,180,50,25)];
        arrow.image =[ UIImage imageNamed:@"popoverArrowDown@2x.png"];
        [zigzagView addSubview:arrow];
        
        submitBtn.userInteractionEnabled = NO;
        [self performSelector:@selector(labelDisapper) withObject:nil afterDelay:1.5];
        
    }
   else if ([ansField.text isEqualToString:[NSString stringWithFormat:@"%i",finalAns]])
   {
       // correct answer
       
       ansField.userInteractionEnabled = NO;
       submitBtn.userInteractionEnabled = NO;
       
       UIImageView *correctImage = [[UIImageView alloc]initWithFrame:CGRectMake(620, 120, 150, 100)];
       correctImage.image = [UIImage imageNamed:@"correct"];
       [self.view addSubview:correctImage];
       
       currentscore += 10;
       currentScoreLabel.text = [NSString stringWithFormat:@"Your Score : %d",currentscore];
       if (highscore<currentscore) {
           highscore = currentscore;
           highScoreLabel.text = [NSString stringWithFormat:@"High Score : %d",highscore];
       }
       
       [self performSelector:@selector(nextRound:) withObject:correctImage afterDelay:1.5];
    }
    
else {
        // wrong ans
    
    UILabel *answerLabel=[[UILabel alloc]initWithFrame:CGRectMake(490, 350, 250, 60)];
    answerLabel.backgroundColor=[UIColor whiteColor];
    answerLabel.textColor=[UIColor redColor];
    answerLabel.layer.cornerRadius=5.0;
    answerLabel.layer.borderWidth=1.0;
    answerLabel.textAlignment=NSTextAlignmentCenter;
    answerLabel.font=[UIFont boldSystemFontOfSize:18];
    [self.view addSubview:answerLabel];
    [answerLabel setHidden:NO];
    answerLabel.text=[NSString stringWithFormat:@"Correct Answer is: %d",finalAns];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [answerLabel setHidden:YES];

    });

    
    [water setHidden:NO];
    [water setFrame:CGRectMake(water.frame.origin.x, water.frame.origin.y-10, water.frame.size.width, water.frame.size.height+10)];
    speechBubble = nil;
    speechBubble = [[UIImageView alloc]initWithFrame:CGRectMake(305, 130, 150, 60)];
    speechBubble.image = [UIImage imageNamed:@"speech_bubble"];
    [self.view addSubview:speechBubble];
    
    UILabel *bubbleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 60)];
    bubbleLabel.text = @"Help Me ! \nI am drowning !!";
    bubbleLabel.backgroundColor = [UIColor clearColor];
    bubbleLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
    bubbleLabel.textColor = [UIColor whiteColor];
    bubbleLabel.textAlignment = NSTextAlignmentCenter;
    bubbleLabel.numberOfLines = 0;
    bubbleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [speechBubble addSubview:bubbleLabel];
    
    ansField.userInteractionEnabled = NO;
    submitBtn.userInteractionEnabled = NO;
    
    if (!(water.frame.origin.y<=70)) {
        UIImageView *IncorrectImage = [[UIImageView alloc]initWithFrame:CGRectMake(620, 120, 150, 100)];
        IncorrectImage.image = [UIImage imageNamed:@"incorrect"];
        [self.view addSubview:IncorrectImage];
        [self performSelector:@selector(nextRound:) withObject:IncorrectImage afterDelay:1.5];
    }
    else {
        // game over. you drowned !!!
        // your game 'll start from first level again
        [speechBubble removeFromSuperview];
        if ([countdownTimer isValid]) {
            [countdownTimer invalidate];
            countdownTimer = nil;
        }
        [ansField resignFirstResponder];
       
        ansField.userInteractionEnabled = NO;
        levelString = @"EASY";
        [dic setObject:levelString forKey:@"level"];
        [Util writeToPlist:dic];
        MPCustomAlert *customAlert = [[MPCustomAlert alloc]initWithFrame:CGRectMake(0, 0, 400, 380) message:@"GAME OVER.\nYOU DROWNED !!!" andDelegate:self titleA:@"My Home" titleB:@"Start Again"];
        customAlert.center = self.view.center;
        [self.view addSubview:customAlert];
    }
   
    }
}


-(void)nextRound:(UIImageView *)image
{
    if (roundValue<26)
    {
        [image removeFromSuperview]; // correct or incorrect imageview
        [speechBubble removeFromSuperview];
        roundValue ++;
        levelValue.text = [NSString stringWithFormat:@"%d/25",roundValue];
        submitBtn.userInteractionEnabled = YES;
        ansField.userInteractionEnabled = YES;
        ansField.placeholder=@"?";
        ansField.text = @"";
        if (countdown !=0) {
            [ansField becomeFirstResponder];
            [self showQuestion];
        }
        
    }
    else
    {
        if ([levelString isEqualToString:@"EASY"]) {
            levelString = @"MEDIUM";
            [dic setObject:levelString forKey:@"level"];
            [Util writeToPlist:dic];
            countdown = COUNTDOWNMEDIUM;
        }
        else if ([levelString isEqualToString:@"MEDIUM"])
        {
            levelString = @"HARD";
            [dic setObject:levelString forKey:@"level"];
            [Util writeToPlist:dic];
            countdown = COUNTDOWNHARD;
        }
        if (![levelString isEqualToString:@"HARD"]) {
            [self basicGameCondition];
        }
        else
        {
            // congratulations you have completed all the level
            [image removeFromSuperview];
            [speechBubble removeFromSuperview];
            if ([countdownTimer isValid]) {
                [countdownTimer invalidate];
                countdownTimer = nil;
            }
            [ansField resignFirstResponder];
            ansField.userInteractionEnabled = NO;
            levelString = @"EASY";
            [dic setObject:levelString forKey:@"level"];
            [Util writeToPlist:dic];
            MPCustomAlert *customAlert = [[MPCustomAlert alloc]initWithFrame:CGRectMake(0, 0, 400, 380) message:@"HURRAY .\nYOU ROCKED !!!" andDelegate:self titleA:@"My Home" titleB:@"Start Again"];
            customAlert.center = self.view.center;
            [self.view addSubview:customAlert];
        }
        
    }
    
}

-(void)labelDisapper
{
    [ansField becomeFirstResponder];
    submitBtn.userInteractionEnabled = YES;
    [nilValueLabel removeFromSuperview];
    [popupbox removeFromSuperview];
    [arrow removeFromSuperview];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //submitButton.userInteractionEnabled = YES;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [ansField resignFirstResponder];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
