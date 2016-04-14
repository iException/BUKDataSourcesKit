//
//  BUKTableViewDataSourceProvider.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewDataSourceProvider.h"
#import "BUKTableViewSection.h"
#import "BUKTableViewRow.h"
#import "BUKTableViewCellFactory.h"
#import "BUKTableViewHeaderFooterViewFactory.h"


@interface BUKTableViewDataSourceProvider ()

@property (nonatomic, readonly) NSMutableSet<NSString *> *registeredCellIdentifiers;

@end



@implementation BUKTableViewDataSourceProvider

#pragma mark - Accessors

@synthesize registeredCellIdentifiers = _registeredCellIdentifiers;

- (NSMutableSet<NSString *> *)registeredCellIdentifiers {
    if (!_registeredCellIdentifiers) {
        _registeredCellIdentifiers = [[NSMutableSet alloc] init];
    }
    return _registeredCellIdentifiers;
}


- (void)setTableView:(UITableView *)tableView {
    NSAssert([NSThread isMainThread], @"You must access BUKTableViewDataSourceProvider from the main thread.");

    _tableView.delegate = nil;
    _tableView.dataSource = nil;

    [self.registeredCellIdentifiers removeAllObjects];

    _tableView = tableView;
    [self updateTableView];
}


- (void)setSections:(NSArray<BUKTableViewSection *> *)sections {
    NSAssert([NSThread isMainThread], @"You must access BUKTableViewDataSourceProvider from the main thread.");

    _sections = sections;
    [self refresh];
}


#pragma mark - Initializer

- (instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<BUKTableViewSection *> *)sections {
    if ((self = [super init])) {
        _tableView = tableView;
        _sections = sections;
        [self updateTableView];
    }
    return self;
}


- (instancetype)initWithTableView:(UITableView *)tableView {
    return [self initWithTableView:tableView sections:nil];
}


#pragma mark - Private

- (void)updateTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self refresh];
}


- (void)refresh {
    [self refreshRegisteredCellIdentifiers];
    [self refreshTableSections];
}


- (void)refreshTableSections {
    [self.tableView reloadData];
}


- (void)refreshRegisteredCellIdentifiers {
    [self.sections enumerateObjectsUsingBlock:^(BUKTableViewSection * _Nonnull section, NSUInteger i, BOOL * _Nonnull stop) {
        [section.rows enumerateObjectsUsingBlock:^(BUKTableViewRow * _Nonnull row, NSUInteger j, BOOL * _Nonnull stop) {
            if (row.cellFactory) {
                NSString *cellIdentifier = [row.cellFactory reuseIdentifierForRow:row atIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
                if (![self.registeredCellIdentifiers containsObject:cellIdentifier]) {
                    Class cellClass = [row.cellFactory cellClassForRow:row atIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
                    [self.tableView registerClass:cellClass forCellReuseIdentifier:cellIdentifier];
                    [self.registeredCellIdentifiers addObject:cellIdentifier];
                }
            }
        }];
    }];
}


- (BUKTableViewSection *)sectionAtIndex:(NSInteger)index {
    if (self.sections.count <= index) {
        NSAssert1(NO, @"Invalid section index: %d", index);
        return nil;
    }

    return self.sections[index];
}


- (BUKTableViewRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    BUKTableViewSection *section = [self sectionAtIndex:indexPath.section];
    if (section) {
        NSArray<BUKTableViewRow *> *rows = section.rows;
        if (indexPath.row < rows.count) {
            return rows[indexPath.row];
        }
    }

    NSAssert1(NO, @"Invalid index path: %@", indexPath);
    return nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self sectionAtIndex:section].rows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BUKTableViewRow *row = [self rowAtIndexPath:indexPath];
    id<BUKTableViewCellFactoryProtocol> cellFactory = row.cellFactory;
    if (cellFactory) {
        NSString *reuseIdentifier = [cellFactory reuseIdentifierForRow:row atIndexPath:indexPath];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        [cellFactory configureCell:cell withRow:row inTableView:tableView atIndexPath:indexPath];
        return cell;
    }

    return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:section];
    return [section.headerViewFactory titleForSection:section atIndex:index];
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:section];
    return [section.footerViewFactory titleForSection:section atIndex:index];
}


#pragma mark - UITableViewDelegate

@end
