//
//  TMCell.h
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import <UIKit/UIKit.h>
#import "TMCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMCell : UITableViewCell

@property (nonatomic, strong) TMCellViewModel *cellViewModel;

- (void)bindViewModel:(TMCellViewModel *)cellViewModel __attribute__((objc_requires_super));

@end

NS_ASSUME_NONNULL_END
