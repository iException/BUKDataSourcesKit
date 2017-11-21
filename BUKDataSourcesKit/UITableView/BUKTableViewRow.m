//
//  BUKTableViewRow.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewRow.h"


@implementation BUKTableViewRow

#pragma mark - Accessors

- (void)setObject:(id)object {
    if ([self.delegate respondsToSelector:@selector(rowWillChangeContent:)]) {
        [self.delegate rowWillChangeContent:self];
    }
    _object = object;
    if ([self.delegate respondsToSelector:@selector(rowDidChangeContent:)]) {
        [self.delegate rowDidChangeContent:self];
    }
}


#pragma mark - Class Methods

+ (instancetype)row {
    return [[self alloc] init];
}


+ (instancetype)rowWithObject:(id)object {
    return [[self alloc] initWithObject:object];
}


+ (instancetype)rowWithObject:(id)object cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory selection:(id<BUKTableViewSelectionProtocol>)selection {
    return [[self alloc] initWithObject:object cellFactory:cellFactory selection:selection];
}


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
