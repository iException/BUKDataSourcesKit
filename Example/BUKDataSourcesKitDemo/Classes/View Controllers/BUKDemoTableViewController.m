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
    BUKTableViewHeaderFooterViewFactory *titleHeaderViewFactory = [BUKTableViewHeaderFooterViewFactory factoryWithTitle:@"Section 1 Header"];
    BUKTableViewHeaderFooterViewFactory *titleFooterViewFactory = [BUKTableViewHeaderFooterViewFactory factoryWithTitle:@"Section 1 Footer"];
    BUKTableViewSection *section1 = [BUKTableViewSection sectionWithRows:nil headerViewFactory:titleHeaderViewFactory footerViewFactory:titleFooterViewFactory];

    BUKTableViewCellFactory *subtitleCellFactory = [BUKTableViewCellFactory factoryWithCellClass:[BUKDemoSubtitleTableViewCell class] configurator:^(BUKDemoSubtitleTableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = row.object;
        cell.textLabel.text = viewModel.title;
        cell.detailTextLabel.text = viewModel.subtitle;
    }];

    BUKTableViewSelection *selection = [BUKTableViewSelection selectionWithSelectionHandler:^(UITableView *tableView, BUKTableViewRow *row, NSIndexPath *indexPath) {
        NSLog(@"Selected row at index path: %@", indexPath);
    } deselectionHandler:nil];

    // Create rows in section 1
    NSMutableArray<BUKTableViewRow *> *mutableSubtitleRows = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"Row %ld", (long)i] subtitle:@"subtitle"];
        BUKTableViewRow *row = [BUKTableViewRow rowWithObject:viewModel cellFactory:subtitleCellFactory selection:selection];
        [mutableSubtitleRows addObject:row];
    }

    section1.rows = mutableSubtitleRows;

    // Section 2
    // Header
    BUKTableViewHeaderFooterViewFactory *imageHeaderViewFactory = [BUKTableViewHeaderFooterViewFactory factoryWithViewClass:[BUKDemoTableViewHeaderFooterView class] configurator:^(BUKDemoTableViewHeaderFooterView *view, BUKTableViewSection *section, UITableView *tableView, NSInteger index) {
        view.titleLabel.text = @"Section 2 Header";
    }];
    // Footer
    BUKTableViewHeaderFooterViewFactory *imageFooterViewFactory = [BUKTableViewHeaderFooterViewFactory factoryWithTitle:@"Section 2 Footer"];

    BUKTableViewSection *section2 = [BUKTableViewSection sectionWithRows:nil headerViewFactory:imageHeaderViewFactory footerViewFactory:imageFooterViewFactory];

    BUKTableViewCellFactory *value1CellFactory = [BUKTableViewCellFactory factoryWithCellClass:[BUKDemoValue1TableViewCell class] configurator:^(BUKDemoValue1TableViewCell *cell, BUKTableViewRow *row, UITableView *tableView, NSIndexPath *indexPath) {
        BUKDemoTextViewModel *viewModel = row.object;
        cell.textLabel.text = viewModel.title;
        cell.detailTextLabel.text = viewModel.subtitle;
    }];

    // Create rows in section 2
    NSMutableArray<BUKTableViewRow *> *mutableValue1Rows = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        BUKDemoTextViewModel *viewModel = [BUKDemoTextViewModel viewModelWithTitle:[NSString stringWithFormat:@"Row %ld", (long)i] subtitle:@"detail"];
        BUKTableViewRow *row = [BUKTableViewRow rowWithObject:viewModel cellFactory:value1CellFactory selection:selection];
        [mutableValue1Rows addObject:row];
    }

    section2.rows = mutableValue1Rows;

    BUKTableViewRowHeightInfo *rowHeightInfo = [BUKTableViewRowHeightInfo heightInfoWithDefaultHeight:60.0f calculator:nil];
    section2.rowHeightInfo = rowHeightInfo;

    BUKTableViewSectionHeaderFooterHeightInfo *sectionHeaderHeightInfo = [BUKTableViewSectionHeaderFooterHeightInfo heightInfoWithDefaultHeight:50.0f calculator:nil];
    section2.headerHeightInfo = sectionHeaderHeightInfo;

    // Setup data source
    self.dataSourceProvider.sections = @[section1, section2];
}

@end
