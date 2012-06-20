//
//  EEProgressHUD.h
//  KJPN
//
//  Created by Kudo Yoshiki on 11/12/05.
//  Copyright (c) 2011年 Milestoneeee.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EEHUDResultView.h"

typedef enum _EEHUDViewShowStyle {
    EEHUDViewShowStyleFadeIn = 0,
    EEHUDViewShowStyleLutz = 1,
    EEHUDViewShowStyleShake = 2,
    EEHUDViewShowStyleNoAnime = 3,
    EEHUDViewShowStyleFromRight = 4,
    EEHUDViewShowStyleFromLeft = 5,
    EEHUDViewShowStyleFromTop = 6,
    EEHUDViewShowStyleFromBottom = 7
} EEHUDViewShowStyle;

typedef enum _EEHUDViewHideStyle {
    EEHUDViewHideStyleFadeOut = 0,
    EEHUDViewHideStyleLutz = 1,
    EEHUDViewHideStyleShake = 2,
    EEHUDViewHideStyleNoAnime = 3,
    EEHUDViewHideStyleToLeft = 4,
    EEHUDViewHideStyleToRight = 5,
    EEHUDViewHideStyleToBottom = 6,
    EEHUDViewHideStyleToTop = 7
} EEHUDViewHideStyle;

@interface EEHUDView : UIWindow 

+ (void)growlWithMessage:(NSString *)message
               showStyle:(EEHUDViewShowStyle)showStyle
               hideStyle:(EEHUDViewHideStyle)hideStyle
         resultViewStyle:(EEHUDResultViewStyle)resultViewStyle
                showTime:(float)time;

+ (void)progressWithMessage:(NSString *)message
                  showStyle:(EEHUDViewShowStyle)showStyle
                  hideStyle:(EEHUDViewHideStyle)hideStyle
          progressViewStyle:(EEHUDProgressViewStyle)progressViewStyle
                   progress:(float)progress;


// HUD表示してるかどうか
+ (BOOL)isShowing;

@end
