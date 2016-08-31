//
//  BUKCollectionViewSection.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import Foundation;

@class BUKCollectionViewItem;
@protocol BUKCollectionViewItemDelegate;
@protocol BUKCollectionViewCellFactoryProtocol;
@protocol BUKCollectionViewSupplementaryViewFactoryProtocol;
@protocol BUKCollectionViewSelectionProtocol;

@class BUKCollectionViewSection;
@protocol BUKCollectionViewSectionDelegate <NSObject>

@optional
- (void)sectionNeedReload:(BUKCollectionViewSection *)section atItem:(NSInteger)item;
- (void)sectionNeedReload:(BUKCollectionViewSection *)section;

@end

@interface BUKCollectionViewSection : NSObject <BUKCollectionViewItemDelegate>

@property (nonatomic) NSArray<__kindof BUKCollectionViewItem *> *items;
@property (nonatomic) id object;
@property (nonatomic) id<BUKCollectionViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory;
@property (nonatomic) id<BUKCollectionViewSelectionProtocol> itemSelection;
@property (nonatomic, weak) id<BUKCollectionViewSectionDelegate> delegate;

+ (instancetype)section;
+ (instancetype)sectionWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items;
+ (instancetype)sectionWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory;

- (instancetype)initWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items;
- (instancetype)initWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory NS_DESIGNATED_INITIALIZER;

- (__kindof BUKCollectionViewItem *)itemAtIndex:(NSInteger)index;

// dynamics
- (void)insertItem:(BUKCollectionViewItem *)item atIndex:(NSInteger)index;
- (void)removeItemAtIndex:(NSInteger)index;
- (void)reload;

@end
