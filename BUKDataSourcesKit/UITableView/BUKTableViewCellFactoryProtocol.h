//
//  BUKTableViewCellFactoryProtocol.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/15/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKTableViewRow;

@protocol BUKTableViewCellFactoryProtocol <NSObject>

@required
- (Class)cellClassForRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;
- (NSString *)reuseIdentifierForRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;
- (void)configureCell:(__kindof UITableViewCell *)cell withRow:(BUKTableViewRow *)row inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
