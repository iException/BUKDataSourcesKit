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
@protocol BUKTableViewHeaderFooterViewFactoryProtocol;

@interface BUKTableViewDataSourceProvider : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray<BUKTableViewSection *> *sections;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic) BOOL automaticallyDeselectRows;
@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> headerViewFactory;
@property (nonatomic) id<BUKTableViewHeaderFooterViewFactoryProtocol> footerViewFactory;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<BUKTableViewSection *> *)sections NS_DESIGNATED_INITIALIZER;
- (BUKTableViewSection *)sectionAtIndex:(NSInteger)index;
- (BUKTableViewRow *)rowAtIndexPath:(NSIndexPath *)indexPath;

@end
