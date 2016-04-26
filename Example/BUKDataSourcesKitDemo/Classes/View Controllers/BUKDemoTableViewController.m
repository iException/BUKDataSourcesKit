//
//  BUKDemoTableViewController.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/13/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

#import "BUKDemoTableViewController.h"
#import "BUKDemoSubtitleTableViewCell.h"
#import "BUKDemoValue1TableViewCell.h"
#import "BUKDemoTableViewHeaderFooterView.h"
#import "BUKDemoTextViewModel.h"

@interface BUKDemoTableViewController ()

@end

@implementation BUKDemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Table View";

    // Section 1
    BUKTableViewHeaderFooterViewFactory *titleHeaderViewFactory = [[BUKTableViewHeaderFooterViewFactory alloc] initWithTitle:@"Section 1 Header"];
    BUKTableViewHeaderFooterViewFactory *titleFooterViewFactory = [[BUKTableViewHeaderFooterViewFactory alloc] initWithTitle:@"Section 1 Footer"];
    BUKTableViewSection *section1 = [[BUKTableViewSection alloc] initWithRows:nil headerViewFactory:titleHeaderViewFactory footerViewFactory:titleFooterViewFactory];

    BUKTableViewCellFactory *subtitleCellFactory = [[BUKTableViewCellFactory alloc] initWithCellClass:[BUKDemoSubtitleTableViewCell class] configurator:^(BUKDemoSubtitleTableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = row.object;
        cell.textLabel.text = viewModel.title;
        cell.detailTextLabel.text = viewModel.subtitle;
    }];

    BUKTableViewSelection *selection = [[BUKTableViewSelection alloc] initWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
        NSLog(@"Selected");
    }];

    NSMutableArray<BUKTableViewRow *> *mutableSubtitleRows = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"Row %ld", (long)i] subtitle:@"subtitle"];
        BUKTableViewRow *row = [[BUKTableViewRow alloc] initWithObject:viewModel cellFactory:subtitleCellFactory selection:selection];
        [mutableSubtitleRows addObject:row];
    }

    section1.rows = mutableSubtitleRows;

    // Section 2
    BUKTableViewHeaderFooterViewFactory *imageHeaderViewFactory = [[BUKTableViewHeaderFooterViewFactory alloc] initWithViewClass:[BUKDemoTableViewHeaderFooterView class] configurator:^(BUKDemoTableViewHeaderFooterView *view, BUKTableViewSection *section, UITableView *tableView, NSInteger index) {
        view.titleLabel.text = @"Section 2 Header";
    }];
    imageHeaderViewFactory.viewHeight = 52.0f;
    
    BUKTableViewHeaderFooterViewFactory *imageFooterViewFactory = [[BUKTableViewHeaderFooterViewFactory alloc] initWithTitle:@"Section 2 Footer"];
    BUKTableViewSection *section2 = [[BUKTableViewSection alloc] initWithRows:nil headerViewFactory:imageHeaderViewFactory footerViewFactory:imageFooterViewFactory];

    BUKTableViewCellFactory *value1CellFactory = [[BUKTableViewCellFactory alloc] initWithCellClass:[BUKDemoValue1TableViewCell class] configurator:^(BUKDemoValue1TableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = row.object;
        cell.textLabel.text = viewModel.title;
        cell.detailTextLabel.text = viewModel.subtitle;
    }];
    value1CellFactory.cellHeight = 40.0f;

    NSMutableArray<BUKTableViewRow *> *mutableValue1Rows = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"Row %ld", (long)i] subtitle:@"detail"];
        BUKTableViewRow *row = [[BUKTableViewRow alloc] initWithObject:viewModel cellFactory:value1CellFactory selection:selection];
        [mutableValue1Rows addObject:row];
    }

    section2.rows = mutableValue1Rows;

    // Setup data source
    self.dataSourceProvider.sections = @[section1, section2];
}

@end
