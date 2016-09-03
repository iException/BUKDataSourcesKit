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
@protocol BUKCollectionViewDisplayProtocol;

@interface BUKCollectionViewItem : NSObject

@property (nonatomic) id<BUKCollectionViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory;
@property (nonatomic) id<BUKCollectionViewSelectionProtocol> selection;
@property (nonatomic) id<BUKCollectionViewDisplayProtocol> display;
@property (nonatomic) id object;

+ (instancetype)item;
+ (instancetype)itemWithObject:(id)object;
+ (instancetype)itemWithObject:(id)object cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory selection:(id<BUKCollectionViewSelectionProtocol>)selection;

- (instancetype)initWithObject:(id)object;
- (instancetype)initWithObject:(id)object cellFactory:(id<BUKCollectionViewCellFactoryProtocol>)cellFactory supplementaryViewFactory:(id<BUKCollectionViewSupplementaryViewFactoryProtocol>)supplementaryViewFactory selection:(id<BUKCollectionViewSelectionProtocol>)selection NS_DESIGNATED_INITIALIZER;

@end
