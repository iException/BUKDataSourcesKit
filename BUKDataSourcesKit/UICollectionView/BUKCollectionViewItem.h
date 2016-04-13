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

@interface BUKCollectionViewItem : NSObject

typedef void (^BUKCollectionViewItemSelectionHandler)(BUKCollectionViewItem *item);

@property (nonatomic, readonly) id<BUKCollectionViewCellFactoryProtocol> cellFactory;
@property (nonatomic, readonly) id<BUKCollectionViewSupplementaryViewFactoryProtocol> supplementaryViewFactory;
@property (nonatomic, copy, readonly) BUKCollectionViewItemSelectionHandler selection;
@property (nonatomic, readonly) id object;

//- (instancetype)initWithObject:(id)

@end
