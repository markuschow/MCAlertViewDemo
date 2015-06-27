//
//  ViewController.h
//  MCAlertViewDemo
//
//  Created by Markus Chow on 23/6/15.
//  Copyright (c) 2015 Markus Chow. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCAlertView.h"

@interface ViewController : UIViewController <MCAlertViewDelegate>


@property (nonatomic, weak) IBOutlet UIButton *showAlertButton;

@property (nonatomic, strong) Class alertViewClass;

- (IBAction)showAlert:(id)sender;

@end

