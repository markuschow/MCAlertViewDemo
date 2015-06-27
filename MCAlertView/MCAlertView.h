//
//  MCAlertView.h
//
//  Created by Markus Chow on 29/3/14.
//  Copyright (c) 2014 Markus Chow. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCAlertViewDelegate <NSObject>
@required
- (void) buttonSelected:(UIView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end


@interface MCAlertView : UIView {
	
	id <MCAlertViewDelegate> __weak alertDelegate;
	
}

@property (nonatomic, weak)	id <MCAlertViewDelegate>    alertDelegate;

@property (nonatomic, strong) UIButton			*cancelButton;

@property (nonatomic)		NSInteger			cancelButtonIndex;


- (id)initWithTitle:(NSString *)title withMessage:(NSString *)message delegate:(id<MCAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)showAlertInView:(UIView *)view;

@end
