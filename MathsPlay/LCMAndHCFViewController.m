//
//  LCMAndHCFViewController.m
//  KidsLearningGame
//
//  Created by qainfotech on 09/10/13.
//  Copyright (c) 2013 QAInfotech. All rights reserved.
//

#import "LCMAndHCFViewController.h"
#define Y_AXIS_VALUE 300
#define ANSWER_LOCK @"THE_LOCK"
#define TOTAL_QUESTION_COUNT 15


@interface LCMAndHCFViewController ()
{
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
}
@property(nonatomic,assign) CGPoint targetCenter;

@end

@implementation LCMAndHCFViewController
@synthesize targetCenter=_targetCenter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scoreCount=totalQuestionCount=totalGiftObject=0;
    modal=nil;
    
    if (modal) {
        [modal removeFromParentViewController];
        modal=nil;
    }
    modal=[[UIViewController alloc]init];
    modal.view.backgroundColor=[UIColor colorWithRed:132/255.0 green:240/255.0 blue:88/255.0 alpha:1];
    modal.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    modal.modalPresentationStyle=UIModalPresentationFormSheet;
    
    
    helpButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [helpButton setImage:[UIImage imageNamed:@"rules"] forState:UIControlStateNormal];
    helpButton.tag=100011;
    [helpButton addTarget:self action:@selector(buttonActionMethod:) forControlEvents:UIControlEventTouchUpInside];
    helpButton.frame=CGRectMake(self.view.frame.size.width-200 , 50, 200, 80);
    helpButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:helpButton];
    
    resultLabel=nil;
    resultLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 200, 300, 200)];
    resultLabel.backgroundColor=[UIColor clearColor];
    resultLabel.textColor=[UIColor blackColor];
    resultLabel.font=[UIFont fontWithName:@"Chalkduster" size:40];
    resultLabel.textAlignment=NSTextAlignmentCenter;
    resultLabel.numberOfLines=0;
    [modal.view addSubview:resultLabel];
    
    
    UIButton *replayButton=[UIButton buttonWithType:UIButtonTypeCustom];
    replayButton.layer.cornerRadius=15.0;
    replayButton.tag=2001;
    replayButton.titleLabel.font=[UIFont fontWithName:@"Chalkduster" size:30];
    [replayButton setTitle:@"Play Again" forState:UIControlStateNormal];
    [replayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [replayButton addTarget:self action:@selector(modalActionMethods:) forControlEvents:UIControlEventTouchUpInside];
    replayButton.frame=CGRectMake(70 , 500, 200, 80);
    replayButton.backgroundColor=[UIColor yellowColor];
    replayButton.showsTouchWhenHighlighted=YES;
    [modal.view addSubview:replayButton];
    
    
    UIButton *quitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    quitButton.layer.cornerRadius=15.0;
    quitButton.tag=2002;
    quitButton.titleLabel.font=[UIFont fontWithName:@"Chalkduster" size:30];
    [quitButton setTitle:@"Quit" forState:UIControlStateNormal];
    [quitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [quitButton addTarget:self action:@selector(modalActionMethods:) forControlEvents:UIControlEventTouchUpInside];
    quitButton.frame=CGRectMake(300 , 500, 200, 80);
    quitButton.backgroundColor=[UIColor redColor];
    quitButton.showsTouchWhenHighlighted=YES;
    [modal.view addSubview:quitButton];
    
    
    audioToolBox=[[CustomAudioToolBox alloc]init];
    currentHighlightedTag=12345;
    correctAnswerLabelTag=12346;
    self.view.tag=1111;
    SET_USERNAME_AS_TITLE
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
    selectedAnswer=0;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"sky"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    questionLabel=nil;
    questionLabel=[[UILabel alloc]initWithFrame:CGRectMake(84, 50, 600, 200)];
    questionLabel.tag=1010;
    questionLabel.backgroundColor=[UIColor clearColor];
    questionLabel.numberOfLines=0;
    questionLabel.textAlignment=NSTextAlignmentCenter;
    questionLabel.font = FONT;
    questionLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:questionLabel];
    
    tanker=nil;
    //self.view.frame.size.width/3
    tanker=[[UIImageView alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height-200, 150, 132)];
    tanker.image=[UIImage imageNamed:@"fighter-3"];
    tanker.userInteractionEnabled=YES;
    tanker.tag=1007;
    [self.view addSubview:tanker];
    _targetCenter=CGPointMake(tanker.center.x, 0);
    
    
    panGestureRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [tanker addGestureRecognizer:panGestureRecognizer];
    
    tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.numberOfTapsRequired=1;
    [tanker addGestureRecognizer:tapGestureRecognizer];
    
    [self start];
    [self startEmmitter];
    
}


- (void) dismissInstructionScreen:(UITapGestureRecognizer *)recognize
{
    [recognize.view removeFromSuperview];
}

-(void)modalActionMethods:(UIButton *)sender
{
    [self dismissResultModalFromMainView];
    if (sender.tag==2001) {
        for (UIView *view in self.view.subviews) {              //remove all view from self.view
            [view removeFromSuperview];
        }
        [self viewDidLoad];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];  //beacuse root is Home View
    }
}

-(void)dismissResultModalFromMainView
{
    [modal dismissModalViewControllerAnimated:YES];
}

-(void)refreshGiftWithCount:(int)count
{
    for (Goodies *gift in self.view.subviews) {
        if ([gift isKindOfClass:[Goodies class]] && gift.tag==5555) {
            [gift removeFromSuperview];
        }
    }
    
    goodies=[[Goodies alloc]initWithFrame:CGRectZero Count:count giftimage:@"gift-box"];
    goodies.tag=5555;
    [self.view addSubview:goodies];
}

-(void)start
{
    [self makeDisplayGrid];
}

-(void)submitMethod
{
    if (selectedIndex<4) {
        if (isCorrect) {
            UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Correct !!" message:@"Your Answer is Correct" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [gameOver show];
            
        }
        else
        {
            UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Wrong" message:@"Your Answer is inCorrect" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [gameOver show];
            
        }
        [self refreshQuestion];
    }
    else
    {
        UIAlertView *gameOver = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Select at least one Option" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [gameOver show];
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)from + arc4random() % (to-from+1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Fresh Question

-(NSArray *)refreshQuestion
{
    totalQuestionCount++;
    int firstRandom=[self getRandomNumber:1 to:10];
    int secondRandom=[self getRandomNumber:1 to:10];
    answer=0;
    
    if (([self getRandomNumber:1 to:8]%2)==0) {
        
        questionLabel.text=[NSString stringWithFormat:@"The LCM of %i and %i ?",firstRandom,secondRandom];
        @synchronized(ANSWER_LOCK){
            answer=lcm(firstRandom, secondRandom);
        }
    }
    else
    {
        questionLabel.text=[NSString stringWithFormat:@"The HCF of %i and %i ?",firstRandom,secondRandom];
        @synchronized(ANSWER_LOCK){
            answer=gcd(firstRandom, secondRandom);
        }
    }
    optionArray=nil;
    optionArray=[[NSArray alloc]initWithArray:[self getShuffledArrayWithAnswer:[NSString stringWithFormat:@"%d",answer]]];
    return optionArray;
}



#pragma mark LOGICS in c
int gcd(int a, int b)
{
    for (;;)
    {
        if (a == 0) return b;
        b %= a;
        if (b == 0) return a;
        a %= b;
    }
}

int lcm(int a, int b)
{
    int temp = gcd(a, b);
    
    return temp ? (a / temp * b) : 0;
}

-(NSMutableArray *)getShuffledArrayWithAnswer:(NSString *)correctAnswer
{
    int localTemp=(int)[correctAnswer integerValue];
    NSMutableArray *tempArray=[[NSMutableArray alloc]initWithCapacity:0];
    [tempArray addObject:[NSNumber numberWithInt:localTemp]];
    [tempArray addObject:[NSNumber numberWithInt:abs(localTemp-[self getRandomNumber:1 to:100])]];
    [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:1 to:100]]];
    [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:1 to:100]]];
    
    NSSet *uniqueTempArray=[NSSet setWithArray:tempArray];
    
    //check to avoid repeating option generated randomly..
    if (uniqueTempArray.count<tempArray.count) {
        [tempArray removeAllObjects];
        [tempArray addObject:[NSNumber numberWithInt:localTemp]];
        [tempArray addObject:[NSNumber numberWithInt:abs(localTemp-[self getRandomNumber:1 to:100])]];
        [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:101 to:150]]];
        [tempArray addObject:[NSNumber numberWithInt:localTemp+[self getRandomNumber:151 to:200]]];
    }
    
    
    for (int x = 0; x < [tempArray count]; x++) {
        int randInt = (arc4random() % ([tempArray count] - x)) + x;
        [tempArray exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    return tempArray;
}


#pragma mark Diplay options




-(void)makeDisplayGrid
{
    NSArray *arrayWithResult=[self refreshQuestion];
    // 4444 for missile
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UIImageView class]]&& view.tag==4444) {
            [view removeFromSuperview];
        }
        
        if (view.tag==1 && view.tag==2 &&view.tag==3 &&view.tag==4)  {
            [view removeFromSuperview];
        }
    }
    int xValue=114;
    int yValue=300;
    int width=100;
    int height=100;
    
    for (int count=0; count<[arrayWithResult count]; count++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(xValue, yValue, width, height)];
        label.tag=count+1;
        label.opaque=YES;
        label.layer.cornerRadius=50.0;
        label.layer.borderWidth=1.0;
        
        [label setBackgroundColor:[UIColor colorWithRed:59/255.0 green:0/255.0 blue:133/255.0 alpha:1.0]];
        
        
        label.font=[UIFont fontWithName:@"Marker Felt" size:30];
        label.textColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=[NSString stringWithFormat:@"%@",[arrayWithResult objectAtIndex:count]];
        if ([[arrayWithResult objectAtIndex:count] intValue]==answer) {
            correctAnswerLabelTag=label.tag;
        }
        xValue=xValue+width+50;
        [self.view addSubview:label];
    }
}



-(void)refreshDisplayGrid
{
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UIImageView class]]&& view.tag==4444) {
            [view removeFromSuperview];
        }}
    
    NSArray *arrayWithResult=[self refreshQuestion];
    int index=0;
    for (UILabel *options  in self.view.subviews) {
        if ([options isKindOfClass:[UILabel class]] && options.tag>0 && options.tag<5 ) {  //instropection
            
            if ([[arrayWithResult objectAtIndex:index] intValue]==answer) {
                correctAnswerLabelTag=(int)options.tag;
            }
            [options setText:[NSString stringWithFormat:@"%@",[arrayWithResult objectAtIndex:index++]]];
        }
    }
    
}


-(void) dragTank : (UIImageView *) sender {
    
    sender.center=[tapGestureRecognizer locationInView:self.view];
}


- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [self handleMovementView:recognizer];
        for (UIView *optionLabel in self.view.subviews)
    {
        if ([optionLabel isKindOfClass:[UILabel class]]&& optionLabel.tag>0 && optionLabel.tag<5) {
            if (recognizer.view.center.x >= optionLabel.center.x-49 && recognizer.view.center.x <= optionLabel.center.x+49 )
            {
                _targetCenter=CGPointMake(recognizer.view.center.x, optionLabel.center.y);
                [optionLabel setBackgroundColor:[UIColor redColor]];
                currentHighlightedTag=(int)optionLabel.tag;
                break;
            }
            else
            {
                [optionLabel setBackgroundColor:[UIColor colorWithRed:59/255.0 green:0/255.0 blue:133/255.0 alpha:1.0]];
                currentHighlightedTag=12345;
            }
        }
        else
        {
            _targetCenter=CGPointMake(recognizer.view.center.x, 0);
        }
    }
}


-(void)handleMovementView:(UIPanGestureRecognizer *)recognizer
{
    CGPoint movement;
    
    if(recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged || recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGRect rec = recognizer.view.frame;
        CGRect imgvw = tanker.frame;
        if((rec.origin.x >= imgvw.origin.x && (rec.origin.x + rec.size.width <= imgvw.origin.x + imgvw.size.width)))
        {
            CGPoint translation = [recognizer translationInView:recognizer.view.superview];
            movement = translation;
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
            rec = recognizer.view.frame;
            
            
            if (rec.origin.x<self.view.frame.origin.x+20)
                rec.origin.x = imgvw.origin.x;
            
            
            if (rec.origin.x>self.view.frame.size.width-200)
                rec.origin.x = self.view.frame.size.width-200;
            
            
            if( rec.origin.y < imgvw.origin.y )
                rec.origin.y = imgvw.origin.y;
            
            if( rec.origin.y + rec.size.width > imgvw.origin.y + imgvw.size.width )
                rec.origin.y = imgvw.origin.y + imgvw.size.width - rec.size.width;
            
            recognizer.view.frame = rec;
            [recognizer setTranslation:CGPointZero inView:recognizer.view.superview];
        }
    }
    
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    recognizer.enabled=NO;
    recognizer.view.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        recognizer.view.transform = CGAffineTransformMakeTranslation(0,+10);
    } completion:^(BOOL finished){
        recognizer.view.transform = CGAffineTransformMakeTranslation(0,-10);
    }];
    
    UIImage *lazerImage = [UIImage imageNamed:@"missile"];
    __block UIImageView *lazerImageView = [[UIImageView alloc] initWithImage:lazerImage];
    lazerImageView.tag=4444;
    [lazerImageView setFrame:CGRectMake(0, 0, 20, 20)];
    [lazerImageView setCenter:recognizer.view.center];
    [self.view addSubview:lazerImageView];
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [lazerImageView setCenter:_targetCenter];
        
        // [lazerImageView setCenter:_targetCenter];
        [audioToolBox playSound:@"lazer_ship" withExtension:@"caf"];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            lazerImageView.center=CGPointMake([self targetCenter:_targetCenter].x, _targetCenter.y);
            CGAffineTransform zoom    = CGAffineTransformMakeScale(7.0, 7.0);
            lazerImageView.transform=zoom;
            
            
            if (correctAnswerLabelTag==currentHighlightedTag ) {
                ++scoreCount;
                if (scoreCount%5==0) {
                    [self refreshGiftWithCount:++totalGiftObject];
                }
                [audioToolBox playSound:@"powerup" withExtension:@"caf"];
                [lazerImageView setImage:[UIImage imageNamed:@"thumbs-up"]];
                
            }
            else if (_targetCenter.y==0){
                [audioToolBox playSound:@"explosion_large" withExtension:@"mp3"];
                [lazerImageView setImage:[UIImage imageNamed:@"boom"]];
            }
            
            else {
                [audioToolBox playSound:@"shake" withExtension:@"caf"];
                [lazerImageView setImage:[UIImage imageNamed:@"thumbs-down"]];
            }
        }completion:^(BOOL finished) {
            
            
            if (totalQuestionCount>=TOTAL_QUESTION_COUNT) {
                [self presentViewController:modal animated:YES completion:NULL];
                modal.view.bounds=modal.view.superview.bounds;
                modal.view.superview.layer.cornerRadius    = 15.0f;
                modal.view.superview.clipsToBounds         = YES;
                
                goodies=[[Goodies alloc]initWithFrame:CGRectZero Count:totalGiftObject giftimage:@"gift-box"];
                goodies.tag=6666;
                goodies.center=modal.view.center;
                [modal.view addSubview:goodies];
                [self centerButtonAnimation:goodies];
                [resultLabel setText:[NSString stringWithFormat:@"Game Over\n \nScore : %d",scoreCount]
                 ];
                
            }
            [self refreshDisplayGrid];
            recognizer.enabled=YES;
            
        }];
    }];
    
}


-(CGPoint )targetCenter:(CGPoint )point
{
    for (UILabel *lbl in [self.view subviews]) {
        if ([lbl isKindOfClass:[UILabel class]]&& lbl.tag>0 && lbl.tag<5) {
            if (CGRectContainsPoint (lbl.frame, point ))
            {
                return lbl.center;
            }
        }}
    return point;
}

-(void)startEmmitter
{
    for (CALayer *layer in self.view.layer.sublayers) {
        if (layer.class == [CAEmitterLayer class]) {
            [layer removeFromSuperlayer];
            break;
        }
        
    }
    CAEmitterLayer *emiterLayer=[CAEmitterLayer layer];
    emiterLayer.emitterPosition =CGPointMake(self.view.center.x, 0);
    //CGPointMake(self.view.bounds.size.width/2,self.view.bounds.origin.y);
    emiterLayer.emitterZPosition=10;
    emiterLayer.emitterSize=CGSizeMake(self.view.bounds.size.width, 0);
    emiterLayer.emitterShape = kCAEmitterLayerSphere;
    
    CAEmitterCell * emitterCell = [CAEmitterCell emitterCell];
    emitterCell.scale = 0.2;
    emitterCell.scaleRange = 0.2;
    emitterCell.birthRate = 20;
    emitterCell.emissionRange = 269.0;
    emitterCell.lifetime = 8.0;
    emitterCell.velocity = 5;
    emitterCell.velocityRange = 150;
    emitterCell.yAcceleration = 10;
    emitterCell.contents = (id)[[UIImage imageNamed:@"spark"] CGImage];
    emiterLayer.emitterCells = [NSArray arrayWithObject:emitterCell];
    [self.view.layer addSublayer:emiterLayer];
}
- (void)centerButtonAnimation:(UIView *)view{
    CAKeyframeAnimation *centerZoom = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    centerZoom.duration = 1.0f;
    centerZoom.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    centerZoom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [view.layer addAnimation:centerZoom forKey:@"buttonScale"];
}
-(void)buttonActionMethod:(UIButton *)sender
{
    UIViewController *modalForRules=[[UIViewController alloc]init];
    modalForRules.view.backgroundColor=[UIColor colorWithRed:132/255.0 green:240/255.0 blue:88/255.0 alpha:1];
    modalForRules.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    modalForRules.modalPresentationStyle=UIModalPresentationFormSheet;
    [self presentViewController:modalForRules animated:YES completion:NULL];
    UITapGestureRecognizer *tapEvent=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapOnModal:)];
    [modalForRules.view addGestureRecognizer:tapEvent];
    UILabel *instructionLabelTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 25,modalForRules.view.frame.size.width-30, 50)];
    instructionLabelTitle.numberOfLines=1;
    instructionLabelTitle.backgroundColor=[UIColor clearColor];
    instructionLabelTitle.textAlignment=NSTextAlignmentCenter;
    instructionLabelTitle.font=[UIFont fontWithName:RULES_FONT_NAME size:35];
    instructionLabelTitle.text=@"Rules";
    [modalForRules.view addSubview:instructionLabelTitle];
    
    
    UILabel *instructionLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, modalForRules.view.frame.size.width-30, modalForRules.view.frame.size.height-100)];
    instructionLabel.numberOfLines=0;
    instructionLabel.backgroundColor=[UIColor clearColor];
    instructionLabel.textAlignment=NSTextAlignmentLeft;
    instructionLabel.font=[UIFont fontWithName:RULES_FONT_NAME size:30];
    instructionLabel.text=@"\t\ta) Allign the aircfart to the right answer and then tap to fire on correct answer.\n\n\t\tb) If the answer is correct thumbs up & if wrong thumbs down  is dispalyed.\n\n\t\tc)For every 5 correct answer you get a goodies.\n\n\n \t\t\t\t [ Tap to dismiss. ]";
    [modalForRules.view addSubview:instructionLabel];
}


-(void)handleTapOnModal:(UITapGestureRecognizer *)recognizer
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [audioToolBox dispose];
}


@end
