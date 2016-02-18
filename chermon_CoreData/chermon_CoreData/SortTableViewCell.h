//
//  SortTableViewCell.h
//  chermon_天猫
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 zhengqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *lbTitle;
@property (nonatomic,weak)IBOutlet UILabel *lbPrice;
@property (nonatomic,weak)IBOutlet UIImageView *imageLogo;
@property (nonatomic,weak)IBOutlet UIButton *btnAdd;
@end
