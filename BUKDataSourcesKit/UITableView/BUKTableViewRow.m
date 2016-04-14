//
//  BUKTableViewRow.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewRow.h"


@implementation BUKTableViewRow

#pragma mark - Initializer

- (instancetype)initWithObject:(id)object cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory {
    if ((self = [super init])) {
        _object = object;
        _cellFactory = cellFactory;
    }

    return self;
}

@end
