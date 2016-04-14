//
//  BUKDemoViewModel.h
//  BUKDataSourcesKit
//
//  Created by Yiming Tang on 4/14/16.
//  Copyright © 2016 Yiming Tang. All rights reserved.
//

@import Foundation;


@interface BUKDemoViewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

+ (instancetype)viewModelWithTitle:(NSString *)title subtitle:(NSString *)subtitle;
- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

@end
