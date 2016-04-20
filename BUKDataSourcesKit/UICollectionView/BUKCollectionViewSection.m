//
//  BUKCollectionViewSection.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewSection.h"


@implementation BUKCollectionViewSection

#pragma mark - Initializer

- (instancetype)initWithItems:(NSArray<BUKCollectionViewItem *> *)items supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory {
    if ((self = [super init])) {
        _items = [items copy];
        _supplementaryViewFactory = supplementaryViewFactory;
        _cellFactory = cellFactory;
    }

    return self;
}


- (instancetype)initWithItems:(NSArray<BUKCollectionViewItem *> *)items {
    return [self initWithItems:items supplementaryViewFactory:nil cellFactory:nil];
}


#pragma mark - Public

- (BUKCollectionViewItem *)itemAtIndex:(NSInteger)index {
    if (0 <= index && index < self.items.count) {
        return self.items[index];
    }

    NSAssert1(NO, @"Invalid index: %ld in section", (long)index);
    return nil;
}

@end
