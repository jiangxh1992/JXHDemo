#import <UIKit/UIKit.h>

const CGFloat MJRefreshHeaderHeight = 44.0;
const CGFloat MJRefreshFooterHeight = 44.0;
const CGFloat MJRefreshFastAnimationDuration = 0.25;
const CGFloat MJRefreshSlowAnimationDuration = 0.4;

NSString *const MJRefreshHeaderUpdatedTimeKey = @"MJRefreshHeaderUpdatedTimeKey";
NSString *const MJRefreshContentOffset = @"contentOffset";
NSString *const MJRefreshContentSize = @"contentSize";
NSString *const MJRefreshPanState = @"pan.state";

NSString *const MJRefreshHeaderStateIdleText = @"下拉刷新";
NSString *const MJRefreshHeaderStatePullingText = @"释放更新";
NSString *const MJRefreshHeaderStateRefreshingText = @"加载中...";

NSString *const MJRefreshFooterStateIdleText = @"点击加载更多";
NSString *const MJRefreshFooterStateRefreshingText = @"加载中...";
NSString *const MJRefreshFooterStateNoMoreDataText = @"已加载全部";