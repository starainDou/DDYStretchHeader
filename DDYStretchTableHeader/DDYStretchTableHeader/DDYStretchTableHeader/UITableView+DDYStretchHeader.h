
#import <UIKit/UIKit.h>

@interface UITableView (DDYStretchHeader)

- (void)ddy_StretchBackView:(UIView *)backView headerView:(UIView *)headerView;

- (void)ddy_StretchScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)DDY_StretchReset;

@end
