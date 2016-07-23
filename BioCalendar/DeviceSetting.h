//
//  DeviceSetting.h
//  TMG_iPad_HCCC
//
//  Created by Sangwook Nam on 11/19/14.
//  Copyright (c) 2014 tionsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceSetting : NSObject

+ (BOOL)isKorean;
+ (NSLocale *)getLocaleFromCurrentSetting;
+ (NSDateFormatter *)getDateFormatterFromCurrentSetting;

@end
