//
//  BUKCollectionViewCellFactory.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/22/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewCellFactoryProtocol.h"


typedef void (^BUKCollectionViewCellConfigurationHandler)(__kindof UICollectionViewCell *cell, BUKCollectionViewItem *item, UICollectionView *collectionView, NSIndexPath *indexPath);

@interface BUKCollectionViewCellFactory : NSObject <BUKCollectionViewCellFactoryProtocol>

@property (nonatomic, readonly) Class cellClass;
@property (nonatomic, copy, readonly) NSString *reuseIdentifier;
@property (nonatomic, copy, readonly) BUKCollectionViewCellConfigurationHandler cellConfigurator;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCellClass:(Class)cellClass configurator:(BUKCollectionViewCellConfigurationHandler)configurator NS_DESIGNATED_INITIALIZER;

@end
