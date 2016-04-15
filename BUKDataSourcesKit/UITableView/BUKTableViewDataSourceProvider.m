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
@property (nonatomic, readonly) NSMutableSet<NSString *> *registeredHeaderFooterViewIdentifiers;

@end


@implementation BUKTableViewDataSourceProvider

#pragma mark - Accessors

@synthesize registeredCellIdentifiers = _registeredCellIdentifiers;
@synthesize registeredHeaderFooterViewIdentifiers = _registeredHeaderFooterViewIdentifiers;

- (NSMutableSet<NSString *> *)registeredCellIdentifiers {
    if (!_registeredCellIdentifiers) {
        _registeredCellIdentifiers = [[NSMutableSet alloc] init];
    }
    return _registeredCellIdentifiers;
}


- (NSMutableSet<NSString *> *)registeredHeaderFooterViewIdentifiers {
    if (!_registeredHeaderFooterViewIdentifiers) {
        _registeredHeaderFooterViewIdentifiers = [[NSMutableSet alloc] init];
    }
    return _registeredHeaderFooterViewIdentifiers;
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
        NSAssert([NSThread isMainThread], @"You must access BUKTableViewDataSourceProvider from the main thread.");

        _automaticallyDeselectRows = YES;
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
    [self refreshRegisteredHeaderFooterViewIdentifiers];
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


- (void)refreshRegisteredHeaderFooterViewIdentifiers {
    [self.sections enumerateObjectsUsingBlock:^(BUKTableViewSection * _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
        if (section.headerViewFactory) {
            NSString *headerIdentifier = [section.headerViewFactory reuseIdentifierForSection:section atIndex:idx];
            if (headerIdentifier && ![self.registeredHeaderFooterViewIdentifiers containsObject:headerIdentifier]) {
                Class headerClass = [section.headerViewFactory headerFooterViewClassForSection:section atIndex:idx];
                NSAssert1([headerClass isSubclassOfClass:[UITableViewHeaderFooterView class]], @"Header class: %@ isn't subclass of UITableViewHeaderFooterView", NSStringFromClass(headerClass));
                [self.tableView registerClass:headerClass forHeaderFooterViewReuseIdentifier:headerIdentifier];
                [self.registeredHeaderFooterViewIdentifiers addObject:headerIdentifier];
            }
        }

        if (section.footerViewFactory) {
            NSString *footerIdentifier = [section.footerViewFactory reuseIdentifierForSection:section atIndex:idx];
            if (footerIdentifier && ![self.registeredHeaderFooterViewIdentifiers containsObject:footerIdentifier]) {
                Class footerClass = [section.footerViewFactory headerFooterViewClassForSection:section atIndex:idx];
                NSAssert1([footerClass isSubclassOfClass:[UITableViewHeaderFooterView class]], @"Footer class: %@ isn't subclass of UITableViewHeaderFooterView", NSStringFromClass(footerClass));
                [self.tableView registerClass:footerClass forHeaderFooterViewReuseIdentifier:footerIdentifier];
            }
        }
    }];
}


- (BUKTableViewSection *)sectionAtIndex:(NSInteger)index {
    if (self.sections.count <= index) {
        NSAssert1(NO, @"Invalid section index: %ld", index);
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
    BUKTableViewSection *section = [self sectionAtIndex:index];
    return [section.headerViewFactory titleForSection:section atIndex:index];
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    return [section.footerViewFactory titleForSection:section atIndex:index];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.automaticallyDeselectRows) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }

    BUKTableViewRow *row = [self rowAtIndexPath:indexPath];
    if (row.selection) {
        row.selection(row, tableView, indexPath);
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    if (!section.headerViewFactory) {
        return nil;
    }

    NSString *reuseIdentifier = [section.headerViewFactory reuseIdentifierForSection:section atIndex:index];
    if (!reuseIdentifier) {
        return nil;
    }

    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (!headerView) {
        Class headerViewClass = [section.headerViewFactory headerFooterViewClassForSection:section atIndex:index];
        NSAssert1([headerViewClass isSubclassOfClass:[UITableViewHeaderFooterView class]], @"Header class: %@ isn't subclass of UITableViewHeaderFooterView", NSStringFromClass(headerViewClass));
        headerView = [[headerViewClass alloc] initWithReuseIdentifier:reuseIdentifier];
    }

    [section.headerViewFactory configureView:headerView withSection:section inTableView:tableView atIndex:index];
    return headerView;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    if (!section.footerViewFactory) {
        return nil;
    }

    NSString *reuseIdentifier = [section.footerViewFactory reuseIdentifierForSection:section atIndex:index];
    if (!reuseIdentifier) {
        return nil;
    }

    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (!footerView) {
        Class footerViewClass = [section.footerViewFactory headerFooterViewClassForSection:section atIndex:index];
        NSAssert1([footerViewClass isSubclassOfClass:[UITableViewHeaderFooterView class]], @"Footer class: %@ isn't subclass of UITableViewHeaderFooterView", NSStringFromClass(footerViewClass));
        footerView = [[footerViewClass alloc] initWithReuseIdentifier:reuseIdentifier];
    }

    [section.footerViewFactory configureView:footerView withSection:section inTableView:tableView atIndex:index];
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    if (!section.headerViewFactory) {
        return 0;
    }

    return [section.headerViewFactory heightForSection:section atIndex:index];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    if (!section.footerViewFactory) {
        return 0;
    }

    return [section.footerViewFactory heightForSection:section atIndex:index];
}

@end
