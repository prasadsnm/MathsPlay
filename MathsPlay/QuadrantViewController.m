//
//  QuadrantViewController.m
//  MathsPlay
//
//  Created by qainfotech on 27/01/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import "QuadrantViewController.h"
#import "AppDelegate.h"
#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)
@interface QuadrantViewController ()
{
    BarChartView *barChart;
    NSString *question;
    CGFloat answer,firstOption,secondoption;
    UILabel *questionLabel;
    RadioButton *optionOne, *optionTwo,*optionThree,*optionFour;
    UILabel *optionOneTitleLabel,*optionTwoTitleLabel,*optionThreeTitleLabel,*optionFourTitleLabel;
    UILabel *verticalLabel,*horizontalLabel;
    UIAlertView *_progresAlert;
    int myCounter;
    UIBarButtonItem *rightBarButton;
    BOOL answerChoosen;
}
@end

@implementation QuadrantViewController
@synthesize answer=_answer;
@synthesize sharedResultSet=_sharedResultSet;
@synthesize count=_count;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(id)init
{
    self=[super init];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View did Load");
    SET_USERNAME_AS_TITLE
    myCounter=0;
    questionLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height/2+70, self.view.frame.size.width-100, 60)];
    questionLabel.text=@"";
    questionLabel.numberOfLines=0;
    questionLabel.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:questionLabel];
    
    // radio button
    optionOne=[[RadioButton alloc]initWithFrame:CGRectMake(50,  650, 30, 30)];
    optionOne.tag=1;
    optionOne.delegate=self;
    [self.view addSubview:optionOne];
    optionOneTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 650, 80, 30)];
    optionOneTitleLabel.textAlignment=NSTextAlignmentLeft;
    optionOneTitleLabel.textColor=[UIColor blackColor];
    optionOneTitleLabel.tag=10;
    [self.view addSubview:optionOneTitleLabel];
    
    optionTwo=[[RadioButton alloc]initWithFrame:CGRectMake(50,  700, 30, 30)];
    optionTwo.tag=2;
    optionTwo.delegate=self;
    [self.view addSubview:optionTwo];
    optionTwoTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 700, 80, 30)];
    optionTwoTitleLabel.textAlignment=NSTextAlignmentLeft;
    optionTwoTitleLabel.textColor=[UIColor blackColor];
    optionTwoTitleLabel.tag=20;
    [self.view addSubview:optionTwoTitleLabel];
    
    optionThree=[[RadioButton alloc]initWithFrame:CGRectMake(50,  750, 30, 30)];
    optionThree.tag=3;
    optionThree.delegate=self;
    [self.view addSubview:optionThree];
    optionThreeTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 750, 80, 30)];
    optionThreeTitleLabel.textAlignment=NSTextAlignmentLeft;
    optionThreeTitleLabel.textColor=[UIColor blackColor];
    optionThreeTitleLabel.tag=30;
    [self.view addSubview:optionThreeTitleLabel];
    
    optionFour=[[RadioButton alloc]initWithFrame:CGRectMake(50,  800, 30, 30)];
    optionFour.tag=4;
    optionFour.delegate=self;
    [self.view addSubview:optionFour];
    optionFourTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 800, 80, 30)];
    optionFourTitleLabel.textAlignment=NSTextAlignmentLeft;
    optionFourTitleLabel.textColor=[UIColor blackColor];
    optionFourTitleLabel.tag=40;
    [self.view addSubview:optionFourTitleLabel];
    
    horizontalLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, questionLabel.origin.y-50, self.view.frame.size.width-100, 50)];
    horizontalLabel.text=@"";
    horizontalLabel.numberOfLines=0;
    horizontalLabel.textAlignment=NSTextAlignmentCenter;
    horizontalLabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:horizontalLabel];
    
    
    verticalLabel=[[UILabel alloc]initWithFrame:CGRectMake(-230, 300, self.view.frame.size.height/2, 50)];
    verticalLabel.text=@"";
    verticalLabel.numberOfLines=0;
    verticalLabel.textAlignment=NSTextAlignmentCenter;
    verticalLabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:verticalLabel];
    verticalLabel.transform= CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(270));
    
    
    rightBarButton = [[UIBarButtonItem alloc]
                      initWithTitle:@"Next Question"
                      style:UIBarButtonItemStyleBordered
                      target:self
                      action:@selector(next)];
    self.navigationItem.rightBarButtonItem = rightBarButton;

}

#pragma mark - Radio Button

-(void)didSelectedOption:(NSInteger)option{
    NSString *status,*message;
    NSLog(@"%@", _sharedResultSet.answer) ;
    UILabel *lbl=(UILabel *)[self.view viewWithTag:option*10];
    if ([_sharedResultSet.answer isEqualToString:lbl.text]) {
        status=@"Hurray !!";
        message=@"Correct Answer",
        [self refreshGraph];
        [self next];
    }
    else{
        status=@"Wrong Answer!!";
        message=@"Try Again";

    }
    _progresAlert = [[UIAlertView alloc] initWithTitle:status message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [_progresAlert show];
    switch (option) {
            answerChoosen=YES;
        case 1:{
            optionTwo.selected=NO;
            optionThree.selected=NO;
            optionFour.selected=NO;
            
        }break;
        case 2:
            optionOne.selected=NO;
            optionThree.selected=NO;
            optionFour.selected=NO;
            break;
            
        case 3:
            optionOne.selected=NO;
            optionTwo.selected=NO;
            optionFour.selected=NO;
            break;
            
        case 4:
            optionOne.selected=NO;
            optionTwo.selected=NO;
            optionThree.selected=NO;
            break;
        default:
            break;
    }
    
}






#pragma mark - Bar Chart Setup

- (void)loadBarChartUsingArray :(Questionare *)result {
    
    if (result) {
        [barChart removeFromSuperview];
        barChart=[[BarChartView alloc]initWithFrame:CGRectMake(50, 50, self.view.frame.size.width-100, (self.view.frame.size.height)/2)];
        barChart.userInteractionEnabled=YES;
        [self.view addSubview:barChart];
        //Generate properly formatted data to give to the bar chart
        NSArray *array = [barChart createChartDataWithTitles:[NSArray arrayWithObjects:result.graphFirstTitleText,result.graphSecondTitleText, result.graphThirdTitleText, result.graphFourtTitleText, nil]values:[NSArray arrayWithObjects:result.graphFourthInputValue , result.graphSecondInputValue,result.graphThirdInputValue, result.graphFourthInputValue , nil]colors:[NSArray arrayWithObjects:@"87E317", @"0000FF", @"FF0000", @"9B30FF", nil]labelColors:[NSArray arrayWithObjects:@"FF0000", @"FF0000", @"FF0000", @"FF0000", nil]];
        
        //Set the Shape of the Bars (Rounded or Squared) - Rounded is default
        [barChart setupBarViewShape:BarShapeSquared];
        
        //Set the Style of the Bars (Glossy, Matte, or Flat) - Glossy is default
        [barChart setupBarViewStyle:BarStyleGlossy];
        
        //Set the Drop Shadow of the Bars (Light, Heavy, or None) - Light is default
        [barChart setupBarViewShadow:BarShadowHeavy];
        
        //Generate the bar chart using the formatted data
        [barChart setDataWithArray:array
                          showAxis:DisplayBothAxes
                         withColor:[UIColor lightGrayColor]
           shouldPlotVerticalLines:NO];
        
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            questionLabel.text=[NSString stringWithFormat:@"%@)%@",result.qid,result.question ];
            optionOneTitleLabel.text=result.radioFirstLabelText;
            optionTwoTitleLabel.text=result.radioSecondLabelText;
            optionThreeTitleLabel.text=result.radioThirdLabelText;
            optionFourTitleLabel.text=result.radioFourthLabelText;
            horizontalLabel.text=result.xAxisTitle;
            verticalLabel.text=result.yAxisTitle;
            _answer=result.answer;
        });
        
    }
    else
    {
        NSLog(@"no data found");
    }
    
}


-(void)next
{
        if (myCounter<_count) {
            
            NSLog(@"myCounter:%d _count:%ld",myCounter,(long)_count);
            
            _sharedResultSet= [[self getAllQuestion] objectAtIndex:myCounter];
            [self loadBarChartUsingArray:_sharedResultSet];
        }
        if (myCounter==_count-1) {
            self.navigationItem.rightBarButtonItem = nil;
        }
        myCounter++;

}

-(void)refreshGraph
{
    optionOne.selected=NO;
    optionTwo.selected=NO;
    optionThree.selected=NO;
    optionFour.selected=NO;
    questionLabel.text=@"";
    optionOneTitleLabel.text=@"";
    optionTwoTitleLabel.text=@"";
    optionThreeTitleLabel.text=@"";
    optionFourTitleLabel.text=@"";
    
    horizontalLabel.text=@"";
    verticalLabel.text=@"";
    
}

-(void)addQuestion
{
    static int tempID = 1;
    Questionare * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Questionare"
                                                           inManagedObjectContext:self.managedObjectContext];
    newEntry.question = @"Which Year Population rise is maximum?";
    newEntry.answer =@"2012";
    newEntry.xAxisTitle=@"Population Rise Trend";
    newEntry.yAxisTitle=@"Percentage";
    newEntry.level=@"Easy";
    newEntry.radioFirstLabelText=@"2010";
    newEntry.radioSecondLabelText=@"2011";
    newEntry.radioThirdLabelText=@"2012";
    newEntry.radioFourthLabelText=@"2013";
    newEntry.graphFirstTitleText=@"2010";
    newEntry.graphSecondTitleText=@"2011";
    newEntry.graphThirdTitleText=@"2012";
    newEntry.graphFourtTitleText=@"2013";
    newEntry.graphFirstInputValue=@"15";
    newEntry.graphSecondInputValue=@"66";
    newEntry.graphThirdInputValue=@"77";
    newEntry.graphFourthInputValue=@"21";
    newEntry.qid=[NSString stringWithFormat:@"%i",tempID];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self.view endEditing:YES];
}

-(NSArray *)getAllQuestion
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Questionare"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        return fetchedRecords;
}


-(void)addQuestionToDatabase
{
    CATransition *anim = [CATransition animation];
    anim.duration = 1;
    anim.type = @"oglFlip";
    anim.subtype = @"fromRight";
    [self.navigationController.view.layer addAnimation:anim forKey:@"an"];
}





-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"View will appear");
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    if ([[self getAllQuestion] count]) {
        _count=[[self getAllQuestion]count];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self next];
}

-(void)finished
{
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
