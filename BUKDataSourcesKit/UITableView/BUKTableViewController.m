//
//  BUKTableViewController.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 3/21/16.
//  Copyright (c) 2016 Yiming Tang. All rights reserved.
//

#import "BUKTableViewController.h"
#import "BUKTableViewDataSourceProvider.h"


@interface BUKTableViewController ()

@property (nonatomic) UITableViewStyle tableViewStyle;
@property (nonatomic, readwrite) BUKTableViewDataSourceProvider *dataSourceProvider;

@end


@implementation BUKTableViewController

#pragma mark - Initializer

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _tableViewStyle = UITableViewStylePlain;
        _clearsSelectionOnViewWillAppear = YES;
    }
    return self;
}


- (instancetype)initWithStyle:(UITableViewStyle)style {
    if ((self = [self initWithNibName:nil bundle:nil])) {
        _tableViewStyle = style;
    }
    return self;
}


#pragma mark - UIViewController

- (void)loadView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceProvider = [[BUKTableViewDataSourceProvider alloc] initWithTableView:self.tableView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self performInitialLoad];
    [self clearSelectionsIfNecessary:animated];
}

#pragma mark - Private

- (void)performInitialLoad {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.tableView reloadData];
    });
}


- (void)clearSelectionsIfNecessary:(BOOL)animated {
    if (self.clearsSelectionOnViewWillAppear) {
        return;
    }

    NSArray<NSIndexPath *> *selectedIndexPaths = self.tableView.indexPathsForSelectedRows;
    if (selectedIndexPaths) {
        return;
    }

    id<UIViewControllerTransitionCoordinator> transitionCoordinator = [self transitionCoordinator];
    if (!transitionCoordinator) {
        [self deselectRowsAtIndexPaths:selectedIndexPaths animated:animated];
        return;
    }

    __weak typeof(self)weakSelf = self;
    void (^animation)(id<UIViewControllerTransitionCoordinatorContext> context) = ^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [weakSelf deselectRowsAtIndexPaths:selectedIndexPaths animated:animated];
    };

    void (^completion)(id<UIViewControllerTransitionCoordinatorContext> context) = ^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if ([context isCancelled]) {
            [weakSelf selectRowsAtIndexPaths:selectedIndexPaths animated:animated];
        }
    };

    [transitionCoordinator animateAlongsideTransition:animation completion:completion];
}


- (void)selectRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animated:(BOOL)animated {
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionNone];
    }];
}


- (void)deselectRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animated:(BOOL)animated {
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    }];
}

@end
