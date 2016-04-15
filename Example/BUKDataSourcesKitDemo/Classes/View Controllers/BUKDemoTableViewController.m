//
//  BUKDemoTableViewController.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/13/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

#import "BUKDemoTableViewController.h"
#import "BUKDemoSubtitleTableViewCell.h"
#import "BUKDemoTextViewModel.h"

@interface BUKDemoTableViewController ()

@end

@implementation BUKDemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Table View";

    BUKTableViewHeaderFooterViewFactory *titleHeaderViewFactory = [[BUKTableViewHeaderFooterViewFactory alloc] initWithTitle:@"Section Header"];
    BUKTableViewHeaderFooterViewFactory *titleFooterViewFactory = [[BUKTableViewHeaderFooterViewFactory alloc] initWithTitle:@"Section Footer"];
    BUKTableViewSection *section = [[BUKTableViewSection alloc] initWithRows:nil headerViewFactory:titleHeaderViewFactory footerViewFactory:titleFooterViewFactory];

    BUKTableViewCellFactory *cellFactory = [[BUKTableViewCellFactory alloc] initWithCellClass:[BUKDemoSubtitleTableViewCell class] configurator:^(BUKDemoSubtitleTableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = row.object;
        cell.textLabel.text = viewModel.title;
        cell.detailTextLabel.text = viewModel.subtitle;
    }];

    NSMutableArray<BUKTableViewRow *> *mutableRows = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"Row %ld", (long)i] subtitle:@"subtitle"];
        BUKTableViewRow *row = [[BUKTableViewRow alloc] initWithObject:viewModel cellFactory:cellFactory selection:^(BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
            NSLog(@"Selected");
        }];
        [mutableRows addObject:row];
    }

    section.rows = mutableRows;
    self.dataSourceProvider.sections = @[section];
}

@end
