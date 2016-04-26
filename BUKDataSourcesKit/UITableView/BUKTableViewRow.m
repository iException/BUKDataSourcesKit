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

- (instancetype)init {
    return [self initWithObject:nil];
}


- (instancetype)initWithObject:(id)object {
    return [self initWithObject:object cellFactory:nil selection:nil];
}


- (instancetype)initWithObject:(id)object cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory selection:(id<BUKTableViewSelectionProtocol>)selection {
    if ((self = [super init])) {
        _object = object;
        _cellFactory = cellFactory;
        _selection = selection;
    }
    return self;
}

@end
