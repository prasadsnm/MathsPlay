//
//  Questionare.h
//  MathsPlay
//
//  Created by qainfotech on 29/01/14.
//  Copyright (c) 2014 qainfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Questionare : NSManagedObject

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSString * firstoption;
@property (nonatomic, retain) NSString * firsttitle;
@property (nonatomic, retain) NSString * forthoption;
@property (nonatomic, retain) NSString * forthtitle;
@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * secondoption;
@property (nonatomic, retain) NSString * secondtitle;
@property (nonatomic, retain) NSString * thirdoption;
@property (nonatomic, retain) NSString * thirdtitle;
@property (nonatomic, retain) NSString * qid;

@end
