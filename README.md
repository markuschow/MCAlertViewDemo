# MCAlertViewDemo

MCAlertViewDemo is a customizable alert view for iOS, the usage is similar to the iOS default UIAlertView.

# Usage
	// Usage of MCAlertView
	MCAlertView *alert = [[_alertViewClass alloc] initWithTitle:@"Alert Title"
													withMessage:@"Alert message..."
													   delegate:self
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:@"Button 1", @"Button 2", nil];
	
	[alert showAlertInView:self.view];
	
