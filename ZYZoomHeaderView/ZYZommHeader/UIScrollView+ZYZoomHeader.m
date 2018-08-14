//
//  UIScrollView+ZYZoomHeader.m
//  ZYZoomHeaderView
//
//  Created by gzy on 2018/8/14.
//  Copyright © 2018年 gzy. All rights reserved.
//

#import "UIScrollView+ZYZoomHeader.h"
#import "ZYZoomHeaderView.h"
#import <objc/runtime.h>

static const void *ZY_ZoomHeaderKey = "ZY_ZoomHeaderKey";
@implementation UIScrollView (ZYZoomHeader)

- (ZYZoomHeaderView *)zy_zoomHeader {
    return objc_getAssociatedObject(self, ZY_ZoomHeaderKey);
}
- (void)setZy_zoomHeader:(ZYZoomHeaderView *)zy_zoomHeader {
    if (zy_zoomHeader != self.zy_zoomHeader) {
        [self.zy_zoomHeader removeFromSuperview];
        [self insertSubview:zy_zoomHeader atIndex:0];
        objc_setAssociatedObject(self, ZY_ZoomHeaderKey, zy_zoomHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
@end
