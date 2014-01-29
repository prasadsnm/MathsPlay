//
//  QuadrantViewController.m
//  MathsPlay
//
//  Created by qainfotech on 27/01/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import "QuadrantViewController.h"

@interface QuadrantViewController ()
{
    BarChartView *barChart;
    NSString *question;
    CGFloat answer,firstOption,secondoption;
    UILabel *questionLabel;
    RadioButton *optionOne, *optionTwo,*optionThree,*optionFour;
    UILabel *optionOneTitleLabel,*optionTwoTitleLabel,*optionThreeTitleLabel,*optionFourTitleLabel;
}
@end

@implementation QuadrantViewController
@synthesize answer=_answer;
@synthesize sharedResultSet=_sharedResultSet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *refresh=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    refresh.frame=CGRectMake(100, 600, 70, 50);
    [refresh setTitle:@"Refresh" forState:UIControlStateNormal];
    [refresh addTarget:self action:@selector(refreshGraph) forControlEvents:UIControlEventTouchUpInside];
   // [self.view addSubview:refresh];
    
    questionLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height/2+5, self.view.frame.size.width-100, 100)];
    questionLabel.text=@"";
    questionLabel.numberOfLines=0;
    questionLabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:questionLabel];
    

	// Do any additional setup after loading the view.
    
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    // radio button
    optionOne=[[RadioButton alloc]initWithFrame:CGRectMake(50,  650, 30, 30)];
    optionOne.tag=1;
    optionOne.delegate=self;
    [self.view addSubview:optionOne];
    optionOneTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 650, 50, 30)];
    optionOneTitleLabel.textAlignment=NSTextAlignmentLeft;
    optionOneTitleLabel.textColor=[UIColor blackColor];
    optionOneTitleLabel.tag=10;
    [self.view addSubview:optionOneTitleLabel];
    
    
    
    
    
    optionTwo=[[RadioButton alloc]initWithFrame:CGRectMake(50,  700, 30, 30)];
    optionTwo.tag=2;
    optionTwo.delegate=self;
    [self.view addSubview:optionTwo];
    optionTwoTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 700, 50, 30)];
    optionTwoTitleLabel.textAlignment=NSTextAlignmentLeft;
    optionTwoTitleLabel.textColor=[UIColor blackColor];
    optionTwoTitleLabel.tag=20;
    [self.view addSubview:optionTwoTitleLabel];
    
    
    
    optionThree=[[RadioButton alloc]initWithFrame:CGRectMake(50,  750, 30, 30)];
    optionThree.tag=3;
    optionThree.delegate=self;
    [self.view addSubview:optionThree];
    optionThreeTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 750, 50, 30)];
    optionThreeTitleLabel.textAlignment=NSTextAlignmentLeft;
    optionThreeTitleLabel.textColor=[UIColor blackColor];
    optionThreeTitleLabel.tag=30;
    [self.view addSubview:optionThreeTitleLabel];
    
    optionFour=[[RadioButton alloc]initWithFrame:CGRectMake(50,  800, 30, 30)];
    optionFour.tag=4;
    optionFour.delegate=self;
    [self.view addSubview:optionFour];
    optionFourTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 800, 50, 30)];
    optionFourTitleLabel.textAlignment=NSTextAlignmentLeft;
    optionFourTitleLabel.textColor=[UIColor blackColor];
    optionFourTitleLabel.tag=40;
    [self.view addSubview:optionFourTitleLabel];
    [self refreshGraph];

}

#pragma mark - Radio Button

-(void)didSelectedOption:(NSInteger)option{

    UILabel *lbl=(UILabel *)[self.view viewWithTag:option*10];
    if ([_sharedResultSet.answer isEqualToString:lbl.text]) {
        NSLog(@"Correct answer");
    }
    else
        NSLog(@"wrong answer");

    
   switch (option) {
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
    [self refreshGraph];
    
}






#pragma mark - Bar Chart Setup

- (void)loadBarChartUsingArray :(Questionare *)result {

    if (result) {
        [barChart removeFromSuperview];
        barChart=[[BarChartView alloc]initWithFrame:CGRectMake(50, 50, self.view.frame.size.width-100, self.view.frame.size.height/2)];
        barChart.userInteractionEnabled=YES;
        
        
        
        [self.view addSubview:barChart];
        //Generate properly formatted data to give to the bar chart
        NSArray *array = [barChart createChartDataWithTitles:[NSArray arrayWithObjects:result.firsttitle,result.secondtitle, result.thirdtitle, result.forthtitle, nil]
                                                      values:[NSArray arrayWithObjects:result.firstoption , result.secondoption,result.thirdoption, result.forthoption , nil]
                                                      colors:[NSArray arrayWithObjects:@"87E317", @"0000FF", @"FF0000", @"9B30FF", nil]
                                                 labelColors:[NSArray arrayWithObjects:@"FF0000", @"FF0000", @"FF0000", @"FF0000", nil]];
        
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
            questionLabel.text=result.question;
            optionOneTitleLabel.text=result.firsttitle;
            optionTwoTitleLabel.text=result.secondtitle;
            optionThreeTitleLabel.text=result.thirdtitle;
            optionFourTitleLabel.text=result.forthtitle;
            _answer=result.answer;
        });

    }
    else
        NSLog(@"no data found");

    
    
    
}


-(void)refreshGraph
{
    [self addQuestion];
    if ([[self getAllQuestion] count]) {
        _sharedResultSet= [[self getAllQuestion] lastObject];
        [self loadBarChartUsingArray:_sharedResultSet];
}

    optionOne.selected=NO;
    optionTwo.selected=NO;
    optionThree.selected=NO;
    optionFour.selected=NO;
    
    questionLabel.text=@"";
    optionOneTitleLabel.text=@"";
    optionTwoTitleLabel.text=@"";
    optionThreeTitleLabel.text=@"";
    optionFourTitleLabel.text=@"";
    
}

-(void)addQuestion
{
    
    static int tempID = 0;
    
    // Add Entry to PhoneBook Data base and reset all fields
    Questionare * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Questionare"
                                                      inManagedObjectContext:self.managedObjectContext];

    newEntry.question = @"Which Year Population rise is maximum?";
    newEntry.answer =@"2010";
    newEntry.firstoption =@"474.66";
    newEntry.secondoption =@"66.77";
    newEntry.thirdoption =@"55.44";
    newEntry.forthoption =@"22.44";
    
    newEntry.firsttitle=@"2010";
    newEntry.secondtitle=@"2011";
    newEntry.thirdtitle=@"2013";
    newEntry.forthtitle=@"2014";
    newEntry.qid=[NSString stringWithFormat:@"%i",tempID];

    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
     [self.view endEditing:YES];
}

-(NSArray *)getAllQuestion
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Questionare"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
 //   Questionare *result= [fetchedRecords objectAtIndex:0];
  //  NSString *str=   [NSString stringWithFormat:@" %@ %f %f %f %f %f %@ %@ %@ %@",result.question,[result.answer floatValue],[result.firstoption floatValue],[result.secondoption floatValue],[result.thirdoption floatValue],[result.forthoption floatValue],result.firsttitle,result.secondtitle,result.thirdtitle,result.forthtitle];
    
    
    // Returning Fetched Records
    return fetchedRecords;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
