//
//  NEOBiorhythmUtil.h
//  Calendar Test
//
//  Created by Nam, SangWook on 13. 4. 22..
//  Copyright (c) 2013년 Nam, SangWook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BiorhythmType) {
    physicalType = 0,
    emotionType = 1,
    intelligenceType = 2
};

@interface NEOBiorhythmUtil : NSObject

- (void)recalcBiorhythmData:(NSDateComponents *)bithDate andCurrentDate:(NSDateComponents *)currentDate;
- (double)getBiorhythm:(NSUInteger)day ofType:(BiorhythmType)type;

@end
