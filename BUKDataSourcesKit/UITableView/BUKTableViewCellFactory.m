//
//  BUKTableViewCellFactory.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/13/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewCellFactory.h"


@implementation BUKTableViewCellFactory

#pragma mark - Class Methods

+ (instancetype)factoryWithCellClass:(Class)cellClass configurator:(BUKTableViewCellConfigurationHandler)configurator {
    return [[self alloc] initWithCellClass:cellClass configurator:configurator];
}

#pragma mark - Accessors

- (void)setCellHeight:(CGFloat)cellHeight {
    if (cellHeight < 0.0f) {
        return;
    }

    _cellHeight = cellHeight;
}


#pragma mark - Initializer

- (instancetype)initWithCellClass:(Class)cellClass configurator:(BUKTableViewCellConfigurationHandler)configurator {
    NSParameterAssert([cellClass isSubclassOfClass:[UITableViewCell class]]);

    if ((self = [super init])) {
        _cellClass = cellClass;
        _reuseIdentifier = NSStringFromClass(cellClass);
        _cellConfigurator = [configurator copy];
        _cellHeight = 50.0f;
    }
    return self;
}


#pragma mark - BUKTableViewCellFactoryProtocol

- (Class)cellClassForRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    return self.cellClass;
}


- (NSString *)reuseIdentifierForRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    return self.reuseIdentifier;
}


- (void)configureCell:(__kindof UITableViewCell *)cell withRow:(BUKTableViewRow *)row inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if (self.cellConfigurator) {
        self.cellConfigurator(cell, row, tableView, indexPath);
    }
}


- (CGFloat)heightForRow:(BUKTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

@end
