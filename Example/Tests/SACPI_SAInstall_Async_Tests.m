//
//  SACPI_Install_Async_Tests.m
//  SACPI
//
//  Created by Gabriel Coman on 09/02/2017.
//  Copyright © 2017 devgabrielcoman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SAInstall.h"
#import "SANetwork.h"
#import "SAUtils.h"

@interface SACPI_SAInstall_Async_Tests : XCTestCase

@end

@implementation SACPI_SAInstall_Async_Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void) testSAInstall_sendInstallEventToServer {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    __block SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    __block SASession *session = [[SASession alloc] init];
    [session setConfigurationStaging];
    
    // first generate a new click on the ad server coming from this app,
    // "tv.superawesome.sacpidemo" as if to install the
    // "tv.superawesome.demoapp", which is the target that was setup
    // in the dashboard
    NSString *clickUrl = [NSString stringWithFormat:@"%@/click", [session getBaseUrl]];
    NSDictionary *clickQuery = @{
                                 @"placement" : @(588),
                                 @"bundle" : [session getBundleId],
                                 @"creative" : @(5782),
                                 @"line_item": @(1068),
                                 @"ct": @([session getConnectivityType]),
                                 @"sdkVersion": @"0.0.0",
                                 @"rnd" : @([session getCachebuster])
                                 };
    
    NSDictionary *header = @{
                             @"User-Agent": [SAUtils getUserAgent]
                             };
    
    SANetwork *network = [[SANetwork alloc] init];
    [network sendGET:clickUrl withQuery:clickQuery andHeader:header withResponse:^(NSInteger status, NSString *payload, BOOL success) {
       
        // now send the install event
        NSString *targetPackage = @"tv.superawesome.SuperAwesome";
        [install sendInstallEventToServer:targetPackage
                              withSession:session andResponse:^(BOOL success) {
                                  XCTAssertTrue(success);
                                  [expectation fulfill];
                              }];
        
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
}

@end
