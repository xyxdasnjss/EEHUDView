//
//  EEShowDetailViewController.h
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 12/06/16.
//  Copyright (c) 2012年 Milestoneeee.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EEShowViewController.h"

@interface EEShowDetailViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) EEShowViewController *showViewController;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic) int type;
@end
