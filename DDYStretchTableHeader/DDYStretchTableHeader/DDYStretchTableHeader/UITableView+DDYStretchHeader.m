

#import "UITableView+DDYStretchHeader.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic, strong) UIView *stretchBackView;

@property (nonatomic, strong) UIView *stretchHeaderView;

@property (nonatomic, assign) CGFloat stretchOriginalHeight;

@end

@implementation UITableView (DDYStretchHeader)

- (UIView *)stretchBackView {
    UIView *backView = objc_getAssociatedObject(self, @selector(stretchBackView));
    return backView;
}

- (void)setStretchBackView:(UIView *)stretchBackView {
    objc_setAssociatedObject(self, @selector(stretchBackView), stretchBackView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)stretchHeaderView {
    UIView *backView = objc_getAssociatedObject(self, @selector(stretchHeaderView));
    return backView;
}

- (void)setStretchHeaderView:(UIView *)stretchHeaderView {
    objc_setAssociatedObject(self, @selector(stretchHeaderView), stretchHeaderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)stretchOriginalHeight {
    NSNumber *maxHeightNumber = objc_getAssociatedObject(self, @selector(stretchOriginalHeight));
    return [maxHeightNumber floatValue];
}

- (void)setStretchOriginalHeight:(CGFloat)stretchOriginalHeight {
    objc_setAssociatedObject(self, @selector(stretchOriginalHeight), [NSNumber numberWithFloat:stretchOriginalHeight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ddy_StretchBackView:(UIView *)backView headerView:(UIView *)headerView {
    if (self.stretchBackView) [self.stretchBackView removeFromSuperview];
    if (self.stretchHeaderView) [self.stretchHeaderView removeFromSuperview];
    self.stretchBackView = backView;
    self.stretchHeaderView = headerView;
    self.stretchOriginalHeight = backView.frame.size.height;
    self.tableHeaderView = [[UIView alloc] initWithFrame:backView.frame];
    [self addSubview:self.stretchBackView];
    [self addSubview:self.stretchHeaderView];
}

- (void)ddy_StretchScrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        CGFloat offsetY = -1 * (scrollView.contentOffset.y + scrollView.contentInset.top);
        self.stretchBackView.frame = CGRectMake(-offsetY/2., -offsetY, self.frame.size.width+offsetY, self.stretchOriginalHeight+offsetY);
    }
}

- (void)DDY_StretchReset {
    self.stretchBackView.frame = CGRectMake(0, 0, self.frame.size.width, self.stretchOriginalHeight);
}

@end
