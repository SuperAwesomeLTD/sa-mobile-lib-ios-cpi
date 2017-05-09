//
//  SACPI_SACPI_Async_Tests.m
//  SACPI
//
//  Created by Gabriel Coman on 09/02/2017.
//  Copyright © 2017 devgabrielcoman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SACPI.h"
#import "SAOnce.h"
#import "SANetwork.h"
#import "SAUtils.h"

@interface SACPI_SACPI_Async_Tests : XCTestCase

@end

@implementation SACPI_SACPI_Async_Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void) testSACPI_sendInstallEvent_1 {

    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    // create a new session (staging) object
    __block SASession *session = [[SASession alloc] init];
    [session setConfigurationStaging];
    
    // always reset the CPI
    __block SAOnce *once = [[SAOnce alloc] init];
    [once resetCPISent];
    
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
        
        // call the whole CPI process:
        // - as if I was running this from the app that's just been
        //   installed "tv.superawesome.demoapp",
        // - see if the main CPI method executes correctly against a new click
        [[SACPI getInstance] handleInstall:session
                                withTarget:@"tv.superawesome.SuperAwesome"
                               andResponse:^(BOOL success) {
        
                                      XCTAssertTrue(success);
                                      XCTAssertTrue([once isCPISent]);
                                      
                                      [expectation fulfill];
                                  }];
        
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void) testSACPI_sendInstallEvent_2 {
    
    __block XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    
    // create a new session (staging) object
    __block SASession *session = [[SASession alloc] init];
    [session setConfigurationStaging];
    
    // always reset the CPI
    __block SAOnce *once = [[SAOnce alloc] init];
    [once resetCPISent];
    
    // first generate a new click on the ad server coming from this app,
    // "tv.superawesome.sacpidemo" as if to install the
    // "tv.superawesome.demoapp", which is the target that was setup
    // in the dashboard
    NSString *clickUrl = [NSString stringWithFormat:@"%@/click", [session getBaseUrl]];
    NSDictionary *clickQuery = @{
                                 @"placement" : @(588),
                                 @"bundle" : [session getBundleId],
                                 @"creative" : @(5778),
                                 @"line_item": @(1063),
                                 @"ct": @([session getConnectivityType]),
                                 @"sdkVersion": @"0.0.0",
                                 @"rnd" : @([session getCachebuster])
                                 };
    NSDictionary *header = @{
                             @"User-Agent": [SAUtils getUserAgent]
                             };
    
    SANetwork *network = [[SANetwork alloc] init];
    [network sendGET:clickUrl withQuery:clickQuery andHeader:header withResponse:^(NSInteger status, NSString *payload, BOOL success) {
        
        // call the whole CPI process:
        // - as if I was running this from the app that's just been
        //   installed "tv.superawesome.demoapp",
        // - see if the main CPI method executes correctly against a new click
        [[SACPI getInstance] handleInstall:session
                                withTarget:@"some.other.app"
                               andResponse:^(BOOL success) {
                                      
                                      XCTAssertFalse(success);
                                      XCTAssertTrue([once isCPISent]);
                                      
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
