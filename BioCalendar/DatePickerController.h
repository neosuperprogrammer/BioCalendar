//
//  DatePickerController.h
//  iPad_HKMC
//
//  Created by Hyunmin Kang on 12. 11. 17..
//  Copyright (c) 2012년 BTB Solution Co., Ltd. All rights reserved.
//


#import <UIKit/UIKit.h>
//#import "HCCCViewController.h"

@interface DatePickerController : UIViewController

@property (assign, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) void(^willClose)();
@property (strong, nonatomic) void(^didSelect)(NSDate *date);

//- (void)showInView:(UIView *)view;
- (void)showInViewController:(UIViewController *)viewController;
//- (void)dismissAnimated:(BOOL)animated;

@end
