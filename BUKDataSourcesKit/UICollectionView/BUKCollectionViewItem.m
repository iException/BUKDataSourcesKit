//
//  BUKCollectionViewItem.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewItem.h"


@implementation BUKCollectionViewItem

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
