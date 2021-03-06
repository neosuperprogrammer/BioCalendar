//
//  NEOCalendarViewController.m
//  Calendar Test
//
//  Created by Nam, SangWook on 13. 3. 27..
//  Copyright (c) 2013년 Nam, SangWook. All rights reserved.
//

#import "NEOCalendarViewController.h"
#import "NEOTitleView.h"
#import "NEOCalendarView.h"
#import "Common.h"
#import "SelectPersonViewController.h"
#import "NEOCalloutView.h"
#import "PersonDatas.h"
#import "NEOInfoViewController.h"
#import <Crashlytics/Crashlytics.h>
#import <Google/Analytics.h>

@interface NEOCalendarViewController () <GADBannerViewDelegate>

@property (weak, nonatomic) UISegmentedControl *bioSeg;

@property (strong, nonatomic) NEOTitleView *titleView;
@property (strong, nonatomic) NEOCalendarView *prevCalendarView;
@property (strong, nonatomic) NEOCalendarView *nextCalendarView;
@property (strong, nonatomic) NEOCalendarView *currCalendarView;
@property (strong, nonatomic) NSDateComponents *currentDateComp;
@property (strong, nonatomic) NEOCalloutView *popOver;
@property (nonatomic) BiorhythmType biorhythmType;

@end

//test

#pragma mark -

@implementation NEOCalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _biorhythmType = physicalType;
        _popOver = [[NEOCalloutView alloc] initWithFrame:CGRectZero];
        
        
        [self setupLayout];
        
        self.title = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
        // TODO: Replace this test id with your personal ad unit id


    }
    return self;
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self showCalendar];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"") style:UIBarButtonItemStylePlain target:nil action:nil];

    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = UIColorFromRGB(0x27ae60);
    
#if 0
    MPAdView* adView = [[MPAdView alloc] initWithAdUnitId:@"0fd404de447942edb7610228cb412614"
                                                     size:MOPUB_BANNER_SIZE];
#else
    MPAdView* adView = [[MPAdView alloc] initWithAdUnitId:@"98c06e78f5ce49d2b7b1506518778fb2"
                                                     size:MOPUB_BANNER_SIZE];
#endif
    
    self.adView = adView;
    self.adView.delegate = self;
    
    // Positions the ad at the bottom, with the correct size
    self.adView.frame = CGRectMake(0, self.view.bounds.size.height - MOPUB_BANNER_SIZE.height - 44,
                                   MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
//    [self.view addSubview:self.adView];

    // Loads the ad over the network
//    [self.adView loadAd];
    
    [self reloadBanner];
//    self.bannerView =  [[GADBannerView alloc] init];
//    self.bannerView.frame = CGRectMake(0, self.view.bounds.size.height - MOPUB_BANNER_SIZE.height - 44,
//                                   MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
//    [self.view addSubview:self.bannerView];
//    
////    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
//    GADRequest *request = [GADRequest request];
////#if DEBUG
//////    request.testDevices = @[ @"27847f3688aa95517a8a0b03bd9f2ea3" ];
////    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
////#else
//    self.bannerView.adUnitID = @"ca-app-pub-9254009028575157/5429505022";
////#endif
//    self.bannerView.rootViewController = self;
//    [self.bannerView loadRequest:request];
//    self.bannerView.backgroundColor = UIColorFromRGB(0x27ae60);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(foregroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)foregroundNotification {
//    GADRequest *request = [GADRequest request];
//    [self.bannerView loadRequest:request];
    [self reloadBanner];
}

- (void)backgroundNotification {
    if (self.bannerView != nil) {
        [self.bannerView removeFromSuperview];
        self.bannerView = nil;
    }
}

- (void)reloadBanner {
    if (self.bannerView != nil) {
        [self.bannerView removeFromSuperview];
        self.bannerView = nil;
    }
    self.bannerView =  [[GADBannerView alloc] init];
    self.bannerView.frame = CGRectMake(0, self.view.bounds.size.height - MOPUB_BANNER_SIZE.height - 44,
                                       self.view.bounds.size.width, MOPUB_BANNER_SIZE.height);
    [self.view addSubview:self.bannerView];
    
    //    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    GADRequest *request = [GADRequest request];
//    #if DEBUG
//    //    request.testDevices = @[ @"27847f3688aa95517a8a0b03bd9f2ea3" ];
//        self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
//    #else
    self.bannerView.adUnitID = @"ca-app-pub-9254009028575157/5429505022";
//    #endif
    self.bannerView.delegate = self;
    self.bannerView.rootViewController = self;
    self.bannerView.autoloadEnabled = YES;
    [self.bannerView loadRequest:request];
    self.bannerView.backgroundColor = UIColorFromRGB(0x27ae60);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"MainView"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    [self.navigationController setToolbarHidden:NO animated:animated];
    
    UIBarButtonItem *barBtnLeft = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SelectPerson", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(action:)];
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UISegmentedControl *bioSeg = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"Physical", @""), NSLocalizedString(@"Emotional", @""), NSLocalizedString(@"Intelligence", @"")]];
    _bioSeg = bioSeg;
    [_bioSeg addTarget:self action:@selector(segSelected:) forControlEvents:UIControlEventValueChanged];
    _bioSeg.segmentedControlStyle = UISegmentedControlStyleBar;
    [_bioSeg setSelectedSegmentIndex:_biorhythmType];
    
    UIBarButtonItem *segBarButton = [[UIBarButtonItem alloc] initWithCustomView:_bioSeg];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *infoBarButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    self.toolbarItems = @[barBtnLeft, flexible, segBarButton, flexible];
    
    [self segSelected:_bioSeg];
    
    
    [_currCalendarView setDateComponent:self.currentDateComp];
//    self.navigationItem.prompt = [[PersonDatas getInstance] getSelectedPersonInfo];
    
    [self layoutFrame];

}

- (IBAction)info:(id)sender
{
    NEOInfoViewController *viewController = [[NEOInfoViewController alloc] initWithNibName:NSStringFromClass([NEOInfoViewController class]) bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [navi setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:navi animated:YES completion:^{
        
    }];
}

#if __IPHONE_6_0 > __IPHONE_OS_VERSION_MIN_REQUIRED
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation == UIInterfaceOrientationPortrait;
}
#endif

#if __IPHONE_6_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
#endif

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self layoutFrame];
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (IBAction)segSelected:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    _biorhythmType = seg.selectedSegmentIndex;
    
    self.title = [NSString stringWithFormat:@"%@(%@)-%@", @"Biorhythm", [seg titleForSegmentAtIndex:seg.selectedSegmentIndex], [[PersonDatas getInstance] getSelectedPersonInfo]];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self changeBiorhythmType];
    if ([_popOver isShowing]) {
        [_popOver hide:YES];
    }
}

- (void)changeBiorhythmType
{
    _currCalendarView.biorhythmType = _biorhythmType;
    [_currCalendarView setDateComponent:_currCalendarView.dateComp];
}


- (IBAction)action:(id)sender
{
    SelectPersonViewController *controller = [[SelectPersonViewController alloc] initWithNibName:NSStringFromClass([SelectPersonViewController class]) bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setToolbarHidden:NO animated:animated];
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self layoutFrame];
}

- (void)layoutFrame
{
    _titleView.frame = CGRectMake(0.0f, 0, self.view.frame.size.width, 40);
    CGRect calendarRect = CGRectMake(0.0f, 40.0, self.view.frame.size.width, self.view.frame.size.height - (40 + 44 + 50));
    _prevCalendarView.frame = calendarRect;
    _nextCalendarView.frame = calendarRect;
    _currCalendarView.frame = calendarRect;
//    self.bannerView.frame = CGRectMake(0, self.view.bounds.size.height - MOPUB_BANNER_SIZE.height - 44,
//                                       MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
    self.bannerView.frame = CGRectMake(0, self.view.bounds.size.height - MOPUB_BANNER_SIZE.height - 44,
                                       self.view.frame.size.width, MOPUB_BANNER_SIZE.height);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom Methods

- (void)setupLayout
{
    self.navigationItem.title = NSLocalizedString(@"test", @"test");
//    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NEOTitleView class]) owner:self options:nil];
//    self.titleView = [views lastObject];
    self.titleView = [[NEOTitleView alloc] init];
    self.currCalendarView = [[NEOCalendarView alloc] initWithFrame:CGRectZero];
    self.nextCalendarView = [[NEOCalendarView alloc] initWithFrame:CGRectZero];
    self.prevCalendarView = [[NEOCalendarView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:_titleView];
    [self.view addSubview:_prevCalendarView];
    [self.view addSubview:_nextCalendarView];
    [self.view addSubview:_currCalendarView];
    
    UISwipeGestureRecognizer *swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeL)];
    swipeL.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeL];
    
    UISwipeGestureRecognizer *swipeR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeR)];
    swipeR.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeR];
}

- (void)showCalendar
{
    NEOLog("test");
    
//    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
//    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *dateComp = [cal components:unitFlags fromDate:[NSDate date]];
    
    NSDateComponents *dateComp = [NEODateUtil dateComponentFromDate:[NSDate date]];
    [self setCalendarDate:dateComp];
    
//    
//    NSDate *currentDate = [NSDate date];
//    NSDateComponents *dateComp = [NSDateComponents ]
//    _titleView.MonthLabel.text = currentDate;
}

- (void)setCalendarDate:(NSDateComponents *)dateComp
{
    _prevCalendarView.hidden = YES;
    _nextCalendarView.hidden = YES;
    
    _currCalendarView.biorhythmType = _biorhythmType;
    _prevCalendarView.biorhythmType = _biorhythmType;
    _nextCalendarView.biorhythmType = _biorhythmType;
    
    _currentDateComp = dateComp;
    
    _titleView.MonthLabel.text = [NSString stringWithFormat:@"%d", [dateComp month]];
    _titleView.yearLabel.text = [NSString stringWithFormat:@"%d", [dateComp year]];
    
    [_currCalendarView setDateComponent:dateComp];
    
    __weak NEOCalloutView *popOver = _popOver;
    __weak NEOCalendarViewController *_self = self;
    
    [_currCalendarView setSelectDelegate:^(UIView *view, NSString *message) {
        if ([popOver isShowing]) {
            [popOver hide:YES];
            return;
        }
        popOver.title = message;
        
        CGRect clickRect = [view convertRect:view.bounds toView:_self.view];
        
        [popOver showPopover:CGPointMake(clickRect.origin.x + clickRect.size.width / 2, clickRect.origin.y + clickRect.size.height / 2)
                       inView:_self.view
                     animated:YES];
    }];
    
    
    NSDateComponents *prevMonthDateComp = [NEODateUtil componentsByAddingMonth:-1 toComp:dateComp];
    NSDateComponents *nextMonthDateComp = [NEODateUtil componentsByAddingMonth:1 toComp:dateComp];
    
    [_prevCalendarView setDateComponent:prevMonthDateComp];
    [_nextCalendarView setDateComponent:nextMonthDateComp];
}

#pragma mark - UISwipeGesture Action
- (void)handleSwipeL
{
    NEOLog(@"handleSwipeL");
    
    NSDateComponents *newDateComp = [NEODateUtil componentsByAddingMonth:1 toComp:_currentDateComp];
    [self setCalendarDate:newDateComp];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:_currCalendarView cache:YES];
    [UIView commitAnimations];
}

- (void)handleSwipeR
{
    NEOLog(@"handleSwipeR");
    
    NSDateComponents *newDateComp = [NEODateUtil componentsByAddingMonth:-1 toComp:_currentDateComp];
    [self setCalendarDate:newDateComp];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_currCalendarView cache:YES];
    [UIView commitAnimations];
}


- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    
}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    
}

#pragma mark Click-Time Lifecycle Notifications

/// Tells the delegate that a full screen view will be presented in response to the user clicking on
/// an ad. The delegate may want to pause animations and time sensitive interactions.
- (void)adViewWillPresentScreen:(GADBannerView *)bannerView {
    
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)bannerView {
    
}

/// Tells the delegate that the full screen view has been dismissed. The delegate should restart
/// anything paused while handling adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)bannerView {
    
}

/// Tells the delegate that the user click will open another app, backgrounding the current
/// application. The standard UIApplicationDelegate methods, like applicationDidEnterBackground:,
/// are called immediately before this method is called.
- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView {
    
}

@end
