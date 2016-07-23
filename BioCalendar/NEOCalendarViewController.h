//
//  NEOCalendarViewController.h
//  Calendar Test
//
//  Created by Nam, SangWook on 13. 3. 27..
//  Copyright (c) 2013년 Nam, SangWook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAdView.h"

@interface NEOCalendarViewController : UIViewController <MPAdViewDelegate>

@property (nonatomic, retain) MPAdView *adView;

@end
