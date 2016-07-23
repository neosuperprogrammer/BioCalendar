//
//  MainViewController.m
//  BioCalendar
//
//  Created by Nam, SangWook on 7/23/16.
//  Copyright © 2016 Sangwook Nam. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    self.bannerView.adUnitID = @"ca-app-pub-9254009028575157/5429505022";
    

    GADRequest *request = [GADRequest request];
//    request.testDevices = @[ @"27847f3688aa95517a8a0b03bd9f2ea3" ];
    //    self.bannerView.adUnitID = @"ca-app-pub-9254009028575157/5429505022";
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
