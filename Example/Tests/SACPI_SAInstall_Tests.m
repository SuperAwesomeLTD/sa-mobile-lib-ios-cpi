//
//  SACPI_Install_Tests.m
//  SACPI
//
//  Created by Gabriel Coman on 09/02/2017.
//  Copyright © 2017 devgabrielcoman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SAInstall.h"
#import "SAUtils.h"

@interface SACPI_SAInstall_Tests : XCTestCase

@end

@implementation SACPI_SAInstall_Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void) testSAInstall_Create1 {
    
    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
}

- (void) testSAInstall_getInstallUrl1_1 {
    
    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationProduction];
    
    NSString *expected = @"https://ads.superawesome.tv/v2/install";
    
    NSString *result = [install getInstallUrl:session];
    
    XCTAssertEqualObjects(expected, result);
    
}

- (void) testSAInstall_getInstallUrl1_2 {
    
    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    SASession *session = [[SASession alloc] init];
    [session setConfigurationStaging];
    
    NSString *expected = @"https://ads.staging.superawesome.tv/v2/install";
    
    NSString *result = [install getInstallUrl:session];
    
    XCTAssertEqualObjects(expected, result);
    
}

- (void) testSAInstall_getInstallUrl1_3 {
    
    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    NSString *result = [install getInstallUrl:nil];
    
    XCTAssertNil(result);
}

- (void) testSAInstall_getInstallQuery1_1 {
    
    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    NSDictionary *query = [install getInstallQuery:@"com.installed.app"];
    XCTAssertNotNil(query);
    
    NSString *expected = @"com.installed.app";
    
    XCTAssertNotNil([query objectForKey:@"bundle"]);
    XCTAssertEqualObjects(expected, [query objectForKey:@"bundle"]);
}

- (void) testSAInstall_getInstallQuery1_2 {
    
    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    NSDictionary *query = [install getInstallQuery:nil];
    XCTAssertNotNil(query);
    
    XCTAssertNil([query objectForKey:@"bundle"]);
}

- (void) testSAInstall_getInstallHeader1_1 {
    
    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    NSDictionary *header = [install getInstallHeader];
    
    NSString *expected1 = @"application/json";
    NSString *expected2 = [SAUtils getUserAgent];
    
    XCTAssertNotNil([header objectForKey:@"Content-Type"]);
    XCTAssertNotNil([header objectForKey:@"User-Agent"]);
    XCTAssertEqualObjects(expected1, [header objectForKey:@"Content-Type"]);
    XCTAssertEqualObjects(expected2, [header objectForKey:@"User-Agent"]);
    
}

- (void) testSAInstall_parseServerResponse1_1 {

    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    BOOL result = [install parseServerResponse:@"{ \"success\" : true }"];
    XCTAssertTrue(result);
}

- (void) testSAInstall_parseServerResponse1_2 {
    
    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    BOOL result = [install parseServerResponse:@"{ \"success\" : false }"];
    XCTAssertFalse(result);
}

- (void) testSAInstall_parseServerResponse1_3 {
    
    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    BOOL result = [install parseServerResponse:@"{ \"successlse }"];
    XCTAssertFalse(result);
}

- (void) testSAInstall_parseServerResponse1_4 {
    
    SAInstall *install = [[SAInstall alloc] init];
    XCTAssertNotNil(install);
    
    BOOL result = [install parseServerResponse:nil];
    XCTAssertFalse(result);
}


@end
