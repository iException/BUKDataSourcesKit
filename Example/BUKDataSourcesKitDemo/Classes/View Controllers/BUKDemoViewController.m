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

    BUKTableViewCellFactory *cellFactory = [BUKTableViewCellFactory factoryWithCellClass:[BUKDemoSubtitleTableViewCell class] configurator:^(BUKDemoSubtitleTableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = row.object;
        cell.textLabel.text = viewModel.title;
        cell.detailTextLabel.text = viewModel.subtitle;
    }];

    __weak typeof(self)weakSelf = self;

    // Row 1
    BUKTableViewSelection *selection1 = [BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
        BUKDemoTableViewController *viewController = [[BUKDemoTableViewController alloc] init];
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    } deselectionHandler:nil];
    BUKDemoTextViewModel *viewModel1 = [BUKDemoTextViewModel viewModelWithTitle:@"UITableViewDemo" subtitle:@"Subtitle"];
    BUKTableViewRow *row1 = [BUKTableViewRow rowWithObject:viewModel1 cellFactory:cellFactory selection:selection1];

    // Row 2
    BUKTableViewSelection *selection2 = [BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
        BUKDemoCollectionViewController *viewController = [[BUKDemoCollectionViewController alloc] init];
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    } deselectionHandler:nil];
    BUKDemoTextViewModel *viewModel2 = [BUKDemoTextViewModel viewModelWithTitle:@"UICollectionViewDemo" subtitle:@"Subtitle"];
    BUKTableViewRow *row2 = [BUKTableViewRow rowWithObject:viewModel2 cellFactory:cellFactory selection:selection2];

    // Section 1
    BUKTableViewSection *section1 = [BUKTableViewSection sectionWithRows:@[row1, row2]];

    // Setup data source
    self.dataSourceProvider.sections = @[section1];
}

@end
