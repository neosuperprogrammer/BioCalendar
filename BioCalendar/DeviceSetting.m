//
//  DeviceSetting.m
//  TMG_iPad_HCCC
//
//  Created by Sangwook Nam on 11/19/14.
//  Copyright (c) 2014 tionsoft. All rights reserved.
//

#import "DeviceSetting.h"
#import "Setting.h"

@implementation DeviceSetting

+ (BOOL)isKorean
{
    NSString *lang = [Setting languageCode];
    if ([lang isEqualToString:@"ko"]) {
        return YES;
    }
    return NO;
}

+ (NSLocale *)getLocaleFromCurrentSetting
{
    return [[NSLocale alloc] initWithLocaleIdentifier:[DeviceSetting isKorean] ? @"ko_KR" : @"en_US"];
}

+ (NSDateFormatter *)getDateFormatterFromCurrentSetting
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [DeviceSetting getLocaleFromCurrentSetting];
    return dateFormatter;
}

@end
