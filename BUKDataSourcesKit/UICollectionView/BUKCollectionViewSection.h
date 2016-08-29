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
@protocol BUKCollectionViewSectionProtocol;


@interface BUKCollectionViewSection : NSObject

@property (nonatomic, readonly) NSArray<__kindof BUKCollectionViewItem *> *items;
@property (nonatomic) id object;
@property (nonatomic) id<BUKCollectionViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory;
@property (nonatomic) id<BUKCollectionViewSelectionProtocol> itemSelection;
@property (nonatomic) id<BUKCollectionViewSectionProtocol> modifyDelegate;

+ (instancetype)section;
+ (instancetype)sectionWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items;
+ (instancetype)sectionWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory;

- (instancetype)initWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items;
- (instancetype)initWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory NS_DESIGNATED_INITIALIZER;

- (__kindof BUKCollectionViewItem *)itemAtIndex:(NSInteger)index;

// dynamics
- (void)insertItem:(BUKCollectionViewItem *)item index:(NSInteger)index;
- (void)removeItemAtIndex:(NSInteger)index;
- (void)replaceItemsWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items;

@end
