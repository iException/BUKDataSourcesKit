//
//  BUKDemoSubtitleCollectionViewCell.m
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/25/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

#import "BUKDemoSubtitleCollectionViewCell.h"


@implementation BUKDemoSubtitleCollectionViewCell

#pragma mark - Accessors

@synthesize titleLabel = _titleLabel;
@synthesize subtitleLabel = _subtitleLabel;

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont systemFontOfSize:20.0f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleLabel.font = [UIFont systemFontOfSize:14.0f];
        _subtitleLabel.textColor = [UIColor darkTextColor];
    }
    return _subtitleLabel;
}


#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subtitleLabel];
        [self setupViewConstraints];
    }
    return self;
}


#pragma mark - UICollectionViewCell

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    if (highlighted) {
        self.backgroundColor = [UIColor lightGrayColor];
    } else {
        if (self.selected) {
            self.backgroundColor = [UIColor cyanColor];
        } else {
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}


-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if (selected) {
        self.backgroundColor = [UIColor cyanColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}


#pragma mark - Private

- (void)setupViewConstraints {
    NSDictionary *views = @{
        @"titleLabel" : self.titleLabel,
        @"subtitleLabel" : self.subtitleLabel,
    };

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|" options:kNilOptions metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[subtitleLabel]-|" options:kNilOptions metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel]-[subtitleLabel]-|" options:kNilOptions metrics:nil views:views]];
}

@end
