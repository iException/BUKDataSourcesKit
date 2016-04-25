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


@interface BUKCollectionViewSection : NSObject

@property (nonatomic) NSArray<__kindof BUKCollectionViewItem *> *items;
@property (nonatomic) id object;
@property (nonatomic) id<BUKCollectionViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items;
- (instancetype)initWithItems:(NSArray<__kindof BUKCollectionViewItem *> *)items supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory NS_DESIGNATED_INITIALIZER;

- (__kindof BUKCollectionViewItem *)itemAtIndex:(NSInteger)index;

@end
