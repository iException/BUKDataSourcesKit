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
#import "BUKTableViewCellFactoryProtocol.h"
#import "BUKTableViewHeaderFooterViewFactoryProtocol.h"
#import "BUKTableViewSelectionProtocol.h"
#import "BUKTableViewRowHeightInfoProtocol.h"
#import "BUKTableViewSectionHeaderFooterHeightInfoProtocol.h"


@interface BUKTableViewDataSourceProvider ()

@property (nonatomic, readonly) NSMutableSet<NSString *> *registeredCellIdentifiers;
@property (nonatomic, readonly) NSMutableSet<NSString *> *registeredHeaderFooterViewIdentifiers;

@end


@implementation BUKTableViewDataSourceProvider

#pragma mark - Class Methods

+ (instancetype)provider {
    return [[self alloc] init];
}


+ (instancetype)providerWithTableView:(UITableView *)tableView {
    return [[self alloc] initWithTableView:tableView];
}


+ (instancetype)providerWithTableView:(UITableView *)tableView sections:(NSArray<BUKTableViewSection *> *)sections {
    return [[self alloc] initWithTableView:tableView sections:sections];
}


+ (instancetype)providerWithTableView:(UITableView *)tableView sections:(NSArray<BUKTableViewSection *> *)sections cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory headerFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerFactory footerFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerFactory {
    return [[self alloc] initWithTableView:tableView sections:sections cellFactory:cellFactory headerFactory:headerFactory footerFactory:footerFactory];
}


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


- (void)setCellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory {
    NSAssert([NSThread isMainThread], @"You must access BUKTableViewDataSourceProvider from the main thread.");
    _cellFactory = cellFactory;
    [self refresh];
}


- (void)setHeaderViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactory {
    NSAssert([NSThread isMainThread], @"You must access BUKTableViewDataSourceProvider from the main thread.");
    _headerViewFactory = headerViewFactory;
    [self refresh];
}


- (void)setFooterViewFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactory {
    NSAssert([NSThread isMainThread], @"You must access BUKTableViewDataSourceProvider from the main thread.");
    _footerViewFactory = footerViewFactory;
    [self refresh];
}


#pragma mark - Initializer

- (instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<BUKTableViewSection *> *)sections cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory headerFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerFactory footerFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerFactory {
    if ((self = [super init])) {
        NSAssert([NSThread isMainThread], @"You must access BUKTableViewDataSourceProvider from the main thread.");

        _automaticallyDeselectRows = YES;
        _automaticallyRegisterCells = YES;
        _automaticallyRegisterSectionHeaderFooters = YES;
        _tableView = tableView;
        _sections = sections;
        _cellFactory = cellFactory;
        _headerViewFactory = headerFactory;
        _footerViewFactory = footerFactory;
        [self updateTableView];
    }
    return self;
}


- (instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<BUKTableViewSection *> *)sections {
    return [self initWithTableView:tableView sections:sections cellFactory:nil headerFactory:nil footerFactory:nil];
}


- (instancetype)initWithTableView:(UITableView *)tableView {
    return [self initWithTableView:tableView sections:nil];
}


- (instancetype)init {
    return [self initWithTableView:nil];
}

#pragma mark - Public

- (BUKTableViewSection *)sectionAtIndex:(NSInteger)index {
    if (self.sections.count <= index) {
        NSAssert1(NO, @"Invalid section index: %ld", (long)index);
        return nil;
    }

    return self.sections[index];
}


- (BUKTableViewRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    BUKTableViewSection *section = [self sectionAtIndex:indexPath.section];
    if (section) {
        return [section rowAtIndex:indexPath.row];
    }

    NSAssert1(NO, @"Invalid index path: %@", indexPath);
    return nil;
}


- (void)refresh {
    [self refreshRegisteredCellIdentifiers];
    [self refreshRegisteredHeaderFooterViewIdentifiers];
    [self refreshTableSections];
}


#pragma mark - Private

- (void)updateTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self refresh];
}


- (void)refreshTableSections {
    [self.tableView reloadData];
}


- (void)refreshRegisteredCellIdentifiers {
    if (!self.automaticallyRegisterCells) {
        return;
    }

    [self.sections enumerateObjectsUsingBlock:^(BUKTableViewSection * _Nonnull section, NSUInteger i, BOOL * _Nonnull stop) {
        [section.rows enumerateObjectsUsingBlock:^(BUKTableViewRow * _Nonnull row, NSUInteger j, BOOL * _Nonnull stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            id<BUKTableViewCellFactoryProtocol> cellFactory = [self cellFactoryForRow:row inSection:section];
            [self registerCellIfNecessary:cellFactory row:row indexPath:indexPath];
        }];
    }];
}


- (void)registerCellIfNecessary:(id<BUKTableViewCellFactoryProtocol>)cellFactory row:(BUKTableViewRow *)row indexPath:(NSIndexPath *)indexPath {
    if (!cellFactory) {
        return;
    }

    NSString *reuseIdentifier = [cellFactory reuseIdentifierForRow:row atIndexPath:indexPath];
    if (!reuseIdentifier || [self.registeredCellIdentifiers containsObject:reuseIdentifier]) {
        return;
    }

    Class cellClass = [cellFactory cellClassForRow:row atIndexPath:indexPath];
    NSAssert1([cellClass isSubclassOfClass:[UITableViewCell class]], @"View class: %@ isn't subclass of UITableViewCell", NSStringFromClass(cellClass));
    [self.tableView registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
    [self.registeredCellIdentifiers addObject:reuseIdentifier];
}


- (id<BUKTableViewCellFactoryProtocol>)cellFactoryForRow:(BUKTableViewRow *)row inSection:(BUKTableViewSection *)section {
    if (row.cellFactory) {
        return row.cellFactory;
    }

    if (section.cellFactory) {
        return section.cellFactory;
    }

    return self.cellFactory;
}


- (void)refreshRegisteredHeaderFooterViewIdentifiers {
    if (!self.automaticallyRegisterSectionHeaderFooters) {
        return;
    }

    [self.sections enumerateObjectsUsingBlock:^(BUKTableViewSection * _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
        id<BUKTableViewHeaderFooterViewFactoryProtocol> headerViewFactory = [self headerViewFactoryForSection:section];
        [self registerHeaderFooterViewIfNecessary:headerViewFactory section:section index:idx];
        id<BUKTableViewHeaderFooterViewFactoryProtocol> footerViewFactory = [self footerViewFactoryForSection:section];
        [self registerHeaderFooterViewIfNecessary:footerViewFactory section:section index:idx];
    }];
}


- (void)registerHeaderFooterViewIfNecessary:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)viewFactory section:(BUKTableViewSection *)section index:(NSInteger)index {
    if (!viewFactory) {
        return;
    }

    NSString *reuseIdentifier = [viewFactory reuseIdentifierForSection:section atIndex:index];
    if (!reuseIdentifier || [self.registeredHeaderFooterViewIdentifiers containsObject:reuseIdentifier]) {
        return;
    }

    Class viewClass = [viewFactory headerFooterViewClassForSection:section atIndex:index];
    NSAssert1([viewClass isSubclassOfClass:[UITableViewHeaderFooterView class]], @"View class: %@ isn't subclass of UITableViewHeaderFooterView", NSStringFromClass(viewClass));
    [self.tableView registerClass:viewClass forHeaderFooterViewReuseIdentifier:reuseIdentifier];
}


- (id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerViewFactoryForSection:(BUKTableViewSection *)section {
    if (section.headerViewFactory) {
        return section.headerViewFactory;
    }

    return self.headerViewFactory;
}


- (id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerViewFactoryForSection:(BUKTableViewSection *)section {
    if (section.footerViewFactory) {
        return section.footerViewFactory;
    }

    return self.footerViewFactory;
}


- (UIView *)headerFooterViewForSection:(BUKTableViewSection *)section inTableView:(UITableView *)tableView atIndex:(NSInteger)index factory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)viewFactory {
    if (!viewFactory) {
        return nil;
    }

    NSString *reuseIdentifier = [viewFactory reuseIdentifierForSection:section atIndex:index];
    if (!reuseIdentifier) {
        return nil;
    }

    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (!view) {
        Class viewClass = [viewFactory headerFooterViewClassForSection:section atIndex:index];
        NSAssert1([viewClass isSubclassOfClass:[UITableViewHeaderFooterView class]], @"View class: %@ isn't subclass of UITableViewHeaderFooterView", NSStringFromClass(viewClass));
        view = [[viewClass alloc] initWithReuseIdentifier:reuseIdentifier];
    }

    [viewFactory configureView:view withSection:section inTableView:tableView atIndex:index];
    return view;
}


- (id<BUKTableViewRowHeightInfoProtocol>)rowHeightInfoForRow:(BUKTableViewRow *)row inSection:(BUKTableViewSection *)section {
    if (row.heightInfo) {
        return row.heightInfo;
    }
    if (section.rowHeightInfo) {
        return section.rowHeightInfo;
    }
    return self.rowHeightInfo;
}


- (id<BUKTableViewSectionHeaderFooterHeightInfoProtocol>)headerHeightInfoForSection:(BUKTableViewSection *)section {
    if (section.headerHeightInfo) {
        return section.headerHeightInfo;
    }
    return self.sectionHeaderHeightInfo;
}


- (id<BUKTableViewSectionHeaderFooterHeightInfoProtocol>)footerHeightInfoForSection:(BUKTableViewSection *)section {
    if (section.footerHeightInfo) {
        return section.footerHeightInfo;
    }
    return self.sectionFooterHeightInfo;
}


- (id<BUKTableViewSelectionProtocol>)rowSelectionForRow:(BUKTableViewRow *)row inSection:(BUKTableViewSection *)section {
    if (row.selection) {
        return row.selection;
    }
    if (section.rowSelection) {
        return section.rowSelection;
    }
    return self.rowSelection;
}


- (id<BUKTableViewSelectionProtocol>)rowSelectionForRowAtIndexPath:(NSIndexPath *)indexPath {
    BUKTableViewSection *section = [self sectionAtIndex:indexPath.section];
    BUKTableViewRow *row = [section rowAtIndex:indexPath.row];
    return [self rowSelectionForRow:row inSection:section];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self sectionAtIndex:section].rows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BUKTableViewSection *section = [self sectionAtIndex:indexPath.section];
    BUKTableViewRow *row = [self rowAtIndexPath:indexPath];
    id<BUKTableViewCellFactoryProtocol> cellFactory = [self cellFactoryForRow:row inSection:section];
    NSAssert(cellFactory != nil, @"Cell factory must exist!!!");
    NSString *reuseIdentifier = [cellFactory reuseIdentifierForRow:row atIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cellFactory configureCell:cell withRow:row inTableView:tableView atIndexPath:indexPath];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    id<BUKTableViewHeaderFooterViewFactoryProtocol> headerViewFactory = [self headerViewFactoryForSection:section];
    return [headerViewFactory titleForSection:section atIndex:index];
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    id<BUKTableViewHeaderFooterViewFactoryProtocol> footerViewFactory = [self footerViewFactoryForSection:section];
    return [footerViewFactory titleForSection:section atIndex:index];
}


#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKTableViewSelectionProtocol> selection = [self rowSelectionForRowAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(tableView:shouldHighlightRow:atIndexPath:)]) {
        return [selection tableView:tableView shouldHighlightRow:[self rowAtIndexPath:indexPath] atIndexPath:indexPath];
    } else {
        return YES;
    }
}


- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKTableViewSelectionProtocol> selection = [self rowSelectionForRowAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(tableView:didHighlightRow:atIndexPath:)]) {
        [selection tableView:tableView didHighlightRow:[self rowAtIndexPath:indexPath] atIndexPath:indexPath];
    }
}


- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
       id<BUKTableViewSelectionProtocol> selection = [self rowSelectionForRowAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(tableView:didUnhighlightRow:atIndexPath:)]) {
        [selection tableView:tableView didUnhighlightRow:[self rowAtIndexPath:indexPath] atIndexPath:indexPath];
    }
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKTableViewSelectionProtocol> selection = [self rowSelectionForRowAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(tableView:willSelectRow:atIndexPath:)]) {
        return [selection tableView:tableView willSelectRow:[self rowAtIndexPath:indexPath] atIndexPath:indexPath];
    } else {
        return indexPath;
    }
}


- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKTableViewSelectionProtocol> selection = [self rowSelectionForRowAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(tableView:willDeselectRow:atIndexPath:)]) {
        return [selection tableView:tableView willDeselectRow:[self rowAtIndexPath:indexPath] atIndexPath:indexPath];
    } else {
        return indexPath;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.automaticallyDeselectRows) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }

    id<BUKTableViewSelectionProtocol> selection = [self rowSelectionForRowAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(tableView:didSelectRow:atIndexPath:)]) {
        [selection tableView:tableView didSelectRow:[self rowAtIndexPath:indexPath] atIndexPath:indexPath];
    }
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<BUKTableViewSelectionProtocol> selection = [self rowSelectionForRowAtIndexPath:indexPath];
    if ([selection respondsToSelector:@selector(tableView:didDeselectRow:atIndexPath:)]) {
        [selection tableView:tableView didDeselectRow:[self rowAtIndexPath:indexPath] atIndexPath:indexPath];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BUKTableViewSection *section = [self sectionAtIndex:indexPath.section];
    BUKTableViewRow *row = [self rowAtIndexPath:indexPath];
    id<BUKTableViewRowHeightInfoProtocol> rowHeightInfo = [self rowHeightInfoForRow:row inSection:section];
    if (!rowHeightInfo) {
        return tableView.rowHeight;
    }

    return [rowHeightInfo heightForRow:row atIndexPath:indexPath];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    id<BUKTableViewHeaderFooterViewFactoryProtocol> headerViewFactory = [self headerViewFactoryForSection:section];
    return [self headerFooterViewForSection:section inTableView:tableView atIndex:index factory:headerViewFactory];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    id<BUKTableViewHeaderFooterViewFactoryProtocol> footerViewFactory = [self footerViewFactoryForSection:section];
    return [self headerFooterViewForSection:section inTableView:tableView atIndex:index factory:footerViewFactory];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    id<BUKTableViewSectionHeaderFooterHeightInfoProtocol> heightInfo = [self headerHeightInfoForSection:section];
    if (!heightInfo) {
        return tableView.sectionHeaderHeight;
    }

    return [heightInfo headerFooterHeightForSection:section atIndex:index];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)index {
    BUKTableViewSection *section = [self sectionAtIndex:index];
    id<BUKTableViewSectionHeaderFooterHeightInfoProtocol> heightInfo = [self footerHeightInfoForSection:section];
    if (!heightInfo) {
        return tableView.sectionFooterHeight;
    }

    return [heightInfo headerFooterHeightForSection:section atIndex:index];
}

@end
