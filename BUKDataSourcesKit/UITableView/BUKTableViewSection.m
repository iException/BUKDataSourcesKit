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

- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows headerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory {
    if ((self = [super init])) {
        _rows = [rows copy];
        _headerViewFactory = headerViewFactory;
        _footerViewFactory = footerViewFactory;
    }

    return self;
}


- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows {
    return [self initWithRows:rows headerViewFactory:nil footerViewFactory:nil];
}

@end
