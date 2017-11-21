//
//  BUKTableViewDataSourceProvider.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;


@class BUKTableViewRow;
@class BUKTableViewSection;
@protocol BUKTableViewCellFactoryProtocol;
@protocol BUKTableViewHeaderFooterViewFactoryProtocol;
@protocol BUKTableViewRowHeightInfoProtocol;
@protocol BUKTableViewSectionHeaderFooterHeightInfoProtocol;
@protocol BUKTableViewSelectionProtocol;
@protocol BUKTableViewDataSourceProviderDelegate;


@interface BUKTableViewDataSourceProvider : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray<BUKTableViewSection *> *sections;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) id<BUKTableViewDataSourceProviderDelegate> delegate;
@property (nonatomic) BOOL automaticallyDeselectRows;
@property (nonatomic) BOOL automaticallyRegisterCells;
@property (nonatomic) BOOL automaticallyRegisterSectionHeaderFooters;
@property (nonatomic) id<BUKTableViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> headerViewFactory;
@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> footerViewFactory;
@property (nonatomic) id<BUKTableViewRowHeightInfoProtocol> rowHeightInfo;
@property (nonatomic) id<BUKTableViewSectionHeaderFooterHeightInfoProtocol> sectionHeaderHeightInfo;
@property (nonatomic) id<BUKTableViewSectionHeaderFooterHeightInfoProtocol> sectionFooterHeightInfo;
@property (nonatomic) id<BUKTableViewSelectionProtocol> rowSelection;

+ (instancetype)provider;
+ (instancetype)providerWithTableView:(UITableView *)tableView;
+ (instancetype)providerWithTableView:(UITableView *)tableView
                             sections:(NSArray<BUKTableViewSection *> *)sections;
+ (instancetype)providerWithTableView:(UITableView *)tableView
                         sections:(NSArray<BUKTableViewSection *> *)sections
                      cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory
                    headerFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerFactory
                    footerFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerFactory;

- (instancetype)initWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView
                         sections:(NSArray<BUKTableViewSection *> *)sections;
- (instancetype)initWithTableView:(UITableView *)tableView
                         sections:(NSArray<BUKTableViewSection *> *)sections
                      cellFactory:(id<BUKTableViewCellFactoryProtocol>)cellFactory
                    headerFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)headerFactory
                    footerFactory:(id<BUKTableViewHeaderFooterViewFactoryProtocol>)footerFactory NS_DESIGNATED_INITIALIZER;

- (BUKTableViewSection *)sectionAtIndex:(NSInteger)index;
- (BUKTableViewRow *)rowAtIndexPath:(NSIndexPath *)indexPath;
- (void)refresh;

@end


@interface BUKTableViewDataSourceProvider (ManipulatingSections)

- (void)addSection:(BUKTableViewSection *)section;
- (void)insertSection:(BUKTableViewSection *)section atIndex:(NSUInteger)index;
- (void)removeLastSection;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)replaceSectionAtIndex:(NSInteger)index withSection:(BUKTableViewSection *)section;
- (void)removeAllSections;

@end


@protocol BUKTableViewDataSourceProviderDelegate <NSObject>

typedef NS_ENUM(NSUInteger, BUKTableViewDataSourceChangeType) {
    BUKTableViewDataSourceChangeInsert = 1,
    BUKTableViewDataSourceChangeDelete = 2,
    BUKTableViewDataSourceChangeMove = 3,
    BUKTableViewDataSourceChangeUpdate = 4
};

@optional
- (void)provider:(BUKTableViewDataSourceProvider *)provider didChangeRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath forChangeType:(BUKTableViewDataSourceChangeType)type newIndexPath:(NSIndexPath *)newIndexPath;
- (void)provider:(BUKTableViewDataSourceProvider *)provider didChangeSection:(BUKTableViewSection *)section atIndex:(NSUInteger)sectionIndex forChangeType:(BUKTableViewDataSourceChangeType)type;
- (void)providerWillChangeContent:(BUKTableViewDataSourceProvider *)controller;
- (void)providerDidChangeContent:(BUKTableViewDataSourceProvider *)controller;

@end
