//
//  Util.h
//  MathsPlay
//
//  Created by qainfotech on 10/22/13.
//  Copyright (c) 2013 qainfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<AVFoundation/AVFoundation.h>

extern BOOL ishighclass;

@interface Util : NSObject

+ (UIFont *)themeFontWithSize:(CGFloat)size;
+ (NSMutableDictionary *)readPListData;
+ (void)writeToPlist:(NSMutableDictionary *) _dictionary;

@end
