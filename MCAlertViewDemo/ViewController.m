//
//  ViewController.m
//  MCAlertViewDemo
//
//  Created by Markus Chow on 23/6/15.
//  Copyright (c) 2015 Markus Chow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - MCAlertView Delegate Method
- (void)buttonSelected:(UIView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"MCAlertView buttonIndex : %ld", (long)buttonIndex);
	
}

- (IBAction)showAlert:(id)sender {
	
	// Usage of MCAlertView
	MCAlertView *alert = [[_alertViewClass alloc] initWithTitle:@"Alert Title"
													withMessage:@"Alert message..."
													   delegate:self
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:@"Button 1", @"Button 2", nil];
	
	[alert showAlertInView:self.view];
	
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	_alertViewClass = [MCAlertView class];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
