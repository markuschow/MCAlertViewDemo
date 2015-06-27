//
//  MCAlertView.h
//
//  Created by Markus Chow on 29/3/14.
//  Copyright (c) 2014 Markus Chow. All rights reserved.
//

#import "MCAlertView.h"

#import <QuartzCore/QuartzCore.h>

#define FONT				@"HelveticaNeue"

#define FONT_SIZE			18.0f

#define ALERT_COLOR			[UIColor colorWithRed:210/255.0f green:105/255.0f blue:30/255.0f alpha:1.0f]
#define RED_COLOR			[UIColor colorWithRed:235/255.0f green:88/255.0f blue:69/255.0f alpha:1.0f]
#define LIGHT_BLUE_COLOR	[UIColor colorWithRed:178/255.0f green:178/255.0f blue:255/255.0f alpha:1.0f]

@implementation MCAlertView {
	UIView			*backgroundView;
	
	UIView			*baseView;
	
	UILabel			*titleLabel;
	
	UILabel			*messageLabel;
	
	UIView			*alertBGView;
	UIView			*alertInnerBGView;
	
	UIImageView		*alertBGImageView;
	UIImageView		*alertInnerBGImageView;
	
	NSMutableArray  *buttonArray;
}

@synthesize alertDelegate;

@synthesize cancelButton;
@synthesize cancelButtonIndex;

#define BASE_VIEW_HEIGHT			160.0f

#define BUTTON_OFFSET				40.0f

#define LABEL_HEIGHT				40.0f

#define LABEL_WIDTH_OFFSET			60.0f

#define MSG_HEADERVIEW_PADDING		5.0f
#define MSG_HEADERVIEW_HEIGHT		300.0f

#define BUTTON_WIDTH				200.0f

int alertViewHeight = 480; // IPHONE 4 SIZE

CGSize screenSize;

#pragma mark - Get Label Height With Msg
- (CGFloat)getLabelHeightWithMsg:(NSString *)msg byFontName:(NSString *)fontName andFontSize:(CGFloat)size {
	
	UILabel *gettingSizeLabel = [[UILabel alloc] init];
	gettingSizeLabel.font = [UIFont fontWithName:fontName size:size];
	gettingSizeLabel.text = msg;
	gettingSizeLabel.numberOfLines = 0;
	gettingSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
	CGSize maximumLabelSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - LABEL_HEIGHT), 9999);
	
	CGSize expectSize = [gettingSizeLabel sizeThatFits:maximumLabelSize];
	
	return expectSize.height;
}

- (void)setupBackgroundView {
	// BG view
	backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, alertViewHeight)];
	backgroundView.backgroundColor = [UIColor grayColor];
	backgroundView.alpha = 0.4f;
}

- (void)setupBaseView:(double)baseViewHeight {
	// Base View
	baseView = [[UIView alloc] initWithFrame:CGRectMake(10, (alertViewHeight - baseViewHeight) / 2, screenSize.width - 20, baseViewHeight)];
	baseView.backgroundColor = [UIColor clearColor];
	baseView.layer.masksToBounds = YES;
	[self addSubview:baseView];
}

- (void)setupAlertBackgroundView:(double)baseViewHeight {
	// BG view
	alertBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width - 20, baseViewHeight)];
	alertBGView.backgroundColor = [ALERT_COLOR colorWithAlphaComponent:0.9f];
	[alertBGView.layer setCornerRadius:8.0f];
	[alertBGView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
	[alertBGView.layer setBorderWidth:1.0f];
	[baseView addSubview:alertBGView];
}

- (void)setupAlertInnerBackgroundView:(double)baseViewHeight {
	// Inner BG view
	alertInnerBGView = [[UIView alloc] initWithFrame:CGRectMake(10, LABEL_HEIGHT, screenSize.width - LABEL_HEIGHT, baseViewHeight - (LABEL_HEIGHT + 10))];
	alertInnerBGView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9f];
	[alertInnerBGView.layer setCornerRadius:8.0f];
	[alertInnerBGView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
	[alertInnerBGView.layer setBorderWidth:1.0f];
	[baseView addSubview:alertInnerBGView];
}

- (void)setupTitleLabel:(UIFont *)font title:(NSString *)title {
	// Title
	titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenSize.width - LABEL_HEIGHT, LABEL_HEIGHT)];
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.textAlignment = NSTextAlignmentCenter;
	titleLabel.textColor = [UIColor whiteColor];
	[titleLabel setAdjustsFontSizeToFitWidth:YES];
	titleLabel.numberOfLines = 2;
	titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
	titleLabel.minimumScaleFactor = 0.2f;
	titleLabel.font = font;
	titleLabel.text = title;
	[baseView addSubview:titleLabel];
}

- (void)setupMessageLabel:(NSString *)message font:(UIFont *)font {
	// Message
	messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, LABEL_HEIGHT, screenSize.width - LABEL_WIDTH_OFFSET, [self getLabelHeightWithMsg:message byFontName:FONT andFontSize:FONT_SIZE])];
	messageLabel.backgroundColor = [UIColor clearColor];
	messageLabel.textAlignment = NSTextAlignmentCenter;
	messageLabel.textColor = [UIColor orangeColor];
	[messageLabel setAdjustsFontSizeToFitWidth:YES];
	messageLabel.numberOfLines = messageLabel.frame.size.height / 20;
	messageLabel.minimumScaleFactor = 0.5f;
	messageLabel.font = font;
	messageLabel.text = message;
	[baseView addSubview:messageLabel];
}

- (void)setupCancelButton:(NSString *)cancelButtonTitle font:(UIFont *)font {
	// Cancel Button
	cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
	cancelButton.frame = CGRectMake(((screenSize.width - 20) - BUTTON_WIDTH)/2, (baseView.frame.size.height - 60), BUTTON_WIDTH, 30);
	[cancelButton setBackgroundColor:RED_COLOR];
	[cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
	cancelButton.titleLabel.font = font;
	[cancelButton addTarget:self action:@selector(clickedButtonIndex:) forControlEvents:UIControlEventTouchUpInside];
	cancelButton.tag = 0;
	cancelButton.showsTouchWhenHighlighted = YES;
	[baseView addSubview:cancelButton];
}

- (void)setupOtherButtons:(UIFont *)font otherButtonTitlesArray:(NSArray *)otherButtonTitlesArray {
	// Set Buttons
	for (int i = (int)[otherButtonTitlesArray count] - 1, y = 1; i >= 0; i--) {
		
		int offset = BUTTON_OFFSET * y;
		y++;
		
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn setBackgroundColor:LIGHT_BLUE_COLOR];
		[btn setTitle:[otherButtonTitlesArray objectAtIndex:i] forState:UIControlStateNormal];
		btn.titleLabel.font = font;
		[btn addTarget:self action:@selector(clickedButtonIndex:) forControlEvents:UIControlEventTouchUpInside];
		btn.frame = CGRectMake(((screenSize.width - 20) - BUTTON_WIDTH)/2, cancelButton.frame.origin.y - offset, BUTTON_WIDTH, 30);
		btn.tag = i+1;
		btn.showsTouchWhenHighlighted = YES;
		[baseView addSubview:btn];
		
	}
}

- (void)checkNilForCancelButton:(NSString *)cancelButtonTitle {
	// hide cancel button if nil
	if (cancelButtonTitle == nil) {
		cancelButton.hidden = YES;
		
		CGRect baseViewRect = baseView.frame;
		CGRect alertBGViewRect = alertBGView.frame;
		CGRect alertInnerBGViewRect = alertInnerBGView.frame;
		
		baseViewRect.size.height -= BUTTON_OFFSET;
		alertBGViewRect.size.height -= BUTTON_OFFSET;
		alertInnerBGViewRect.size.height -= BUTTON_OFFSET;
		
		baseView.frame = baseViewRect;
		alertBGView.frame = alertBGViewRect;
		alertInnerBGView.frame = alertInnerBGViewRect;
	}
}

#pragma mark - Init Method
- (void)beginInitAnimation {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationDuration:kTransitionDuration/1.5];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(firstBounceAnimationStopped)];
			self.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
			[UIView commitAnimations];
			
		});
	});
}

- (id)initWithTitle:(NSString *)title withMessage:(NSString *)message delegate:(id<MCAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
	
	screenSize = [[UIScreen mainScreen] bounds].size;
	
	alertViewHeight = screenSize.height;

	// init
	self = [super initWithFrame:CGRectMake(0, 0, screenSize.width, alertViewHeight)];
    if (self) {
        // Initialization code
		
		self.backgroundColor = [UIColor clearColor];
		
		self.alertDelegate = delegate;
		
		UIFont *font = [UIFont fontWithName:FONT size:FONT_SIZE];
		
		[self setupBackgroundView];
		
		double baseViewHeight = BASE_VIEW_HEIGHT;
		
		NSMutableArray *otherButtonTitlesArray = [NSMutableArray array];

		va_list args;
		va_start(args, otherButtonTitles);
		for (NSString *title = otherButtonTitles; title != nil; title = va_arg(args, NSString *)) {
			[otherButtonTitlesArray addObject:title];
		}
		va_end(args);
		
		if ([otherButtonTitlesArray count] > 1) {
			// more than 1 in other buttons
			baseViewHeight = baseViewHeight + (BUTTON_OFFSET * ([otherButtonTitlesArray count] - 1));
		}
		
		if (message.length > 0) {
			baseViewHeight += [self getLabelHeightWithMsg:message byFontName:FONT andFontSize:FONT_SIZE];
		}

		[self setupBaseView:baseViewHeight];
		
		[self setupAlertBackgroundView:baseViewHeight];
		
		[self setupAlertInnerBackgroundView:baseViewHeight];
		
		[self setupTitleLabel:font title:title];
		
		[self setupMessageLabel:message font:font];
		
		[self setupCancelButton:cancelButtonTitle font:font];
		
		[self setupOtherButtons:font otherButtonTitlesArray:otherButtonTitlesArray];
		
		self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
		
		[self checkNilForCancelButton:cancelButtonTitle];
		
		self.alpha = 1.0;
		
		cancelButtonIndex = cancelButton.tag;

		[self beginInitAnimation];
		
	}
	return self;
	
	
}
static CGFloat kTransitionDuration = 0.3;
- (void)firstBounceAnimationStopped {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationDuration:kTransitionDuration/2];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(secondBounceAnimationStopped)];
			self.transform = CGAffineTransformScale([self transformForOrientation], 0.9, 0.9);
			[UIView commitAnimations];
			
		});
	});
	
}

- (void)secondBounceAnimationStopped {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationDuration:kTransitionDuration/2];
			self.transform = [self transformForOrientation];
			[UIView commitAnimations];
			
		});
	});
	
}
- (void)setBGColor {
	backgroundView.backgroundColor = [UIColor grayColor];
}

- (void)showAlertInView:(UIView *)view {
	
	dispatch_async(dispatch_get_main_queue(), ^{

		[self closePreviousMCAlertView];
		
		[view.superview addSubview:backgroundView];
		[view.superview addSubview:self];
		
		// Accessibility
		self.accessibilityLabel = titleLabel.text;

		// Accessibility
		UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self);
		
	});
	
}
- (CGAffineTransform)transformForOrientation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}

#pragma mark - Close Custom Alert View
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
	
	[self dismissAlertViewAnimated];
	
}

- (void)dismissAlertViewAnimated {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[UIView animateWithDuration:0.2f animations:^{
				self.transform = CGAffineTransformScale([self transformForOrientation], 0.1, 0.1);
				self.alpha = 0.0;
			} completion:^(BOOL finished) {
				[self removeAlertView];
			}];
			
		});
	});
}

- (void)removeAlertView {
	
	// remove backgroup view
	[backgroundView removeFromSuperview];

	// remove alert view
	[self removeFromSuperview];
	
	
}

- (IBAction)clickedButtonIndex:(id)sender {
	
	if ([self.alertDelegate respondsToSelector:@selector(buttonSelected:clickedButtonAtIndex:)]) {
		[self.alertDelegate buttonSelected:self clickedButtonAtIndex:cancelButton.hidden?([sender tag]-1):[sender tag]];
	}
	
	// dismiss filter view
	[self dismissWithClickedButtonIndex:[sender tag] animated:YES];
	
}

// Close Previous Alert View
- (void)closePreviousMCAlertView {
	
	// close previous MCAlertview
	for (UIWindow* window in [UIApplication sharedApplication].windows) {
		for (NSObject *thisObj in window.subviews) {
			if ([thisObj isKindOfClass:[MCAlertView class]]) {
				[(MCAlertView *)thisObj dismissWithClickedButtonIndex:[(MCAlertView *)thisObj cancelButtonIndex] animated:YES];
			}
		}
	}
	
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
