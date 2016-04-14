//
//  BUKTableViewSection.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import Foundation;


@class BUKTableViewRow;
@protocol BUKTableViewHeaderFooterViewFactoryProtocol;

@interface BUKTableViewSection : NSObject

@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> headerViewFactory;
@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> footerViewFactory;
@property (nonatomic, copy) NSArray<BUKTableViewRow *> *rows;
@property (nonatomic) id object;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows;
- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows headerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory NS_DESIGNATED_INITIALIZER;

@end
