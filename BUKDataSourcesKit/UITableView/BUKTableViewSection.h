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
@protocol BUKTableViewRowHeightInfoProtocol;
@protocol BUKTableViewSectionHeaderFooterHeightInfoProtocol;
@protocol BUKTableViewSelectionProtocol;


@interface BUKTableViewSection : NSObject

@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> headerViewFactory;
@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> footerViewFactory;
@property (nonatomic) id<BUKTableViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKTableViewRowHeightInfoProtocol> rowHeightInfo;
@property (nonatomic) id<BUKTableViewSectionHeaderFooterHeightInfoProtocol> headerHeightInfo;
@property (nonatomic) id<BUKTableViewSectionHeaderFooterHeightInfoProtocol> footerHeightInfo;
@property (nonatomic) id<BUKTableViewSelectionProtocol> rowSelection;
@property (nonatomic, copy) NSArray<BUKTableViewRow *> *rows;
@property (nonatomic) id object;

+ (instancetype)section;
+ (instancetype)sectionWithRows:(NSArray<BUKTableViewRow *> *)rows;
+ (instancetype)sectionWithRows:(NSArray<BUKTableViewRow *> *)rows
              headerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory
              footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory;
+ (instancetype)sectionWithRows:(NSArray<BUKTableViewRow *> *)rows
              headerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory
              footerViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory
                    cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory;

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
