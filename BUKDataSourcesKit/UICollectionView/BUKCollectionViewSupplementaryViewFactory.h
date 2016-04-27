//
//  BUKCollectionViewSupplementaryViewFactory.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/22/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKCollectionViewSupplementaryViewFactoryProtocol.h"


typedef void (^BUKCollectionSupplementaryViewConfigurationHandler)(__kindof UICollectionReusableView *view, BUKCollectionViewItem *item, NSString *kind, UICollectionView *collectionView, NSIndexPath *indexPath);

@interface BUKCollectionViewSupplementaryViewFactory : NSObject <BUKCollectionViewSupplementaryViewFactoryProtocol>

@property (nonatomic, readonly) Class supplementaryViewClass;
@property (nonatomic, copy, readonly) NSString *reuseIdentifier;
@property (nonatomic, copy, readonly) NSString *supplementaryViewKind;
@property (nonatomic, copy, readonly) BUKCollectionSupplementaryViewConfigurationHandler viewConfigurator;

+ (instancetype)factoryWithSupplementaryViewClass:(Class)supplementaryViewClass kind:(NSString *)kind configurator:(BUKCollectionSupplementaryViewConfigurationHandler)configurator;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSupplementaryViewClass:(Class)supplementaryViewClass kind:(NSString *)kind configurator:(BUKCollectionSupplementaryViewConfigurationHandler)configurator NS_DESIGNATED_INITIALIZER;

@end
