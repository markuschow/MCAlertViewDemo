# MCAlertViewDemo

MCAlertViewDemo is a customizable alert view for iOS, the usage is similar to the iOS default UIAlertView.

# Usage
	
	@interface ViewController : UIViewController <MCAlertViewDelegate>

	// MCAlertView Delegate Method
	- (void)buttonSelected:(UIView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
		NSLog(@"MCAlertView buttonIndex : %ld", (long)buttonIndex);	
	}

	// Usage of MCAlertView
	MCAlertView *alert = [[_alertViewClass alloc] initWithTitle:@"Alert Title"
													withMessage:@"Alert message..."
													   delegate:self
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:@"Button 1", @"Button 2", nil];
	
	[alert showAlertInView:self.view];
	
