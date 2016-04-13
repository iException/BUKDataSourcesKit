//
//  BUKTableViewCellFactory.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/13/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@class BUKTableViewRow;

@protocol BUKTableViewCellFactoryProtocol <NSObject>

@required
- (Class)cellClassForRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;
- (NSString *)reuseIdentifierForRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(__kindof UITableViewCell *)cell withRow:(BUKTableViewRow *)row inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end


typedef void (^BUKTableViewCellConfigurationHandler)(__kindof UITableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath);

@interface BUKTableViewCellFactory : NSObject <BUKTableViewCellFactoryProtocol>

@property (nonatomic, readonly) Class cellClass;
@property (nonatomic, copy, readonly) NSString *reuseIdentifier;
@property (nonatomic, copy, readonly) BUKTableViewCellConfigurationHandler cellConfigurator;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCellClass:(Class)cellClass configurator:(BUKTableViewCellConfigurationHandler)configurator;

@end
