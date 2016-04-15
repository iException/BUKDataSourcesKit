//
//  BUKTableViewHeaderFooterViewFactory.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/14/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

@import UIKit;

@class BUKTableViewSection;

@protocol BUKTableViewHeaderFooterViewFactoryProtocol <NSObject>

@required
- (NSString *)titleForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index;
- (NSString *)reuseIdentifierForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index;
- (Class)headerFooterViewClassForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index;
- (void)configureView:(__kindof UITableViewHeaderFooterView *)view withSection:(BUKTableViewSection *)section inTableView:(UITableView *)tableView atIndex:(NSInteger)index;
- (CGFloat)heightForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index;

@end


typedef void (^BUKTableViewHeaderFooterViewConfigurationHandler)(__kindof UITableViewHeaderFooterView *view, BUKTableViewSection *section, UITableView *tableView, NSInteger index);

@interface BUKTableViewHeaderFooterViewFactory : NSObject <BUKTableViewHeaderFooterViewFactoryProtocol>

@property (nonatomic, readonly) Class viewClass;
@property (nonatomic, copy, readonly) NSString *reuseIdentifier;
@property (nonatomic, copy, readonly) BUKTableViewHeaderFooterViewConfigurationHandler viewConfigurator;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic) CGFloat viewHeight;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithViewClass:(Class)viewClass configurator:(BUKTableViewHeaderFooterViewConfigurationHandler)configurator NS_DESIGNATED_INITIALIZER;

@end
