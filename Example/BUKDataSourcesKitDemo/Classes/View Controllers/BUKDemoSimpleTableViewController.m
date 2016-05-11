//
//  BUKDemoTableViewController.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/13/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

#import "BUKDemoSimpleTableViewController.h"
#import "BUKDemoSubtitleTableViewCell.h"
#import "BUKDemoTableViewHeaderFooterView.h"
#import "BUKDemoTextViewModel.h"


@implementation BUKDemoSimpleTableViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Basic Usage";

    self.dataSourceProvider.headerViewFactory = [BUKTableViewHeaderFooterViewFactory factoryWithTitle:@"Section Header"];
    self.dataSourceProvider.cellFactory = [BUKTableViewCellFactory factoryWithCellClass:[BUKDemoSubtitleTableViewCell class] configurator:^(__kindof UITableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = row.object;
        cell.textLabel.text = viewModel.title;
        cell.detailTextLabel.text = viewModel.subtitle;
    }];
    self.dataSourceProvider.rowSelection = [BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
        NSLog(@"Selected row: %@ indexPath: %@", row, indexPath);
    } deselectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
        NSLog(@"Deselectd row: %@ indexPath: %@", row, indexPath);
    }];

    // Create 10 sections each of which contains 20 rows
    NSMutableArray<BUKTableViewSection *> *mutableSections = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; ++i) {
        NSMutableArray<BUKTableViewRow *> *mutableRows = [NSMutableArray array];
        for (NSInteger j = 0; j < 20; ++j) {
            BUKTableViewRow *row = [BUKTableViewRow rowWithObject:[BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"Row %ld - %ld", (long)i, (long)j] subtitle:@"This is a subtitle"]];
            [mutableRows addObject:row];
        }
        BUKTableViewSection *section = [BUKTableViewSection sectionWithRows:mutableRows];
        [mutableSections addObject:section];
    }

    self.dataSourceProvider.sections = mutableSections;
}

@end
