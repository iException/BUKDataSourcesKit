//
//  BUKTableViewSelectionProtocol.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/26/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKTableViewRow;

@protocol BUKTableViewSelectionProtocol <NSObject>

@optional
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didHighlightRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didUnhighlightRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didDeselectRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;

@end
