//
//  TMTableVC.h
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMTableVC : UITableViewController

/**
 *0 : plan
 *1 : group
 */
@property (nonatomic, assign) NSInteger tableViewStyle;

/** 数据源*/
@property (nonatomic, copy) NSArray *dataSource;

/** 当前页码：从1开始*/
@property (nonatomic, assign) NSInteger pageNum;

/** 每页数量*/
@property (nonatomic, assign) NSInteger numOfPage;

/** 是否需要下拉刷新*/
@property (nonatomic, assign, getter=isHeadRefresh) BOOL headRefresh;

/** 是否需要上拉加载*/
@property (nonatomic, assign, getter=isFootRefresh) BOOL footRefresh;



@end

NS_ASSUME_NONNULL_END
