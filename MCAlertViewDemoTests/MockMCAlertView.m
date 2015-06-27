//
//  MockMCAlertView.m
//  MCAlertViewDemo
//
//  Created by Markus Chow on 27/6/15.
//  Copyright (c) 2015 Markus Chow. All rights reserved.
//

#import "MockMCAlertView.h"

NSString *const MockMCAlertViewShowNotification = @"MockMCAlertViewShowNotification";

@implementation MockMCAlertView

- (id)initWithTitle:(NSString *)title withMessage:(NSString *)message delegate:(id<MCAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
	self = [super init];
	if (self) {
		_title = [title copy];
		_msg = [message copy];
		_delegate = delegate;
		_cancelBtnTitle = [cancelButtonTitle copy];
		
		_otherBtnTitles = [NSMutableArray array];
		
		va_list args;
		va_start(args, otherButtonTitles);
		for (NSString *title = otherButtonTitles; title != nil; title = va_arg(args, NSString *)) {
			[_otherBtnTitles addObject:title];
		}
		va_end(args);
	}
	
	return self;
}

- (void)showAlertInView:(UIView *)view {
//	[[NSNotificationCenter defaultCenter] postNotificationName:MockMCAlertViewShowNotification
//														object:self
//													  userInfo:[NSDictionary dictionaryWithObject:view forKey:@"view"]];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:MockMCAlertViewShowNotification
														object:self
													  userInfo:nil];
	
}

@end
