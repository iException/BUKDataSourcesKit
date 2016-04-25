//
//  BUKDemoCollectionViewSectionHeaderView.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/25/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//


#import "BUKDemoCollectionViewSectionHeaderView.h"

@implementation BUKDemoCollectionViewSectionHeaderView

#pragma mark - Accessors

@synthesize titleLabel = _titleLabel;

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.textColor = [UIColor blueColor];
    }
    return _titleLabel;
}


#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self addSubview:self.titleLabel];
        [self setupViewConstraints];
    }
    return self;
}


#pragma mark - Private

- (void)setupViewConstraints {
    NSDictionary *views = @{
        @"titleLabel" : self.titleLabel,
    };

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[titleLabel]-(>=20)-|" options:kNilOptions metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

@end
