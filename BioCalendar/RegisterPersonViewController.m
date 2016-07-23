//
//  RegisterPersonViewController.m
//  UITest
//
//  Created by Sangwook Nam on 13. 5. 10..
//  Copyright (c) 2013년 Nam, SangWook. All rights reserved.
//

#import "RegisterPersonViewController.h"
#import "PersonDatas.h"
#import "NEODatePickerSheet.h"
#import "DatePickerController.h"
#import <Google/Analytics.h>

@interface RegisterPersonViewController () < UITextFieldDelegate >

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *birthdayLabel;
- (IBAction)bgTouched:(id)sender;

@end

@implementation RegisterPersonViewController

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
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"RegisterPerson", @"");
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(action:)];
    self.navigationItem.rightBarButtonItem = barButton;
    
    NSDate *today = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [format stringFromDate:today];
    _birthdayLabel.text = date;
    
//    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 44, self.view.frame.size.width, self.view.frame.size.height - 44);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"RegisterPerson"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (IBAction)action:(id)sender
{
    NSString *name = _nameLabel.text;
    NSString *birthday = _birthdayLabel.text;
    
    if(name.length < 1) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"enter name"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"done", nil];
        
        [alert show];
        return;

    }

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:birthday];
    
    [self savePerson:name birthday:date];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)savePerson:(NSString *)name birthday:(NSDate *)birthday
{
    NSString *log = [NSString stringWithFormat:@"%@, %@", name, birthday];
    NSLog(@"%@", log);
    
    [[PersonDatas getInstance] addPersonData:name birthday:birthday];
    
    [[PersonDatas getInstance] savePersonData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bgTouched:(id)sender
{
    [_nameLabel resignFirstResponder];
    [_birthdayLabel resignFirstResponder];
}

- (IBAction)pickerValueChanged:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [format stringFromDate:datePicker.date];
    _birthdayLabel.text = date;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    NEODatePickerSheet *sheet = [[NEODatePickerSheet alloc] init];
//    [sheet setConfirm:^(NSDate *date) {
//        NSDateFormatter *format = [[NSDateFormatter alloc] init];
//        [format setDateFormat:@"yyyy-MM-dd"];
//        NSString *dateString = [format stringFromDate:date];
//        _birthdayLabel.text = dateString;
//    }];
//    [sheet show:self.view];
//    return NO;
    
    
    [_nameLabel resignFirstResponder];
    DatePickerController *pickerController = [[DatePickerController alloc] initWithNibName:@"DatePickerController" bundle:nil];
    [pickerController setDidSelect:^(NSDate *date) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [format stringFromDate:date];
        _birthdayLabel.text = dateString;
    }];
    [pickerController setWillClose:^{
        
    }];
    
    [pickerController showInViewController:self];
    pickerController.datePicker.minuteInterval = 1; //5; // 안드로이드에 맞춰 1분단위로 수정
    pickerController.datePicker.datePickerMode = UIDatePickerModeDate;
//    if( self.eventKind == CnCEventFuneral ){
//        pickerController.datePicker.datePickerMode = UIDatePickerModeDate;
//    }
//    else {
//        pickerController.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
//    }
    
//    [pickerController.datePicker setDate:self.targetDate animated:NO];
    return NO;

}


@end
