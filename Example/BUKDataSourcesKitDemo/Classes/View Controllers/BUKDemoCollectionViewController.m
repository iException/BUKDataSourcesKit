//
//  BUKDemoCollectionViewController.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/13/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

#import "BUKDemoCollectionViewController.h"


@interface BUKDemoCollectionViewController ()

@end


@implementation BUKDemoCollectionViewController

#pragma mark - Initializer

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    return [super initWithCollectionViewLayout:flowLayout];
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Collection View";
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

@end
