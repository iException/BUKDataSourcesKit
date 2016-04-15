//
//  BUKTableViewSection.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewSection.h"


@implementation BUKTableViewSection

#pragma mark - Initializer

- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows headerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory {
    if ((self = [super init])) {
        _rows = [rows copy];
        _headerViewFactory = headerViewFactory;
        _footerViewFactory = footerViewFactory;
        _cellFactory = cellFactory;
    }

    return self;
}


- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows headerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory {
    return [self initWithRows:rows headerViewFactory:headerViewFactory footerViewFactory:footerViewFactory cellFactory:nil];
}


- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows {
    return [self initWithRows:rows headerViewFactory:nil footerViewFactory:nil];
}


#pragma mark - Public

- (BUKTableViewRow *)rowAtIndex:(NSInteger)index {
    if (0 <= index && index < self.rows.count) {
        return self.rows[index];
    }

    NSAssert1(NO, @"Invalid index: %ld in section", (long)index);
    return nil;
}

@end
