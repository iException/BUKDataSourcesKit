//
//  BUKDemoImageViewModel.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/14/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

#import "BUKDemoImageViewModel.h"

@implementation BUKDemoImageViewModel

#pragma mark - Accessors

- (UIImage *)image {
    return [UIImage imageNamed:self.imageName];
}


#pragma mark - Class Methods

+ (instancetype)viewModelWithTitle:(NSString *)title imageName:(NSString *)imageName {
    return [[self alloc] initWithTitle:title imageName:imageName];
}


#pragma mark - Initializer

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName {
    if ((self = [super init])) {
        _title = [title copy];
        _imageName = [imageName copy];
    }

    return self;
}

@end
