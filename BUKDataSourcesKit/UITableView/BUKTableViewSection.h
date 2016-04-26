//
//  BUKTableViewSection.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import Foundation;


@class BUKTableViewRow;
@protocol BUKTableViewCellFactoryProtocol;
@protocol BUKTableViewHeaderFooterViewFactoryProtocol;

@interface BUKTableViewSection : NSObject

@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> headerViewFactory;
@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> footerViewFactory;
@property (nonatomic) id<BUKTableViewCellFactoryProtocol> cellFactory;
@property (nonatomic, copy) NSArray<BUKTableViewRow *> *rows;
@property (nonatomic) id object;

- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows;
- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows
           headerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory
           footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory;
- (instancetype)initWithRows:(NSArray<BUKTableViewRow *> *)rows
           headerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory
           footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory
                 cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory NS_DESIGNATED_INITIALIZER;

- (BUKTableViewRow *)rowAtIndex:(NSInteger)index;

@end
