//
//  DatePickerController.m
//  iPad_HKMC
//
//  Created by Hyunmin Kang on 12. 11. 17..
//  Copyright (c) 2012년 BTB Solution Co., Ltd. All rights reserved.
//

#import "DatePickerController.h"
//#import "UINavigationBar+Background.h"
//#import "TSClearBgActionSheet.h"
//#import "DeviceSetting.h"
//#import "CommonHeader.h"
#import "Setting.h"
#import "DeviceSetting.h"

@interface DatePickerController ()

//@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, assign) IBOutlet UILabel *selectedLabel;
@property (nonatomic, weak) IBOutlet UINavigationBar *navigationBar;

@end


@implementation DatePickerController {
    UIViewController *_parentViewController;
}

- (void)setDateFormatter:(NSDateFormatter *)dateFormatter
{
	_dateFormatter = dateFormatter;
    
	[self valueChanged:_datePicker];
}


#pragma mark -

#if __IPHONE_6_0 > __IPHONE_OS_VERSION_MIN_REQUIRED
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if( _parentViewController && [_parentViewController respondsToSelector:@selector(shouldAutorotateToInterfaceOrientation:)]){
        return [_parentViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    }
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}
#endif

#if __IPHONE_6_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if( _parentViewController ){
        UIViewController * vc = _parentViewController ;
        
        if( [_parentViewController isKindOfClass:[UINavigationController class]] ){
            UINavigationController * nav = (UINavigationController *)_parentViewController;
            NSArray * arr = nav.viewControllers;
            if( [arr count] > 1){
                vc = [arr objectAtIndex:[arr count] - 2];
            }
        }
        
        if( [vc respondsToSelector:@selector(supportedInterfaceOrientations)] ) {
            return [vc supportedInterfaceOrientations];
        }
    }
    return UIInterfaceOrientationMaskPortrait;
}
#endif

#pragma mark - Methods

//- (void)showInView:(UIView *)view
//{
//	CGRect rect = self.view.frame;
//	if (_actionSheet == nil) {
//		self.actionSheet = [[TSClearBgActionSheet alloc] initWithFrame:rect];
//		_actionSheet.backgroundColor = [UIColor clearColor];
//		[_actionSheet addSubview:self.view];
//	}
//    
//	[_actionSheet showInView:view];
//	rect.origin.y = view.frame.size.height - rect.size.height;
//	_actionSheet.frame = rect;
//}
//
- (void)showInViewController:(UIViewController *)viewController
{
//    [self hideKeyboard];
    if (viewController.navigationController != nil) {
        _parentViewController = viewController.navigationController;
    }
    else {
        _parentViewController = viewController;
    }
    
    [_parentViewController addChildViewController:self];
    [_parentViewController.view addSubview:self.view];
    
    self.view.frame = _parentViewController.view.frame;
}

// 키보드 동작 관련하여 확인 할것!

//- (void)hideKeyboard
//{
//    @try {
//        Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
//        id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
//        [activeInstance performSelector:@selector(dismissKeyboard)];
//    }
//    @catch (NSException *exception) {
//        
//    }
//}


//- (void)dismissAnimated:(BOOL)animated
//{
//	[_actionSheet dismissWithClickedButtonIndex:0 animated:animated];
//}

#pragma mark - Actions

- (IBAction)cancel:(id)sender
{
	if (_willClose != nil)
		_willClose();
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)done:(id)sender
{
	if (_didSelect != nil) {
		_didSelect(_datePicker.date);
		[self cancel:self];
	}
}

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

- (IBAction)valueChanged:(UIDatePicker *)picker
{
	if (_dateFormatter == nil) {
		self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.locale = [DeviceSetting getLocaleFromCurrentSetting];
		_dateFormatter.dateFormat = @"yyyy.MM.dd(EEE)";
	}
	_selectedLabel.text = [_dateFormatter stringFromDate:picker.date];
}


- (NSString *)languageCode
{
    static NSString *languageCode = nil;
    
    if (languageCode == nil) {
        
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        if ([language hasPrefix:@"ko"]) {
            languageCode = @"ko";
        }
        else {
            languageCode = @"en";
        }
    }
    
    return languageCode;
}


#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
	if (self.navigationController != nil) {
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        
	} else if (_navigationBar != nil && _navigationBar.barStyle != UIBarStyleBlackTranslucent)
//		[_navigationBar setBackgroundImage:[UIImage imageWithCGImage:[UIImage imageNamed:@"tb_bg_default.png"].CGImage scale:2.f orientation:0]];
    
#ifdef __IPHONE_7_0
    self.preferredContentSize = CGSizeMake(320.f, 320.f);
#else
    self.contentSizeForViewInPopover = CGSizeMake(320.f, 320.f);
#endif
    
    NSString *currentLanguage = [self languageCode];//[Global stringFromSettingKey:kLanguageSettingKey];
    if ([currentLanguage isEqualToString:@""] || [currentLanguage isEqualToString:@"ko"]) {
        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"]];
    }
    else {
        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
	[self valueChanged:_datePicker];
}

@end


//@implementation UIActionSheet (ClearBackground)
//
//- (void)drawRect:(CGRect)rect
//{
//
//}
//
//@end

