//
//  EEData.m
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 12/06/16.
//  Copyright (c) 2012年 Milestoneeee.com. All rights reserved.
//

#import "EEData.h"

@interface EEData ()

@property (nonatomic, strong) NSArray *showInfos;
@property (nonatomic, strong) NSArray *hideInfos;
@property (nonatomic, strong) NSArray *resultInfos;

- (void)prepare;
@end

@implementation EEData
@synthesize showInfos = _showInfos;
@synthesize hideInfos = _hideInfos;
@synthesize resultInfos = _resultInfos;

- (id)init
{
    self = [super init];
    if (self) {
        
        [self prepare];
    }
    
    return self;
}

- (NSString *)stringShowStyle:(int)index
{
    if (index < [self.showInfos count]) {
        NSDictionary *info = [self.showInfos objectAtIndex:index];
        return (NSString *)[info objectForKey:@"style"];
    }else {
        return @"";
    }
}

- (NSString *)stringHideStyle:(int)index
{
    if (index < [self.hideInfos count]) {
        NSDictionary *info = [self.hideInfos objectAtIndex:index];
        return (NSString *)[info objectForKey:@"style"];
    }else {
        return @"";
    }
}

- (NSString *)stringResultStyle:(int)index
{
    if (index < [self.resultInfos count]) {
        NSDictionary *info = [self.resultInfos objectAtIndex:index];
        return (NSString *)[info objectForKey:@"style"];
    }else {
        return @"";
    }
}

- (NSString *)abbreviatedStringShowStyle:(int)index
{
    if (index < [self.showInfos count]) {
        NSDictionary *info = [self.showInfos objectAtIndex:index];
        return (NSString *)[info objectForKey:@"abbreviated"];
    }else {
        return @"";
    }
}

- (NSString *)abbreviatedStringHideStyle:(int)index
{
    if (index < [self.hideInfos count]) {
        NSDictionary *info = [self.hideInfos objectAtIndex:index];
        return (NSString *)[info objectForKey:@"abbreviated"];
    }else {
        return @"";
    }
}

- (NSString *)abbreviatedStringResultStyle:(int)index
{
    if (index < [self.resultInfos count]) {
        NSDictionary *info = [self.resultInfos objectAtIndex:index];
        return (NSString *)[info objectForKey:@"abbreviated"];
    }else {
        return @"";
    }
}

- (int)countOfShowStyle { return [self.showInfos count]; }
- (int)countOfHideStyle { return [self.hideInfos count]; }
- (int)countOfResultStyle { return [self.resultInfos count]; }

#pragma mark - Private
- (void)prepare
{
    // show
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        NSString *styleString, *abbreviatedString;
        switch (i) {
            case 0:
                abbreviatedString = @"FadeIn";
                styleString = @"EEHUDViewShowStyleFadeIn";
                break;
            case 1:
                abbreviatedString = @"Lutz";
                styleString = @"EEHUDViewShowStyleLutz";
                break;
            case 2:
                abbreviatedString = @"Shake";
                styleString = @"EEHUDViewShowStyleShake";
                break;
            case 3:
                abbreviatedString = @"No Anime";
                styleString = @"EEHUDViewShowStyleNoAnime";
                break;
            case 4:
                abbreviatedString = @"←";
                styleString = @"EEHUDViewShowStyleFromRight";
                break;
            case 5:
                abbreviatedString = @"→";
                styleString = @"EEHUDViewShowStyleFromLeft";
                break;
            case 6:
                abbreviatedString = @"↓";
                styleString = @"EEHUDViewShowStyleFromTop";
                break;
            case 7:
                abbreviatedString = @"↑";
                styleString = @"EEHUDViewShowStyleFromBottom";
                break;
            default:
                abbreviatedString = @"";
                styleString = @"";
                break;
        }
        
        NSArray *keys = [NSArray arrayWithObjects:@"style", @"abbreviated", nil];
        NSArray *objects = [NSArray arrayWithObjects:styleString, abbreviatedString, nil];
        NSDictionary *info = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [array addObject:info];
    }
    
    _showInfos = [NSArray arrayWithArray:array];
    
    // hide
    array = nil;
    array = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        NSString *styleString, *abbreviatedString;
        switch (i) {
            case 0:
                abbreviatedString = @"FadeOut";
                styleString = @"EEHUDViewHideStyleFadeOut";
                break;
            case 1:
                abbreviatedString = @"Lutz";
                styleString = @"EEHUDViewHideStyleLutz";
                break;
            case 2:
                abbreviatedString = @"Shake";
                styleString = @"EEHUDViewHideStyleShake";
                break;
            case 3:
                abbreviatedString = @"No Anime";
                styleString = @"EEHUDViewHideStyleNoAnime";
                break;
            case 4:
                abbreviatedString = @"←";
                styleString = @"EEHUDViewHideStyleToLeft";
                break;
            case 5:
                abbreviatedString = @"→";
                styleString = @"EEHUDViewHideStyleToRight";
                break;
            case 6:
                abbreviatedString = @"↑";
                styleString = @"EEHUDViewHideStyleToTop";
                break;
            case 7:
                abbreviatedString = @"↓";
                styleString = @"EEHUDViewHideStyleToBottom";
                break;
            default:
                styleString = @"";
                break;
        }
        
        NSArray *keys = [NSArray arrayWithObjects:@"style", @"abbreviated", nil];
        NSArray *objects = [NSArray arrayWithObjects:styleString, abbreviatedString, nil];
        NSDictionary *info = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [array addObject:info];
    }
    _hideInfos = [NSArray arrayWithArray:array];
    
    // result
    array = nil;
    array = [NSMutableArray array];
    for (int i = 0; i < 29; i++) {
        NSString *styleString, *abbreviatedString;
        switch (i) {
            case 0:
                abbreviatedString = @"OK";
                styleString = @"EEHUDResultViewStyleOK";
                break;
            case 1:
                abbreviatedString = @"NG";
                styleString = @"EEHUDResultViewStyleNG";
                break;
            case 2:
                abbreviatedString = @"Checked";
                styleString = @"EEHUDResultViewStyleChecked";
                break;
            case 3:
                abbreviatedString = @"↑";
                styleString = @"EEHUDResultViewStyleUpArrow";
                break;
            case 4:
                abbreviatedString = @"↓";
                styleString = @"EEHUDResultViewStyleDownArrow";
                break;
            case 5:
                abbreviatedString = @"→";
                styleString = @"EEHUDResultViewStyleRightArrow";
                break;
            case 6:
                abbreviatedString = @"←";
                styleString = @"EEHUDResultViewStyleLeftArrow";
                break;
            case 7:
                abbreviatedString = @"Play";
                styleString = @"EEHUDResultViewStylePlay";
                break;
            case 8:
                abbreviatedString = @"Pause";
                styleString = @"EEHUDResultViewStylePause";
                break;
            case 9:
                abbreviatedString = @"0";
                styleString = @"EEHUDResultViewStyleZero";
                break;
            case 10:
                abbreviatedString = @"1";
                styleString = @"EEHUDResultViewStyleOne";
                break;
            case 11:
                abbreviatedString = @"2";
                styleString = @"EEHUDResultViewStyleTwo";
                break;
            case 12:
                abbreviatedString = @"3";
                styleString = @"EEHUDResultViewStyleThree";
                break;
            case 13:
                abbreviatedString = @"4";
                styleString = @"EEHUDResultViewStyleFour";
                break;
            case 14:
                abbreviatedString = @"5";
                styleString = @"EEHUDResultViewStyleFive";
                break;
            case 15:
                abbreviatedString = @"6";
                styleString = @"EEHUDResultViewStyleSix";
                break;
            case 16:
                abbreviatedString = @"7";
                styleString = @"EEHUDResultViewStyleSeven";
                break;
            case 17:
                abbreviatedString = @"8";
                styleString = @"EEHUDResultViewStyleEight";
                break;
            case 18:
                abbreviatedString = @"9";
                styleString = @"EEHUDResultViewStyleNine";
                break;
            case 19:
                abbreviatedString = @"!";
                styleString = @"EEHUDResultViewStyleExclamation";
                break;
            case 20:
                abbreviatedString = @"Cloud";
                styleString = @"EEHUDResultViewStyleCloud";
                break;
            case 21:
                abbreviatedString = @"Cloud & ↑";
                styleString = @"EEHUDResultViewStyleCloudUp";
                break;
            case 22:
                abbreviatedString = @"Cloud & ↓";
                styleString = @"EEHUDResultViewStyleCloudDown";
                break;
            case 23:
                abbreviatedString = @"Mail";
                styleString = @"EEHUDResultViewStyleMail";
                break;
            case 24:
                abbreviatedString = @"Microphone";
                styleString = @"EEHUDResultViewStyleMicrophone";
                break;
            case 25:
                abbreviatedString = @"Location";
                styleString = @"EEHUDResultViewStyleLocation";
                break;
            case 26:
                abbreviatedString = @"Home";
                styleString = @"EEHUDResultViewStyleHome";
                break;
            case 27:
                abbreviatedString = @"Tweet";
                styleString = @"EEHUDResultViewStyleTweet";
                break;
            case 28:
                abbreviatedString = @"Clock";
                styleString = @"EEHUDResultViewStyleClock";
                break;
            default:
                abbreviatedString = @"";
                styleString = @"";
                break;
        }
        
        NSArray *keys = [NSArray arrayWithObjects:@"style", @"abbreviated", nil];
        NSArray *objects = [NSArray arrayWithObjects:styleString, abbreviatedString, nil];
        NSDictionary *info = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [array addObject:info];
    }
    _resultInfos = [NSArray arrayWithArray:array];
    
    array = nil;
}
@end
