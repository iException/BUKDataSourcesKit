//
//  BUKTableViewController.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKTableViewDataSourceProvider;

@interface BUKTableViewController : UIViewController

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, readonly) BUKTableViewDataSourceProvider *dataSourceProvider;
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithStyle:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;

@end
