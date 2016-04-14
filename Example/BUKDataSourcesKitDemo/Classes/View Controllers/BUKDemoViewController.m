//
//  BUKViewController.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 12/15/2015.
//  Copyright (c) 2015 Yiming Tang. All rights reserved.
//

#import "BUKDemoViewController.h"
#import "BUKDemoTableViewController.h"
#import "BUKDemoCollectionViewController.h"
#import "BUKDemoTableViewCell.h"
#import "BUKDemoViewModel.h"


@implementation BUKDemoViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"BUKDataSourcesKit";

    BUKTableViewCellFactory *cellFactory = [[BUKTableViewCellFactory alloc] initWithCellClass:[BUKDemoTableViewCell class] configurator:^(BUKDemoTableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
        BUKDemoViewModel *viewModel = row.object;
        cell.textLabel.text = viewModel.title;
        cell.detailTextLabel.text = viewModel.subtitle;
    }];

    BUKTableViewRow *row1 = [[BUKTableViewRow alloc] initWithObject:[BUKDemoViewModel viewModelWithTitle:@"Title 1" subtitle:@"Subtitle 1"] cellFactory:cellFactory];
    BUKTableViewRow *row2 = [[BUKTableViewRow alloc] initWithObject:[BUKDemoViewModel viewModelWithTitle:@"Title 2" subtitle:@"Subtitle 2"] cellFactory:cellFactory];
    BUKTableViewSection *section1 = [[BUKTableViewSection alloc] initWithRows:@[row1, row2]];

    self.dataSourceProvider.sections = @[
        section1
    ];
}

@end
