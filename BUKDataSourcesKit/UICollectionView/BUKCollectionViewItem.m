//
//  BUKCollectionViewItem.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewItem.h"


@implementation BUKCollectionViewItem

#pragma mark - Class Methods

+ (instancetype)item {
    return [[self alloc] init];
}


+ (instancetype)itemWithObject:(id)object {
    return [[self alloc] initWithObject:object];
}


+ (instancetype)itemWithObject:(id)object cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory selection:(id<BUKCollectionViewSelectionProtocol>)selection {
    return [[self alloc] initWithObject:object cellFactory:cellFactory supplementaryViewFactory:supplementaryViewFactory selection:selection];
}


#pragma mark - Initializer

- (instancetype)initWithObject:(id)object cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory selection:(id<BUKCollectionViewSelectionProtocol>)selection {
    if ((self = [super init])) {
        _object = object;
        _cellFactory = cellFactory;
        _supplementaryViewFactory = supplementaryViewFactory;
        _selection = selection;
    }
    return self;
}


- (instancetype)initWithObject:(id)object {
    return [self initWithObject:object cellFactory:nil supplementaryViewFactory:nil selection:nil];
}


- (instancetype)init {
    return [self initWithObject:nil];
}

@end
