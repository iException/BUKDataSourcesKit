//
//  BUKCollectionViewSection.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import Foundation;

@class BUKCollectionViewItem;
@protocol BUKCollectionViewCellFactoryProtocol;
@protocol BUKCollectionViewSupplementaryViewFactoryProtocol;
@protocol BUKCollectionViewSelectionProtocol;


@interface BUKCollectionViewSection : NSObject

@property (nonatomic) NSArray<__kindof BUKCollectionViewItem *> *items;
@property (nonatomic) id object;
@property (nonatomic) id<BUKCollectionViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory;
@property (nonatomic) id<BUKCollectionViewSelectionProtocol> itemSelection;

+ (instancetype)section;
+ (instancetype)sectionWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items;
+ (instancetype)sectionWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory;

- (instancetype)initWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items;
- (instancetype)initWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory NS_DESIGNATED_INITIALIZER;

- (__kindof BUKCollectionViewItem *)itemAtIndex:(NSInteger)index;

@end
