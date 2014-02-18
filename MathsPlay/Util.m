//
//  Util.m
//  MathsPlay
//
//  Created by qainfotech on 10/22/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import "Util.h"


@implementation Util
BOOL ishighclass;
+ (UIFont *)themeFontWithSize:(CGFloat)size {
    
    //return [UIFont fontWithName:@"Helvetica Light" size:size];
    return [UIFont boldSystemFontOfSize:size];
}

+ (NSMutableDictionary *)readPListData
{
    NSError *error;
	NSArray *p = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
	
	NSString *paths = [p description];
    NSString *documentsPath=[p objectAtIndex:0];
    NSString *path = [documentsPath stringByAppendingPathComponent:@"appData.plist"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if(![fileManager fileExistsAtPath:paths])
	{
		NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"appData" ofType:@"plist"];
		[fileManager copyItemAtPath:bundlePath toPath:path error:&error];
	}
    
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    return dictionary;
}


+ (void)writeToPlist:(NSMutableDictionary *) _dictionary
{
    NSArray *p = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath=[p objectAtIndex:0];
    NSString *path = [documentsPath stringByAppendingPathComponent:@"appData.plist"];
    [_dictionary writeToFile:path atomically:YES];
}

@end
