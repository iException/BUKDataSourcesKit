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

@interface BUKTableViewDataSourceProvider : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray<BUKTableViewSection *> *sections;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic) BOOL automaticallyDeselectRows;
@property (nonatomic) id<BUKTableViewCellFactoryProtocol> cellFactory;
@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> headerViewFactory;
@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> footerViewFactory;
@property (nonatomic) id<BUKTableViewRowHeightInfoProtocol> rowHeightInfo;
@property (nonatomic) id<BUKTableViewSectionHeaderFooterHeightInfoProtocol> sectionHeaderHeightInfo;
@property (nonatomic) id<BUKTableViewSectionHeaderFooterHeightInfoProtocol> sectionFooterHeightInfo;

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
