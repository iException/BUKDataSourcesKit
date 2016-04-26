//
//  BUKTableViewCellFactory.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/13/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewCellFactoryProtocol.h"


typedef void (^BUKTableViewCellConfigurationHandler)(__kindof UITableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath);

@interface BUKTableViewCellFactory : NSObject <BUKTableViewCellFactoryProtocol>

@property (nonatomic, readonly) Class cellClass;
@property (nonatomic, copy, readonly) NSString *reuseIdentifier;
@property (nonatomic, copy, readonly) BUKTableViewCellConfigurationHandler cellConfigurator;
@property (nonatomic) CGFloat cellHeight;

+ (instancetype)factoryWithCellClass:(Class)cellClass configurator:(BUKTableViewCellConfigurationHandler)configurator;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCellClass:(Class)cellClass configurator:(BUKTableViewCellConfigurationHandler)configurator NS_DESIGNATED_INITIALIZER;

@end
