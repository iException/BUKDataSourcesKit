//
//  BUKTableViewHeaderFooterViewFactoryProtocol.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/15/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKTableViewSection;

@protocol BUKTableViewHeaderFooterViewFactoryProtocol <NSObject>

@required
- (NSString *)titleForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index;
- (NSString *)reuseIdentifierForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index;
- (Class)headerFooterViewClassForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index;
- (void)configureView:(__kindof UITableViewHeaderFooterView *)view withSection:(BUKTableViewSection *)section inTableView:(UITableView *)tableView atIndex:(NSInteger)index;

@end
