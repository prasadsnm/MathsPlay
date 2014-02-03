//
//  Questionare.h
//  MathsPlay
//
//  Created by qainfotech on 30/01/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Questionare : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * graphFirstInputValue;
@property (nonatomic, retain) NSString * graphFirstTitleText;
@property (nonatomic, retain) NSString * graphFourthInputValue;
@property (nonatomic, retain) NSString * graphFourtTitleText;
@property (nonatomic, retain) NSString * graphSecondInputValue;
@property (nonatomic, retain) NSString * graphSecondTitleText;
@property (nonatomic, retain) NSString * graphThirdInputValue;
@property (nonatomic, retain) NSString * graphThirdTitleText;
@property (nonatomic, retain) NSString * level;
@property (nonatomic, retain) NSString * qid;
@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * radioFirstLabelText;
@property (nonatomic, retain) NSString * radioFourthLabelText;
@property (nonatomic, retain) NSString * radioSecondLabelText;
@property (nonatomic, retain) NSString * radioThirdLabelText;
@property (nonatomic, retain) NSString * xAxisTitle;
@property (nonatomic, retain) NSString * yAxisTitle;

@end
