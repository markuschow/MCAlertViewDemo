//
//  MockMCAlertViewVerifier.h
//  MCAlertViewDemo
//
//  Created by Markus Chow on 27/6/15.
//  Copyright (c) 2015 Markus Chow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MockMCAlertViewVerifier : NSObject

@property (nonatomic, strong) id delegate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *cancelBtnTitle;
@property (nonatomic, copy) NSMutableArray *otherBtnTitles;

- (id)init;

@end
