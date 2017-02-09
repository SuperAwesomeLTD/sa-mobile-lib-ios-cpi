//
//  SACPI_Once_Tests.m
//  SACPI
//
//  Created by Gabriel Coman on 09/02/2017.
//  Copyright © 2017 devgabrielcoman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SAOnce.h"

@interface SACPI_SAOnce_Tests : XCTestCase

@end

@implementation SACPI_SAOnce_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testSAOnce_Create1 {
    
    SAOnce *once = [[SAOnce alloc] init];
    XCTAssertNotNil(once);
    
}

- (void) testSAOnce_Reset1 {
    
    SAOnce *once = [[SAOnce alloc] init];
    XCTAssertNotNil(once);
    
    BOOL success = [once resetCPISent];
    XCTAssertTrue(success);
    
    BOOL isSent = [once isCPISent];
    XCTAssertFalse(isSent);
    
}

- (void) testSAOnce_Set1 {
    
    SAOnce *once = [[SAOnce alloc] init];
    XCTAssertNotNil(once);
    
    BOOL success = [once setCPISent];
    XCTAssertTrue(success);
    
    BOOL isSent = [once isCPISent];
    XCTAssertTrue(isSent);
    
}

- (void) testSAOnce_Successive1 {
    
    SAOnce *once = [[SAOnce alloc] init];
    XCTAssertNotNil(once);
    
    BOOL success = [once resetCPISent];
    XCTAssertTrue(success);
    
    BOOL isSent = [once isCPISent];
    XCTAssertFalse(isSent);
    
    success = [once setCPISent];
    XCTAssertTrue(success);
    
    isSent = [once isCPISent];
    XCTAssertTrue(isSent);
    
    success = [once resetCPISent];
    XCTAssertTrue(success);
    
    isSent = [once isCPISent];
    XCTAssertFalse(isSent);

}


@end
