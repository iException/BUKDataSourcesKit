//
//  BUKTableViewDataSourceProvider.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKTableViewSection;

@interface BUKTableViewDataSourceProvider : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray<BUKTableViewSection *> *sections;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic) BOOL automaticallyDeselectRows;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<BUKTableViewSection *> *)sections NS_DESIGNATED_INITIALIZER;

@end
