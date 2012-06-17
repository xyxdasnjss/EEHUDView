//
//  EEShowViewController.h
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 12/06/16.
//  Copyright (c) 2012年 Milestoneeee.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EEHUDView.h"

@interface EEShowViewController : UITableViewController

- (void)updateShowStyle:(int)newShowStyle;
- (void)updateHideStyle:(EEHUDViewHideStyle )newHideStyle;
- (void)updateResultStyle:(EEHUDResultViewStyle )newResultStyle;
@end
