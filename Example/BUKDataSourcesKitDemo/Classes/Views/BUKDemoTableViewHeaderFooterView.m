//
//  BUKDemoTableViewHeaderFooterView.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/15/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

#import "BUKDemoTableViewHeaderFooterView.h"

@implementation BUKDemoTableViewHeaderFooterView

#pragma mark - Accessors

@synthesize imageView = _imageView;
@synthesize titleLabel = _titleLabel;

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}


#pragma mark - UITableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithReuseIdentifier:reuseIdentifier])) {
        self.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self setupViewConstraints];
    }

    return self;
}


#pragma mark - Private

- (void)setupViewConstraints {
    NSDictionary *views = @{
        @"imageView" : self.imageView,
        @"titleLabel" : self.titleLabel,
    };

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[imageView(32)]" options:kNilOptions metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageView(32)]-20-[titleLabel]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
}

@end
