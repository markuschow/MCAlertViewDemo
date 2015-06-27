//
//  MockMCAlertViewVerifier.m
//  MCAlertViewDemo
//
//  Created by Markus Chow on 27/6/15.
//  Copyright (c) 2015 Markus Chow. All rights reserved.
//

#import "MockMCAlertViewVerifier.h"

#import "MockMCAlertView.h"

@implementation MockMCAlertViewVerifier

- (id)init {
	self = [super init];
	if (self) {
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(alertShown:)
													 name:MockMCAlertViewShowNotification
												   object:nil];
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)alertShown:(NSNotification *)notification {
	
	MockMCAlertView *alert = [notification object];
	
	self.title = alert.title;
	self.msg = alert.msg;
	self.delegate = alert.delegate;
	self.cancelBtnTitle = alert.cancelBtnTitle;
	self.otherBtnTitles = alert.otherBtnTitles;
	
}

@end
