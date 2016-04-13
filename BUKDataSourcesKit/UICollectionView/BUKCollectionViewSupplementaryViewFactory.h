//
//  BUKCollectionViewSupplementaryViewFactory.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/22/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;

@class BUKCollectionViewItem;

@protocol BUKCollectionViewSupplementaryViewFactoryProtocol <NSObject>

@required
- (Class)supplementaryViewClassForItem:(BUKCollectionViewItem *)item kind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
- (NSString *)reuseIdentifierForItem:(BUKCollectionViewItem *)item kind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
- (void)configureSupplementaryView:(UICollectionReusableView *)view item:(BUKCollectionViewItem *)item kind:(NSString *)kind inCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end


typedef void (^BUKCollectionSupplementaryViewConfigurationHandler)(UICollectionReusableView *view, BUKCollectionViewItem *item, NSString *kind, UICollectionView *collectionView, NSIndexPath *indexPath);

@interface BUKCollectionViewSupplementaryViewFactory : NSObject <BUKCollectionViewSupplementaryViewFactoryProtocol>

@property (nonatomic, readonly) Class supplementaryViewClass;
@property (nonatomic, copy, readonly) NSString *reuseIdentifier;
@property (nonatomic, copy, readonly) NSString *supplementaryViewKind;
@property (nonatomic, copy, readonly) BUKCollectionSupplementaryViewConfigurationHandler viewConfigurator;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSupplementaryViewClass:(Class)supplementaryViewClass kind:(NSString *)kind configurator:(BUKCollectionSupplementaryViewConfigurationHandler)configurator NS_DESIGNATED_INITIALIZER;

@end
