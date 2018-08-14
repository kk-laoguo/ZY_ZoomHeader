//
//  customHeaderView.m
//  ZYZoomHeaderView
//
//  Created by gzy on 2018/8/14.
//  Copyright © 2018年 gzy. All rights reserved.
//

#import "CustomHeaderView.h"

@implementation CustomHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"bg"];
    }
    return self;
}

@end
