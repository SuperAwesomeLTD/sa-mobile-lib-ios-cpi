//
//  SAViewController.m
//  SACPI
//
//  Created by devgabrielcoman on 02/09/2017.
//  Copyright (c) 2017 devgabrielcoman. All rights reserved.
//

#import "SAViewController.h"
#import "SANetwork.h"

@interface SAViewController ()
@end

@implementation SAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    SANetwork *network = [[SANetwork alloc] init];
    [network sendGET:@"https://ads.staging.superawesome.tv/v2/click?bundle=org.cocoapods.demo.SACPI-Example&rnd=1426293&placement=618&sdkVersion=ios_5.4.2&creative=5885&line_item=1141&ct=2"
           withQuery:@{}
           andHeader:@{}
        withResponse:^(NSInteger status, NSString *payload, BOOL success) {
            
        }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
