//
//  BUKTableViewHeaderFooterViewFactory.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/14/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewHeaderFooterViewFactory.h"

@implementation BUKTableViewHeaderFooterViewFactory

#pragma mark - Class Methods

+ (instancetype)factoryWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}


+ (instancetype)factoryWithViewClass:(Class)viewClass configurator:(BUKTableViewHeaderFooterViewConfigurationHandler)configurator {
    return [[self alloc] initWithViewClass:viewClass configurator:configurator];
}


#pragma mark - Accessors

- (void)setViewHeight:(CGFloat)height {
    if (height < 0.0f) {
        return;
    }

    _viewHeight = height;
}


#pragma mark - Initializer

- (instancetype)initWithViewClass:(Class)viewClass configurator:(BUKTableViewHeaderFooterViewConfigurationHandler)configurator {
    NSParameterAssert([viewClass isSubclassOfClass:[UITableViewHeaderFooterView class]]);

    if ((self = [super init])) {
        _viewClass = viewClass;
        _viewConfigurator = [configurator copy];
        _reuseIdentifier = NSStringFromClass(viewClass);
        _viewHeight = UITableViewAutomaticDimension;
    }

    return self;
}


- (instancetype)initWithTitle:(NSString *)title {
    if ((self = [super init])) {
        _title = [title copy];
        _viewHeight = UITableViewAutomaticDimension;
    }

    return self;
}


#pragma mark - BUKTableViewHeaderFooterViewFactoryProtocol

- (NSString *)titleForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index {
    return self.title;
}


- (Class)headerFooterViewClassForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index {
    return self.viewClass;
}


- (NSString *)reuseIdentifierForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index {
    return self.reuseIdentifier;
}


- (void)configureView:(__kindof UITableViewHeaderFooterView *)view withSection:(BUKTableViewSection *)section inTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    if (self.viewConfigurator) {
        self.viewConfigurator(view, section, tableView, index);
    }
}


- (CGFloat)heightForSection:(BUKTableViewSection *)section atIndex:(NSInteger)index {
    return self.viewHeight;
}

@end
