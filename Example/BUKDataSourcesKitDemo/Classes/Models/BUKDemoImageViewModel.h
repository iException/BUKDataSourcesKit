//
//  BUKDemoImageViewModel.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/14/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//


@interface BUKDemoImageViewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, readonly) UIImage *image;

+ (instancetype)viewModelWithTitle:(NSString *)title imageName:(NSString *)imageName;
- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end
