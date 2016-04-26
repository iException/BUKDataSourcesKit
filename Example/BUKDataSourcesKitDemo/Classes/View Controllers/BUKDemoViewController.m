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
#import "BUKDemoSubtitleTableViewCell.h"
#import "BUKDemoTextViewModel.h"


@implementation BUKDemoViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"BUKDataSourcesKit";

    BUKTableViewCellFactory *cellFactory = [[BUKTableViewCellFactory alloc] initWithCellClass:[BUKDemoSubtitleTableViewCell class] configurator:^(BUKDemoSubtitleTableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = row.object;
        cell.textLabel.text = viewModel.title;
        cell.detailTextLabel.text = viewModel.subtitle;
    }];

    __weak typeof(self)weakSelf = self;

    // Row 1
    BUKTableViewSelection *selection1 = [[BUKTableViewSelection alloc] initWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
        BUKDemoTableViewController *viewController = [[BUKDemoTableViewController alloc] init];
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    }];
    BUKTableViewRow *row1 = [[BUKTableViewRow alloc] initWithObject:[BUKDemoTextViewModel viewModelWithTitle:@"UITableViewDemo" subtitle:@"Subtitle"] cellFactory:cellFactory selection:selection1];

    // Row 2
    BUKTableViewSelection *selection2 = [[BUKTableViewSelection alloc] initWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
        BUKDemoCollectionViewController *viewController = [[BUKDemoCollectionViewController alloc] init];
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    }];
    BUKTableViewRow *row2 = [[BUKTableViewRow alloc] initWithObject:[BUKDemoTextViewModel viewModelWithTitle:@"UICollectionViewDemo" subtitle:@"Subtitle"] cellFactory:cellFactory selection:selection2];

    // Section 1
    BUKTableViewSection *section1 = [[BUKTableViewSection alloc] initWithRows:@[row1, row2]];

    // Setup data source
    self.dataSourceProvider.sections = @[section1];
}

@end
