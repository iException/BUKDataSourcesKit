//
//  BUKCollectionViewItem.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import Foundation;


@protocol BUKCollectionViewCellFactoryProtocol;
@protocol BUKCollectionViewSupplementaryViewFactoryProtocol;
@protocol BUKCollectionViewSelectionProtocol;

@class BUKCollectionViewItem;

@protocol BUKCollectionViewItemDelegate <NSObject>

@optional
- (void)itemNeedReload:(BUKCollectionViewItem *)item;

@end

@interface BUKCollectionViewItem : NSObject

@property (nonatomic) id<BUKCollectionViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory;
@property (nonatomic) id<BUKCollectionViewSelectionProtocol> selection;
@property (nonatomic, weak) id<BUKCollectionViewItemDelegate> delegate;
@property (nonatomic) id object;

+ (instancetype)item;
+ (instancetype)itemWithObject:(id)object;
+ (instancetype)itemWithObject:(id)object cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory selection:(id<BUKCollectionViewSelectionProtocol>)selection;

- (instancetype)initWithObject:(id)object;
- (instancetype)initWithObject:(id)object cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory selection:(id<BUKCollectionViewSelectionProtocol>)selection NS_DESIGNATED_INITIALIZER;
- (void)reloadItem;

@end
