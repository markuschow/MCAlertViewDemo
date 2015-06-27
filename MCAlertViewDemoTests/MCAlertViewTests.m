//
//  MCAlertViewTests.m
//  MCAlertViewDemo
//
//  Created by Markus Chow on 23/6/15.
//  Copyright (c) 2015 Markus Chow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <objc/runtime.h>

#import "MCAlertView.h"

#import "ViewController.h"

#import "MockMCAlertView.h"
#import "MockMCAlertViewVerifier.h"

@interface MCAlertViewTests : XCTestCase

@end

@implementation MCAlertViewTests {
	
	ViewController		*viewController;
	
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
	
	viewController = [[ViewController alloc] init];
	[viewController view];
	
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
	
	viewController = nil;

    [super tearDown];
}

- (void)testDefaultAlertViewClass {
	XCTAssertEqualObjects(viewController.alertViewClass, [MCAlertView class], @"viewController should contain MCAlertView class");
}

- (void)testShowAlert
{
	viewController.alertViewClass = [MockMCAlertView class];

	MockMCAlertViewVerifier *alertVerifier = [[MockMCAlertViewVerifier alloc] init];
	
	[viewController showAlert:nil];

	XCTAssertEqualObjects(alertVerifier.title, @"Alert Title", @"Alert Title should be \"Alert Title\"");
	XCTAssertEqualObjects(alertVerifier.msg, @"Alert message...", @"Alert message should be \"Alert message...\"");
	XCTAssertEqual(alertVerifier.delegate, viewController);

	NSArray *otherButtonTitles = alertVerifier.otherBtnTitles;
	XCTAssertEqual([otherButtonTitles count], 2, @"AlertView should have two other buttons");
	XCTAssertEqualObjects(otherButtonTitles[0], @"Button 1", @"First button title should be \"Button 1\"");
	XCTAssertEqualObjects(otherButtonTitles[1], @"Button 2", @"Second button title should be \"Button 2\"");
	XCTAssertEqualObjects(alertVerifier.cancelBtnTitle, @"Cancel", @"Cancel button title should be \"Cancel\"");
	
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
