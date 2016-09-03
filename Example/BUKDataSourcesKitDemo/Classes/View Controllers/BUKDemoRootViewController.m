//
//  BUKViewController.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 12/15/2015.
//  Copyright (c) 2015 Yiming Tang. All rights reserved.
//

#import "BUKDemoRootViewController.h"
#import "BUKDemoSimpleTableViewController.h"
#import "BUKDemoCollectionViewController.h"
#import "BUKDemoSubtitleTableViewCell.h"
#import "BUKDemoTextViewModel.h"


@implementation BUKDemoRootViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"BUKDataSourcesKit";

    self.tableView.rowHeight = 60.0f;
    self.tableView.sectionHeaderHeight = 36.0f;

    // Setup
    BUKTableViewCellFactory *cellFactory = [BUKTableViewCellFactory factoryWithCellClass:[BUKDemoSubtitleTableViewCell class] configurator:^(BUKDemoSubtitleTableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = row.object;
        cell.textLabel.text = viewModel.title;
        cell.detailTextLabel.text = viewModel.subtitle;
    }];

    self.dataSourceProvider.cellFactory = cellFactory;
    self.dataSourceProvider.sections = @[
        // Section 1
        [BUKTableViewSection sectionWithHeaderViewFactory:[BUKTableViewHeaderFooterViewFactory factoryWithTitle:@"UITableView"]
                                                     rows:@[
            [BUKTableViewRow rowWithObject:[BUKDemoTextViewModel viewModelWithTitle:@"Basic Usage" subtitle:@"One cell style and one kind of model"] cellFactory:nil
                                 selection:[BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
                                               // Show basic usage sample
                                               [self.navigationController pushViewController:[[BUKDemoSimpleTableViewController alloc] init] animated:YES];
                                           } deselectionHandler:nil]],
            [BUKTableViewRow rowWithObject:[BUKDemoTextViewModel viewModelWithTitle:@"Advanced Usage" subtitle:@"Many kinds of cells and models"] cellFactory:nil
                                 selection:[BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
                                               NSLog(@"Show advanced usage");
                                           } deselectionHandler:nil]],
            [BUKTableViewRow rowWithObject:[BUKDemoTextViewModel viewModelWithTitle:@"Selection" subtitle:@"Configure row selection"] cellFactory:nil
                                 selection:[BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
                                               NSLog(@"Show selection demo");
                                           } deselectionHandler:nil]],
            [BUKTableViewRow rowWithObject:[BUKDemoTextViewModel viewModelWithTitle:@"Height" subtitle:@"Configure row height"] cellFactory:nil
                                 selection:[BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
                                               NSLog(@"Show row height demo");
                                           } deselectionHandler:nil]]
            ]
                                        footerViewFactory:nil],
        // Section 2
        [BUKTableViewSection sectionWithHeaderViewFactory:[BUKTableViewHeaderFooterViewFactory factoryWithTitle:@"UICollectionView"]
                                                     rows:@[
            [BUKTableViewRow rowWithObject:[BUKDemoTextViewModel viewModelWithTitle:@"Basic Usage" subtitle:@"One cell style and one kind of model"] cellFactory:nil
                                 selection:[BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
                                               NSLog(@"Show basic usage");
                                               BUKDemoCollectionViewController *controller = [[BUKDemoCollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
                                               [self.navigationController pushViewController:controller animated:YES];
                                           } deselectionHandler:nil]],
            [BUKTableViewRow rowWithObject:[BUKDemoTextViewModel viewModelWithTitle:@"Advanced Usage" subtitle:@"Many kinds of cells and models"] cellFactory:nil
                                 selection:[BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
                                                NSLog(@"Show advanced usage");
                                           } deselectionHandler:nil]],
            [BUKTableViewRow rowWithObject:[BUKDemoTextViewModel viewModelWithTitle:@"Selection" subtitle:@"Configure item selection"] cellFactory:nil
                                 selection:[BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
                                               NSLog(@"Show selection demo");
                                           } deselectionHandler:nil]],
            [BUKTableViewRow rowWithObject:[BUKDemoTextViewModel viewModelWithTitle:@"Flow Layout" subtitle:@"Configure flow layout"] cellFactory:nil
                                 selection:[BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
                                               NSLog(@"Show flow layout demo");
                                           } deselectionHandler:nil]],
            ]
                                        footerViewFactory:nil],
    ];
}

@end
