//
//  EEProgressHUD.h
//  KJPN
//
//  Created by Kudo Yoshiki on 11/12/05.
//  Copyright (c) 2011年 Milestoneeee.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _EEProgressHUDShowStyle {
    EEProgressHUDShowStyleNone = 0,
    EEProgressHUDShowStyleFadeIn = 1,
    EEProgressHUDShowStyleLutz = 2,
    EEProgressHUDShowStyleShake = 3,
    EEProgressHUDShowStyleNoAnime = 4
} EEProgressHUDShowStyle;

typedef enum _EEProgressHUDHideStyle {
    EEProgressHUDHideStyleNone = 0,
    EEProgressHUDHideStyleFadeOut = 1,
    EEProgressHUDHideStyleLutz = 2,
    EEProgressHUDHideStyleShake = 3,
    EEProgressHUDHideStyleNoAnime = 4
} EEProgressHUDHideStyle;

typedef enum _EEProgressHUDProgressViewStyle {
    EEProgressHUDProgressViewStyleNone = 0,
    EEProgressHUDProgressViewStyleIndicator = 1
} EEProgressHUDProgressViewStyle;

typedef enum _EEProgressHUDResultViewStyle {
    EEProgressHUDResultViewStyleNone = 0,
    EEProgressHUDResultViewStyleOK = 1,
    EEProgressHUDResultViewStyleNG = 2,
    EEProgressHUDResultViewStyleChecked = 3
    
} EEProgressHUDResultViewStyle;

@interface EEProgressHUD : UIWindow {
    
    EEProgressHUDShowStyle showStyle_;
    EEProgressHUDHideStyle hideStyle_;
    EEProgressHUDProgressViewStyle progressViewStyle_;
    EEProgressHUDResultViewStyle resultViewStyle_;
    
    NSString *message_;
}

@property (nonatomic) EEProgressHUDShowStyle showStyle;
@property (nonatomic) EEProgressHUDHideStyle hideStyle;
@property (nonatomic) EEProgressHUDProgressViewStyle progressViewStyle;
@property (nonatomic) EEProgressHUDResultViewStyle resultViewStyle;

@property (nonatomic, strong) NSString *message;

+ (void)showWithMessage:(NSString *)message 
              showStyle:(EEProgressHUDShowStyle)showStyle 
      progressViewStyle:(EEProgressHUDProgressViewStyle)progressViewStyle;
+ (void)hideWithMessage:(NSString *)message
              hideStyle:(EEProgressHUDHideStyle)hideStyle
        resultViewStyle:(EEProgressHUDResultViewStyle)resultViewStyle;

@end
