// 
// EEProgressHUDResultView.h 
// Created by Yoshiki Kudo on 11/12/05.
//
// Copyright (c) 2012 milestoneeee.com All rights reserved.
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <UIKit/UIKit.h>

typedef enum _EEHUDResultViewStyle {
    EEHUDResultViewStyleOK = 0,
    EEHUDResultViewStyleNG = 1,
    EEHUDResultViewStyleChecked = 2,
    EEHUDResultViewStyleUpArrow = 3,
    EEHUDResultViewStyleDownArrow = 4,
    EEHUDResultViewStyleRightArrow = 5,
    EEHUDResultViewStyleLeftArrow = 6,
    EEHUDResultViewStylePlay = 7,
    EEHUDResultViewStylePause = 8,
    EEHUDResultViewStyleZero = 9,
    EEHUDResultViewStyleOne = 10,
    EEHUDResultViewStyleTwo = 11,
    EEHUDResultViewStyleThree = 12,
    EEHUDResultViewStyleFour = 13,
    EEHUDResultViewStyleFive = 14,
    EEHUDResultViewStyleSix = 15,
    EEHUDResultViewStyleSeven = 16,
    EEHUDResultViewStyleEight = 17,
    EEHUDResultViewStyleNine = 18,
    EEHUDResultViewStyleExclamation = 19,
    EEHUDResultViewStyleCloud = 20,
    EEHUDResultViewStyleCloudUp = 21,
    EEHUDResultViewStyleCloudDown = 22,
    EEHUDResultViewStyleMail = 23,
    EEHUDResultViewStyleMicrophone = 24,
    EEHUDResultViewStyleLocation = 25,
    EEHUDResultViewStyleHome = 26,
    EEHUDResultViewStyleTweet = 27,
    EEHUDResultViewStyleClock = 28
} EEHUDResultViewStyle;

typedef enum _EEHUDProgressViewStyle {
    EEHUDProgressViewStyleBar = 28
} EEHUDProgressViewStyle;

@interface EEHUDResultView : UIView {
    
    EEHUDResultViewStyle viewStyle_;
    EEHUDProgressViewStyle progressViewStyle_;
    float progress_;
}
@property (nonatomic, assign) float progress;
@property (nonatomic) EEHUDResultViewStyle viewStyle;
@property (nonatomic) EEHUDProgressViewStyle progressViewStyle;
@end
