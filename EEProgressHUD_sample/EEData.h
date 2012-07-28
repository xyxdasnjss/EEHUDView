//
//  EEData.h
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 12/06/16.
//  Copyright (c) 2012年 Milestoneeee.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EEHUDView.h"

@interface EEData : NSObject



- (NSString *)stringShowStyle:(int)index;
- (NSString *)stringHideStyle:(int)index;
- (NSString *)stringResultStyle:(int)index;
- (NSString *)stringActivityStyle:(int)index;

- (NSString *)abbreviatedStringShowStyle:(int)index;
- (NSString *)abbreviatedStringHideStyle:(int)index;
- (NSString *)abbreviatedStringResultStyle:(int)index;
- (NSString *)abbreviatedStringActivityStyle:(int)index;

- (int)countOfShowStyle;
- (int)countOfHideStyle;
- (int)countOfResultStyle;
- (int)countOfActivityStyle;
@end
