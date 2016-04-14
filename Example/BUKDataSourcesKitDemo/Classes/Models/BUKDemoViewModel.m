//
//  BUKDemoViewModel.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/14/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

#import "BUKDemoViewModel.h"

@implementation BUKDemoViewModel

#pragma mark - Class Methods

+ (instancetype)viewModelWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    return [[self alloc] initWithTitle:title subtitle:subtitle];
}


#pragma mark - Initializer

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    if ((self = [super init])) {
        _title = [title copy];
        _subtitle = [subtitle copy];
    }
    return self;
}

@end
