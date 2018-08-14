
//
//  YXZoomHeaderView.m
//  ZYZoomHeaderView
//
//  Created by gzy on 2018/8/14.
//  Copyright © 2018年 gzy. All rights reserved.
//

#import "ZYZoomHeaderView.h"


static NSString *const  ZoomHeaderContenOffsetKey = @"contentOffset";
@interface ZYZoomHeaderView ()

@property (nonatomic, strong) UIImageView *backGroundImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end


@implementation ZYZoomHeaderView

#pragma mark - Life Cycle Methods
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self zy_layoutSubViews];
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
        [self zy_layoutSubViews];

    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self zy_layoutSubViews];

    }
    return self;
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    self.scrollView = (UIScrollView *)newSuperview;
    [self zy_setupHeaderRect];
    [self zy_addObservers];
}
#pragma mark - Intial Methods
- (void)zy_layoutSubViews {
    self.backGroundImageView = [[UIImageView alloc] init];
    [self addSubview:self.backGroundImageView];
}
#pragma mark - Private Methods
- (void)zy_addObservers {
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:ZoomHeaderContenOffsetKey options:options context:nil];
    
}
// 设置UIScrollView的偏移
- (void)zy_setupHeaderRect {
    //设置范围
    CGFloat height = self.bounds.size.height;
    CGRect frame = self.frame;
    frame.origin.y = -height;
    self.frame = frame;
    //    设置内容缩进
    self.scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:ZoomHeaderContenOffsetKey]) {
        
        [self scrollviewContentOffsetDidChange:change];
        
    }else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)scrollviewContentOffsetDidChange:(NSDictionary *)change {
    
    CGFloat offset = fabs(self.scrollView.contentOffset.y);
    if (@available(iOS 11.0, *)) {
        //顶部适应缩进
        CGFloat top = self.scrollView.adjustedContentInset.top;
        offset -= top;
    }
    //计算高度
    CGFloat height = [self imgViewRect].size.height + offset;
    
    //计算宽度
    CGFloat width = height * (self.imgViewRect.size.width/self.imgViewRect.size.height);
    CGFloat x = - (width - self.imgViewRect.size.width)/2.f + self.imgViewRect.origin.x;
    CGFloat y = -offset + self.imgViewRect.origin.y;
    //设置大小
    self.backGroundImageView.frame = CGRectMake(x, y, width, height);
    //如果向上滚动，大小不变
    if (offset <= 0) {
        self.backGroundImageView.frame = self.imgViewRect;
    }
}
- (CGRect)imgViewRect {
    
    CGRect rect = self.bounds;
    rect.origin.x = self.imageInsets.left;
    rect.origin.y = self.imageInsets.top;
    rect.size.width -= (self.imageInsets.left + self.imageInsets.right);
    rect.size.height -= (self.imageInsets.top + self.imageInsets.bottom);
    return rect;
}
#pragma mark - setter Methods
- (void)setImage:(UIImage *)image {
    _image = image;
    _backGroundImageView.image = image;
}

@end
