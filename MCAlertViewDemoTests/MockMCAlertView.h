//
//  MockMCAlertView.h
//  MCAlertViewDemo
//
//  Created by Markus Chow on 27/6/15.
//  Copyright (c) 2015 Markus Chow. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCAlertView.h"

extern NSString *const MockMCAlertViewShowNotification;

@interface MockMCAlertView : UIView

@property (nonatomic, strong) id delegate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *cancelBtnTitle;
@property (nonatomic, copy) NSMutableArray *otherBtnTitles;

- (id)initWithTitle:(NSString *)title withMessage:(NSString *)message delegate:(id<MCAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)showAlertInView:(UIView *)view;

@end
