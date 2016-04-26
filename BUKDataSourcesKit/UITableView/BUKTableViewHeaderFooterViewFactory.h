//
//  BUKTableViewHeaderFooterViewFactory.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/14/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewHeaderFooterViewFactoryProtocol.h"


typedef void (^BUKTableViewHeaderFooterViewConfigurationHandler)(__kindof UITableViewHeaderFooterView *view, BUKTableViewSection *section, UITableView *tableView, NSInteger index);

@interface BUKTableViewHeaderFooterViewFactory : NSObject <BUKTableViewHeaderFooterViewFactoryProtocol>

@property (nonatomic, readonly) Class viewClass;
@property (nonatomic, copy, readonly) NSString *reuseIdentifier;
@property (nonatomic, copy, readonly) BUKTableViewHeaderFooterViewConfigurationHandler viewConfigurator;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic) CGFloat viewHeight;

+ (instancetype)factoryWithTitle:(NSString *)title;
+ (instancetype)factoryWithClass:(Class)viewClass configurator:(BUKTableViewHeaderFooterViewConfigurationHandler)configurator;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithViewClass:(Class)viewClass configurator:(BUKTableViewHeaderFooterViewConfigurationHandler)configurator NS_DESIGNATED_INITIALIZER;

@end
