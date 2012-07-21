// 
// EEProgressHUDResultView.m 
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

#import "EEHUDViewConstants.h"

@interface EEHUDCircleView : UIView
@end

@implementation EEHUDCircleView
- (void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path, NULL, width*0.5, height*0.5, width*0.5, 0.0, 2.0f*M_PI, YES);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    UIColor *color = EEHUD_COLOR_IMAGE;
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillPath(context);
}
@end

#import "EEHUDResultView.h"

@interface EEHUDResultView ()
@property (nonatomic, weak) UIView *animationView;

/***
 draw
 ***/
- (void)drawOK:(CGRect)rect;
- (void)drawNG:(CGRect)rect;
- (void)drawChecked:(CGRect)rect;
- (void)drawUpArrow:(CGRect)rect;
- (void)drawDownArrow:(CGRect)rect;
- (void)drawRightArrow:(CGRect)rect;
- (void)drawLeftArrow:(CGRect)rect;
- (void)drawPlay:(CGRect)rect;
- (void)drawPause:(CGRect)rect;
//- (void)drawZero:(CGRect)rect;
//- (void)drawOne:(CGRect)rect;
//- (void)drawTwo:(CGRect)rect;
//- (void)drawThree:(CGRect)rect;
//- (void)drawFour:(CGRect)rect;
//- (void)drawFive:(CGRect)rect;
//- (void)drawSix:(CGRect)rect;
//- (void)drawSeven:(CGRect)rect;
//- (void)drawEight:(CGRect)rect;
//- (void)drawNine:(CGRect)rect;
- (void)drawExclamation:(CGRect)rect;
- (void)drawCloud:(CGRect)rect;
- (void)drawCloudUp:(CGRect)rect;
- (void)drawCloudDown:(CGRect)rect;
- (void)drawMail:(CGRect)rect;
- (void)drawMicrophone:(CGRect)rect;
- (void)drawLocation:(CGRect)rect;
- (void)drawHome:(CGRect)rect;
- (void)drawTweet:(CGRect)rect;
- (void)drawClock:(CGRect)rect;
- (void)drawWifiFull:(CGRect)rect;
- (void)drawWifiEmpty:(CGRect)rect;
- (void)drawTurnArround:(CGRect)rect;
/*****************************************/

- (void)startAnimation;

@end

@implementation EEHUDResultView
@synthesize viewStyle = viewStyle_;
@synthesize progressViewStyle = progressViewStyle_;
@synthesize progress = progress_;
@synthesize animationView = _animationView;

- (void)setViewStyle:(EEHUDResultViewStyle)aViewStyle
{
    if (viewStyle_ != aViewStyle) {
        
        viewStyle_ = aViewStyle;
        [self setNeedsDisplay];
        
        // animation
        [self startAnimation];
    }
}

- (void)setProgress:(float)progress
{
    if (progress > 1.0) {
        progress = 1.0;
    }else if (progress < 0.0) {
        progress = 0.0;
    }
    
    progress_ = progress;
    
    [self setNeedsDisplay];
}

- (void)dealloc
{
    //NSLog(@"%s", __func__);
    [self.animationView.layer removeAllAnimations];
    [self.animationView removeFromSuperview];
    self.animationView = nil;
}

#pragma mark - Animation
- (void)startAnimation
{
    [self.animationView.layer removeAllAnimations];
    [self.animationView removeFromSuperview];
    self.animationView = nil;
    
    if (self.viewStyle == EEHUDResultViewStyleTurnAround) {
        
        CGRect rect = self.bounds;
        CGFloat width = rect.size.width;
        CGFloat height = rect.size.height;
        CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
        
        CGFloat oneSide = (width < height) ? width : height;
        CGFloat r = oneSide * 0.5;
        
        CGFloat circleR = r * 0.4;
        CGFloat size = 10.0;
        
        CGRect circleRect = CGRectZero;
        circleRect.origin = CGPointMake(center.x - size*0.5f, center.y - circleR - 2.0f - size);      // 2.0: line width
        circleRect.size = CGSizeMake(size, size);
        
        EEHUDCircleView *aView = [[EEHUDCircleView alloc] initWithFrame:circleRect];
        aView.backgroundColor = [UIColor clearColor];
        
        self.animationView = aView;
        
        [self addSubview:aView];
        
        // animation
        CAKeyframeAnimation *turn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGFloat turnArroundRadius = circleR + 2.0f + size*0.5;
        CGPathAddArc(path, NULL, center.x, center.y, turnArroundRadius, -M_PI_2, 1.5f*M_PI, YES);
        
        turn.path = path;
        CGPathRelease(path);
        
        turn.duration = 1.0;
        turn.repeatCount = HUGE_VALF;
        
        turn.calculationMode = kCAAnimationPaced;
        
        [aView.layer addAnimation:turn forKey:nil];
    }
}

#pragma mark - drawRect:
- (void)drawRect:(CGRect)rect
{
    //CGFloat width = self.bounds.size.width;             // 180
    //CGFloat height = self.bounds.size.height;           // 60
    CGFloat width = rect.size.width;                        // 151
    CGFloat height = rect.size.height;                      // 60
    
    //NSLog(@"w:%f, h:%f", width, height);
    
    // = height
    CGFloat oneSide = (width < height) ? width : height;
    
    CGPoint center = CGPointMake(width * 0.5, height * 0.5);
    CGFloat r = (oneSide * 0.5);
    
    /***********************
     (180, 60)のサイズのはず
     描画エリアは中心の(60, 60)にしてる。
        => 揃えた方が綺麗に見えるはず
     ************************/
    
    // 定義
    CGPoint hidariue, migishita, migiue, hidarishita;
    CGPoint start, relay, end;
    CGFloat innerMargin;
    CGFloat bothExpansion;
    CGFloat ueMargin, hidariMargin, migiMargin, shitaMargin;
    CGFloat theta;
    CGFloat floatOne;   // 何でも用
    
    EEHUDResultViewStyle style = self.viewStyle;
    
    UIBezierPath *path;
    switch (style) {
        case EEHUDResultViewStyleOK:
            [self drawOK:rect];
            
            break;
        case EEHUDResultViewStyleNG:
            [self drawNG:rect];
            
            break;
        case EEHUDResultViewStyleChecked:
            [self drawChecked:rect];
                        
            break;
        case EEHUDResultViewStyleUpArrow:
            [self drawUpArrow:rect];
            
            break;
        case EEHUDResultViewStyleDownArrow:
            [self drawDownArrow:rect];
            
            break;
        case EEHUDResultViewStyleRightArrow:
            [self drawRightArrow:rect];
            
            break;
        case EEHUDResultViewStyleLeftArrow:
            [self drawLeftArrow:rect];
            
            break;
        case EEHUDResultViewStylePlay:
            [self drawPlay:rect];
            
            break;
        case EEHUDResultViewStylePause:
            [self drawPause:rect];
            
            break;
        case EEHUDResultViewStyleZero:
            
            innerMargin = 12.0;
            hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
            
            [EEHUD_COLOR_IMAGE set];
            
            [@"0" drawAtPoint:CGPointMake(hidariue.x + 4.0, hidariue.y - 17.0)
                     withFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0]];
            
            break;
            
        case EEHUDResultViewStyleOne:
            
            innerMargin = 12.0;
            hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
            
            [EEHUD_COLOR_IMAGE set];
            
            [@"1" drawAtPoint:CGPointMake(hidariue.x + 4.0, hidariue.y - 17.0)
                     withFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0]];
            
            break;
            
        case EEHUDResultViewStyleTwo:
            
            innerMargin = 12.0;
            hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
            
            [EEHUD_COLOR_IMAGE set];
            
            [@"2" drawAtPoint:CGPointMake(hidariue.x + 4.0, hidariue.y - 17.0)
                     withFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0]];
            
            break;
            
        case EEHUDResultViewStyleThree:
            
            innerMargin = 12.0;
            hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
            
            [EEHUD_COLOR_IMAGE set];
            
            [@"3" drawAtPoint:CGPointMake(hidariue.x + 4.0, hidariue.y - 17.0)
                     withFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0]];
            
            break;
            
        case EEHUDResultViewStyleFour:
            
            innerMargin = 12.0;
            hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
            
            [EEHUD_COLOR_IMAGE set];
            
            [@"4" drawAtPoint:CGPointMake(hidariue.x + 4.0, hidariue.y - 17.0)
                     withFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0]];
            
            break;
            
        case EEHUDResultViewStyleFive:
            
            innerMargin = 12.0;
            hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
            
            [EEHUD_COLOR_IMAGE set];
            
            [@"5" drawAtPoint:CGPointMake(hidariue.x + 4.0, hidariue.y - 17.0)
                     withFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0]];
            
            break;
            
        case EEHUDResultViewStyleSix:
            
            innerMargin = 12.0;
            hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
            
            [EEHUD_COLOR_IMAGE set];
            
            [@"6" drawAtPoint:CGPointMake(hidariue.x + 4.0, hidariue.y - 17.0)
                     withFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0]];
            
            break;
            
        case EEHUDResultViewStyleSeven:
            
            innerMargin = 12.0;
            hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
            
            [EEHUD_COLOR_IMAGE set];
            
            [@"7" drawAtPoint:CGPointMake(hidariue.x + 4.0, hidariue.y - 17.0)
                     withFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0]];
            
            break;
            
        case EEHUDResultViewStyleEight:
            
            innerMargin = 12.0;
            hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
            
            [EEHUD_COLOR_IMAGE set];
            
            [@"8" drawAtPoint:CGPointMake(hidariue.x + 4.0, hidariue.y - 17.0)
                     withFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0]];
            
            break;
            
        case EEHUDResultViewStyleNine:
            
            innerMargin = 12.0;
            hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
            
            [EEHUD_COLOR_IMAGE set];
            
            [@"9" drawAtPoint:CGPointMake(hidariue.x + 4.0, hidariue.y - 17.0)
                     withFont:[UIFont fontWithName:@"Helvetica-Bold" size:60.0]];
            
            break;
            
        case EEHUDResultViewStyleExclamation:
            [self drawExclamation:rect];
            
            break;
        case EEHUDResultViewStyleCloud:
            [self drawCloud:rect];
            
            break;
        case EEHUDResultViewStyleCloudUp:
            [self drawCloudUp:rect];
            
            break;
        case EEHUDResultViewStyleCloudDown:
            [self drawCloudDown:rect];
            
            break;
        case EEHUDResultViewStyleMail:
            [self drawMail:rect];
            
            break;
        case EEHUDResultViewStyleMicrophone:
            [self drawMicrophone:rect];
            
            break;
        case EEHUDResultViewStyleLocation:
            [self drawLocation:rect];
            
            break;
        case EEHUDResultViewStyleHome:
            [self drawHome:rect];
            
            break;
        case EEHUDResultViewStyleTweet:
            [self drawTweet:rect];
        
            break;
        case EEHUDResultViewStyleClock:
            [self drawClock:rect];
            
            break;
        case EEHUDResultViewStyleWifiFull:
            [self drawWifiFull:rect];
            
            break;
        case EEHUDResultViewStyleWifiEmpty:
            [self drawWifiEmpty:rect];
            
            break;
        case EEHUDResultViewStyleTurnAround:
            [self drawTurnArround:rect];
            
            break;
        default:
            
            /*********************
             progress
            *********************/
             
            switch (self.progressViewStyle) {
                case EEHUDProgressViewStyleBar:
                    
                    ueMargin = 27.0;
                    hidariMargin = -27.0;
                    migiMargin = -27.0;
                    shitaMargin = 25.0;
                    
                    hidariue = CGPointMake(center.x - r + hidariMargin, center.y - r + ueMargin);
                    migiue = CGPointMake(center.x + r - migiMargin, center.y - r + ueMargin);
                    migishita = CGPointMake(center.x + r - migiMargin, center.y + r - shitaMargin);
                    hidarishita = CGPointMake(center.x - r + hidariMargin, center.y + r - shitaMargin);
                    
                    floatOne = (hidarishita.y - hidariue.y)*0.5;
                    center = CGPointMake((migiue.x + hidariue.x)/2.0, (hidarishita.y + hidariue.y)/2.0);
                    
                    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(migiue.x - 2.0*floatOne, center.y)
                                                          radius:floatOne*2.0
                                                      startAngle:M_PI_2*3.2
                                                        endAngle:M_PI_2*0.8
                                                       clockwise:YES];
                    
                    path.lineWidth = 2.0;
                    path.lineCapStyle = kCGLineJoinRound;
                    
                    [EEHUD_COLOR_IMAGE set];
                    [path stroke];
                    
                    path = nil;
                    path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(hidariue.x + floatOne,
                                                                              hidariue.y,
                                                                              (migiue.x - hidariue.x - 2.0*floatOne)*self.progress, 
                                                                              migishita.y - migiue.y)
                                                      cornerRadius:floatOne];
                    
                    [EEHUD_COLOR_IMAGE set];
                    [path fill];
                    
                    break;
                    
                default:
                    break;
            }
            
            break;
    }
    
    
    
}

#pragma mark - Draw
- (void)drawOK:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat circleR = r * 0.7;
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path, NULL, center.x, center.y, circleR, 0.0, 2*M_PI, YES);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 8.0);
    
    CGContextStrokePath(context);
}

- (void)drawNG:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 12.0;
    CGPoint hidariue = CGPointMake(center.x - r + innerMargin, center.y - r + innerMargin);
    CGPoint hidarishita = CGPointMake(center.x - r + innerMargin, center.y + r - innerMargin);
    CGPoint migiue = CGPointMake(center.x + r - innerMargin, center.y - r + innerMargin);
    CGPoint migishita = CGPointMake(center.x + r - innerMargin, center.y + r - innerMargin);
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, hidariue.x, hidariue.y);
    CGPathAddLineToPoint(path, NULL, migishita.x, migishita.y);
    CGPathMoveToPoint(path, NULL, migiue.x, migiue.y);
    CGPathAddLineToPoint(path, NULL, hidarishita.x, hidarishita.y);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 8.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextStrokePath(context);
}

- (void)drawChecked:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 12.0;
    CGPoint start = CGPointMake(center.x - r + innerMargin, center.y);
    CGPoint relay = CGPointMake(center.x - 0.2*r, center.y + r - innerMargin);
    CGPoint migiue = CGPointMake(center.x + r*1.2 - innerMargin, center.y - r + innerMargin);
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL, relay.x, relay.y);
    CGPathAddLineToPoint(path, NULL, migiue.x, migiue.y);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 8.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    UIColor *color = EEHUD_COLOR_IMAGE;
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    
    CGContextStrokePath(context);
}

- (void)drawUpArrow:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 12.0;
    CGPoint start = CGPointMake(center.x - 0.8*(r-innerMargin), center.y - 0.2*(r-innerMargin));
    CGPoint relay = CGPointMake(center.x, center.y - (r-innerMargin));
    CGPoint end = CGPointMake(center.x + 0.8*(r-innerMargin), center.y - 0.2*(r-innerMargin));
    CGPoint bottom = CGPointMake(center.x, center.y + (r-innerMargin));
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL, relay.x, relay.y);
    CGPathAddLineToPoint(path, NULL, end.x, end.y);
    CGPathMoveToPoint(path, NULL, relay.x, relay.y);
    CGPathAddLineToPoint(path, NULL, bottom.x, bottom.y);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 8.0);
    CGContextSetLineJoin(context, kCGLineCapRound);
    
    UIColor *color = EEHUD_COLOR_IMAGE;
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    
    CGContextStrokePath(context);
}

- (void)drawDownArrow:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 12.0;
    CGPoint start = CGPointMake(center.x - 0.8*(r-innerMargin), center.y + 0.2*(r-innerMargin));
    CGPoint relay = CGPointMake(center.x, center.y + (r-innerMargin));
    CGPoint end = CGPointMake(center.x + 0.8*(r-innerMargin), center.y + 0.2*(r-innerMargin));
    CGPoint up = CGPointMake(center.x, center.y - (r-innerMargin));
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL, relay.x, relay.y);
    CGPathAddLineToPoint(path, NULL, end.x, end.y);
    CGPathMoveToPoint(path, NULL, relay.x, relay.y);
    CGPathAddLineToPoint(path, NULL, up.x, up.y);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 8.0);
    CGContextSetLineJoin(context, kCGLineCapRound);
    
    UIColor *color = EEHUD_COLOR_IMAGE;
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    
    CGContextStrokePath(context);
}

- (void)drawRightArrow:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 12.0;
    CGPoint start = CGPointMake(center.x + 0.2*(r-innerMargin), center.y - 0.8*(r-innerMargin));
    CGPoint relay = CGPointMake(center.x + (r-innerMargin), center.y);
    CGPoint end = CGPointMake(center.x + 0.2*(r-innerMargin), center.y + 0.8*(r-innerMargin));
    CGPoint left = CGPointMake(center.x - (r-innerMargin), center.y);
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL, relay.x, relay.y);
    CGPathAddLineToPoint(path, NULL, end.x, end.y);
    CGPathMoveToPoint(path, NULL, relay.x, relay.y);
    CGPathAddLineToPoint(path, NULL, left.x, left.y);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 8.0);
    CGContextSetLineJoin(context, kCGLineCapRound);
    
    UIColor *color = EEHUD_COLOR_IMAGE;
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    
    CGContextStrokePath(context);
}

- (void)drawLeftArrow:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 12.0;
    CGPoint start = CGPointMake(center.x - 0.2*(r-innerMargin), center.y - 0.8*(r-innerMargin));
    CGPoint relay = CGPointMake(center.x - (r-innerMargin), center.y);
    CGPoint end = CGPointMake(center.x - 0.2*(r-innerMargin), center.y + 0.8*(r-innerMargin));
    CGPoint right = CGPointMake(center.x + (r-innerMargin), center.y);
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL, relay.x, relay.y);
    CGPathAddLineToPoint(path, NULL, end.x, end.y);
    CGPathMoveToPoint(path, NULL, relay.x, relay.y);
    CGPathAddLineToPoint(path, NULL, right.x, right.y);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 8.0);
    CGContextSetLineJoin(context, kCGLineCapRound);
    
    UIColor *color = EEHUD_COLOR_IMAGE;
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    
    CGContextStrokePath(context);
}

- (void)drawPlay:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 12.0;
    CGPoint start = CGPointMake(center.x + r - innerMargin, center.y);
    CGPoint relay = CGPointMake(center.x - r + r*(2.0-sqrt(3.0))/2 + innerMargin, center.y + r - innerMargin);
    CGPoint end = CGPointMake(center.x - r + r*(2.0-sqrt(3.0))/2 + innerMargin , center.y - r + innerMargin);
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddLineToPoint(path, NULL, relay.x, relay.y);
    CGPathAddLineToPoint(path, NULL, end.x, end.y);
    
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 8.0);
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    
    UIColor *color = EEHUD_COLOR_IMAGE;
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillPath(context);
}

- (void)drawPause:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat cornerR = 2.0;
    CGFloat lineLength = 35.0;
    CGFloat lineWidth = 7.0;
    
    CGFloat lengthHalf = lineLength * 0.5;
    CGFloat widthHalf = lineWidth * 0.5;
    
    CGFloat innerMargin = 15.0;
    CGPoint left = CGPointMake(center.x - r + innerMargin, center.y - lengthHalf);
    CGPoint right = CGPointMake(center.x + r - innerMargin, center.y - lengthHalf);
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    
    
    CGPathMoveToPoint(path, NULL, left.x - widthHalf, left.y - cornerR);
    CGPathAddArc(path, NULL, left.x - widthHalf, left.y, cornerR, 3.0*M_PI_2, M_PI, YES);
    CGPathAddLineToPoint(path, NULL, left.x - widthHalf - cornerR, left.y + lineLength);
    CGPathAddArc(path, NULL, left.x - widthHalf, left.y + lineLength, cornerR, M_PI, M_PI_2, YES);
    CGPathAddLineToPoint(path, NULL, left.x + widthHalf, left.y + lineLength + cornerR);
    CGPathAddArc(path, NULL, left.x + widthHalf, left.y + lineLength, cornerR, M_PI_2, 0.0, YES);
    CGPathAddLineToPoint(path, NULL, left.x + widthHalf + cornerR, left.y);
    CGPathAddArc(path, NULL, left.x + widthHalf, left.y, cornerR, 0.0, 3.0*M_PI_2, YES);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, right.x - widthHalf, right.y - cornerR);
    CGPathAddArc(path, NULL, right.x - widthHalf, right.y, cornerR, 3.0*M_PI_2, M_PI, YES);
    CGPathAddLineToPoint(path, NULL, right.x - widthHalf - cornerR, right.y + lineLength);
    CGPathAddArc(path, NULL, right.x - widthHalf, right.y + lineLength, cornerR, M_PI, M_PI_2, YES);
    CGPathAddLineToPoint(path, NULL, right.x + widthHalf, right.y + lineLength + cornerR);
    CGPathAddArc(path, NULL, right.x + widthHalf, right.y + lineLength, cornerR, M_PI_2, 0.0, YES);
    CGPathAddLineToPoint(path, NULL, right.x + widthHalf + cornerR, right.y);
    CGPathAddArc(path, NULL, right.x + widthHalf, right.y, cornerR, 0.0, 3.0*M_PI_2, YES);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    UIColor *color = EEHUD_COLOR_IMAGE;
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillPath(context);
}

- (void)drawExclamation:(CGRect)rect
{
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(71, 46, 8, 8)];
    [[UIColor whiteColor] setFill];
    [ovalPath fill];
    
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(75, 40)];
    [bezierPath addCurveToPoint: CGPointMake(70, 9.67) controlPoint1: CGPointMake(70, 40) controlPoint2: CGPointMake(70, 14.67)];
    [bezierPath addCurveToPoint: CGPointMake(75, 5) controlPoint1: CGPointMake(70, 9.67) controlPoint2: CGPointMake(70.5, 5)];
    [bezierPath addCurveToPoint: CGPointMake(80, 9.67) controlPoint1: CGPointMake(79.5, 5) controlPoint2: CGPointMake(80, 9.67)];
    [bezierPath addCurveToPoint: CGPointMake(75, 40) controlPoint1: CGPointMake(80, 14.67) controlPoint2: CGPointMake(80, 40)];
    [bezierPath closePath];
    [[UIColor whiteColor] setFill];
    [bezierPath fill];
    
}

- (void)drawCloud:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 2.0;
    CGFloat bothExpansion = 12.0;
    CGPoint hidarishita = CGPointMake(center.x - r + innerMargin - bothExpansion, center.y + r - innerMargin);
    CGPoint migishita = CGPointMake(center.x + r - innerMargin + bothExpansion, center.y + r - innerMargin);
    /*********************************************************************************/
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // cloud
    [path moveToPoint:CGPointMake(hidarishita.x + 5.0, hidarishita.y)];
    [path addCurveToPoint:CGPointMake(hidarishita.x + 15.0, hidarishita.y - 24.0)
            controlPoint1:CGPointMake(hidarishita.x - 8.0, hidarishita.y - 13.0)
            controlPoint2:CGPointMake(hidarishita.x + 5.0, hidarishita.y - 30.0)];
    [path addCurveToPoint:CGPointMake(hidarishita.x + 35.0, hidarishita.y - 30.0)
            controlPoint1:CGPointMake(hidarishita.x + 12.0, hidarishita.y - 40.0) 
            controlPoint2:CGPointMake(hidarishita.x + 31.0, hidarishita.y - 44.0)];
    [path addCurveToPoint:CGPointMake(hidarishita.x + 67.0, hidarishita.y - 8.0)
            controlPoint1:CGPointMake(hidarishita.x + 50.0, hidarishita.y - 70.0)
            controlPoint2:CGPointMake(hidarishita.x + 95.0, hidarishita.y - 28.0)];
    [path addCurveToPoint:CGPointMake(migishita.x - 5.0, migishita.y)
            controlPoint1:CGPointMake(hidarishita.x + 70.0, hidarishita.y - 15.0)
            controlPoint2:CGPointMake(migishita.x + 5.0, migishita.y - 10.0)];
    [path closePath];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineWidth = 3.0;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [EEHUD_COLOR_IMAGE set];
    [path stroke];
}

- (void)drawCloudUp:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 2.0;
    CGFloat bothExpansion = 12.0;
    CGPoint hidarishita = hidarishita = CGPointMake(center.x - r + innerMargin - bothExpansion, center.y + r - innerMargin);
    CGPoint migishita = CGPointMake(center.x + r - innerMargin + bothExpansion, center.y + r - innerMargin);
    /*********************************************************************************/
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // cloud
    [path moveToPoint:CGPointMake(hidarishita.x + 5.0, hidarishita.y)];
    [path addCurveToPoint:CGPointMake(hidarishita.x + 15.0, hidarishita.y - 24.0)
            controlPoint1:CGPointMake(hidarishita.x - 8.0, hidarishita.y - 13.0)
            controlPoint2:CGPointMake(hidarishita.x + 5.0, hidarishita.y - 30.0)];
    [path addCurveToPoint:CGPointMake(hidarishita.x + 35.0, hidarishita.y - 30.0)
            controlPoint1:CGPointMake(hidarishita.x + 12.0, hidarishita.y - 40.0) 
            controlPoint2:CGPointMake(hidarishita.x + 31.0, hidarishita.y - 44.0)];
    [path addCurveToPoint:CGPointMake(hidarishita.x + 67.0, hidarishita.y - 8.0)
            controlPoint1:CGPointMake(hidarishita.x + 50.0, hidarishita.y - 70.0)
            controlPoint2:CGPointMake(hidarishita.x + 95.0, hidarishita.y - 28.0)];
    [path addCurveToPoint:CGPointMake(migishita.x - 5.0, migishita.y)
            controlPoint1:CGPointMake(hidarishita.x + 70.0, hidarishita.y - 15.0)
            controlPoint2:CGPointMake(migishita.x + 5.0, migishita.y - 10.0)];
    [path closePath];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineWidth = 3.0;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [EEHUD_COLOR_IMAGE set];
    [path stroke];
    
    [path removeAllPoints];
    
    // UP

    CGFloat triangleHeight = 10.0;
    CGFloat triangleFloat = 5.0;
    [path moveToPoint:CGPointMake(center.x - triangleHeight, center.y + r - innerMargin - triangleFloat)];
    [path addLineToPoint:CGPointMake(center.x, center.y + r - innerMargin - triangleHeight - triangleFloat)];
    [path addLineToPoint:CGPointMake(center.x + triangleHeight, center.y + r - innerMargin - triangleFloat)];
    [path closePath];
    
    [path stroke];
}

- (void)drawCloudDown:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 2.0;
    CGFloat bothExpansion = 12.0;
    CGPoint hidarishita = hidarishita = CGPointMake(center.x - r + innerMargin - bothExpansion, center.y + r - innerMargin);
    CGPoint migishita = CGPointMake(center.x + r - innerMargin + bothExpansion, center.y + r - innerMargin);
    /*********************************************************************************/
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // cloud
    [path moveToPoint:CGPointMake(hidarishita.x + 5.0, hidarishita.y)];
    [path addCurveToPoint:CGPointMake(hidarishita.x + 15.0, hidarishita.y - 24.0)
            controlPoint1:CGPointMake(hidarishita.x - 8.0, hidarishita.y - 13.0)
            controlPoint2:CGPointMake(hidarishita.x + 5.0, hidarishita.y - 30.0)];
    [path addCurveToPoint:CGPointMake(hidarishita.x + 35.0, hidarishita.y - 30.0)
            controlPoint1:CGPointMake(hidarishita.x + 12.0, hidarishita.y - 40.0) 
            controlPoint2:CGPointMake(hidarishita.x + 31.0, hidarishita.y - 44.0)];
    [path addCurveToPoint:CGPointMake(hidarishita.x + 67.0, hidarishita.y - 8.0)
            controlPoint1:CGPointMake(hidarishita.x + 50.0, hidarishita.y - 70.0)
            controlPoint2:CGPointMake(hidarishita.x + 95.0, hidarishita.y - 28.0)];
    [path addCurveToPoint:CGPointMake(migishita.x - 5.0, migishita.y)
            controlPoint1:CGPointMake(hidarishita.x + 70.0, hidarishita.y - 15.0)
            controlPoint2:CGPointMake(migishita.x + 5.0, migishita.y - 10.0)];
    [path closePath];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineWidth = 3.0;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [EEHUD_COLOR_IMAGE set];
    [path stroke];
    
    [path removeAllPoints];
    
    // DOWN
    CGFloat triangleHeight = 10.0;
    [path moveToPoint:CGPointMake(center.x - triangleHeight, center.y + r - innerMargin - triangleHeight)];
    [path addLineToPoint:CGPointMake(center.x + triangleHeight, center.y + r - innerMargin - triangleHeight)];
    [path addLineToPoint:CGPointMake(center.x, center.y + r - innerMargin)];
    [path closePath];
    
    [path stroke];
}

- (void)drawMail:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat innerMargin = 11.0;
    CGFloat bothExpansion = 10.0;
    CGPoint hidariue = CGPointMake(center.x - r + innerMargin - bothExpansion, center.y - r + innerMargin);
    CGPoint migishita = CGPointMake(center.x + r - innerMargin + bothExpansion, center.y + r - innerMargin);
    CGPoint migiue = CGPointMake(center.x + r - innerMargin + bothExpansion, center.y - r + innerMargin);
    CGPoint hidarishita = CGPointMake(center.x - r + innerMargin - bothExpansion, center.y + r - innerMargin);
    /*********************************************************************************/
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:hidariue];
    [path addLineToPoint:migiue];
    [path addLineToPoint:migishita];
    [path addLineToPoint:hidarishita];
    [path addLineToPoint:hidariue];
    [path moveToPoint:CGPointMake(hidariue.x, hidariue.y + 5.0)];
    [path addLineToPoint:CGPointMake(center.x, hidarishita.y - 10.0)];
    [path addLineToPoint:CGPointMake(migiue.x, migiue.y + 5.0)];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 4.0;
    
    [EEHUD_COLOR_IMAGE set];
    [path stroke];
}

- (void)drawMicrophone:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat ueMargin = 2.0;
    CGFloat hidariMargin = 7.0;
    //CGFloat migiMargin = 7.0;
    CGFloat shitaMargin = 0.0;
    
    CGPoint hidariue = CGPointMake(center.x - r + hidariMargin, center.y - r + ueMargin);
    CGPoint hidarishita = CGPointMake(center.x - r + hidariMargin, center.y + r - shitaMargin);
    /*********************************************************************************/
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(center.x - 7.0, hidariue.y + 10.0)];
    [path addArcWithCenter:CGPointMake(center.x, hidariue.y + 10.0)
                    radius:7.0
                startAngle:M_PI
                  endAngle:0.0
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(center.x + 7.0, center.y - 4.0)];
    [path addArcWithCenter:CGPointMake(center.x, center.y + 7.0 - 4.0)
                    radius:7.0
                startAngle:0.0
                  endAngle:M_PI
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(center.x - 7.0, hidariue.y + 10.0)];
    [path closePath];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineWidth = 3.0;
    
    [EEHUD_COLOR_IMAGE set];
    [path fill];
    
    // 
    path = nil;
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(center.x + 7.0 + 5.0, center.y - 4.0 - 1.0)];
    [path addLineToPoint:CGPointMake(center.x + 7.0 + 5.0, center.y - 4.0)];
    [path addArcWithCenter:CGPointMake(center.x, center.y + 7.0 - 4.0)
                    radius:12.0
                startAngle:0.0
                  endAngle:M_PI
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(center.x - 7.0 - 5.0, center.y - 4.0 - 1.0)];
    
    [path moveToPoint:CGPointMake(center.x, center.y + 7.0 - 4.0 + 12.0)];
    [path addLineToPoint:CGPointMake(center.x, hidarishita.y - 3.0)];
    [path moveToPoint:CGPointMake(center.x - 7.0, hidarishita.y - 3.0)];
    [path addLineToPoint:CGPointMake(center.x + 7.0, hidarishita.y - 3.0)];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineWidth = 4.0;
    
    [EEHUD_COLOR_IMAGE set];
    [path stroke];
}

- (void)drawLocation:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat ueMargin = 2.0;
    CGFloat hidariMargin = 5.0;
    //CGFloat migiMargin = 5.0;
    CGFloat shitaMargin = -4.0;
    
    CGPoint hidariue = CGPointMake(center.x - r + hidariMargin, center.y - r + ueMargin);
    //CGPoint migiue = CGPointMake(center.x + r - migiMargin, center.y - r + ueMargin);
    CGPoint hidarishita = CGPointMake(center.x - r + hidariMargin, center.y + r - shitaMargin);
    //CGPoint migishita = CGPointMake(center.x + r - migiMargin, center.y + r - shitaMargin);
    /*********************************************************************************/
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(center.x - 2, hidarishita.y - 7)];
    [path addLineToPoint:CGPointMake(center.x, hidarishita.y - 5)];
    [path addLineToPoint:CGPointMake(center.x + 2, hidarishita.y - 7)];
    [path addLineToPoint:CGPointMake(center.x + 20.0, hidariue.y + 24.0)];
    [path addArcWithCenter:CGPointMake(center.x, hidariue.y + 20.0)
                    radius:(sqrt(416))
                startAngle:atan(5.0/20.0)
                  endAngle:(M_PI - atan(5.0/20.0))
                 clockwise:NO];
    [path closePath];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 4.0;
    
    [path addArcWithCenter:CGPointMake(center.x, center.y - 9.0)
                    radius:9.0
                startAngle:0.0
                  endAngle:1.999999*M_PI
                 clockwise:YES];
    
    [EEHUD_COLOR_IMAGE set];
    [path fill];
}

- (void)drawHome:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat ueMargin = 5.0;
    CGFloat hidariMargin = -5.0;
    CGFloat migiMargin = -5.0;
    CGFloat shitaMargin = 0.0;
    
    CGPoint hidariue = CGPointMake(center.x - r + hidariMargin, center.y - r + ueMargin);
    CGPoint migiue = CGPointMake(center.x + r - migiMargin, center.y - r + ueMargin);
    CGPoint migishita = CGPointMake(center.x + r - migiMargin, center.y + r - shitaMargin);
    CGPoint hidarishita = CGPointMake(center.x - r + hidariMargin, center.y + r - shitaMargin);
    
    CGFloat theta = atan((center.y + 2.0 - hidariue.y)/(center.x - hidariue.x));
    /*********************************************************************************/
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(center.x, hidariue.y)];
    [path addLineToPoint:CGPointMake(hidariue.x, center.y + 2.0)];
    [path addCurveToPoint:CGPointMake(hidariue.x + 9.0*sin(theta) + 9.0*2.0*cos(theta), center.y + 2.0 + 9.0*cos(theta) - 2.0*9.0*sin(theta))
            controlPoint1:CGPointMake(hidariue.x + 9.0*sin(theta), center.y + 2.0 + 9.0*cos(theta))
            controlPoint2:CGPointMake(hidariue.x + 9.0*sin(theta) + 9.0*cos(theta), center.y + 2.0 + 9.0*cos(theta) - 9.0*sin(theta))];
    [path addLineToPoint:CGPointMake(center.x, hidariue.y + 9.0/cos(atan((center.y + 2.0 - hidariue.y)/(center.x - hidariue.x))))];
    [path addLineToPoint:CGPointMake(migiue.x - 9.0*sin(theta) - 9.0*2.0*cos(theta), center.y + 2.0 + 9.0*cos(theta) - 2.0*9.0*sin(theta))];
    [path addCurveToPoint:CGPointMake(migiue.x, center.y + 2.0)
            controlPoint1:CGPointMake(migiue.x - 9.0*sin(theta) - 9.0*cos(theta), center.y + 2.0 + 9.0*cos(theta) - 9.0*sin(theta))
            controlPoint2:CGPointMake(migiue.x - 9.0*sin(theta), center.y + 2.0 + 9.0*cos(theta))];
    [path closePath];
    
    path.lineWidth = 1.0;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    [EEHUD_COLOR_IMAGE set];
    [path fill];
    
    path = nil;
    path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(center.x - 10.0, hidarishita.y)];
    [path addLineToPoint:CGPointMake(center.x - 10.0, hidarishita.y - 5.0)];
    [path addArcWithCenter:CGPointMake(center.x, hidarishita.y - 5.0)
                    radius:10.0
                startAngle:M_PI
                  endAngle:0.0
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(center.x + 10.0, migishita.y)];
    [path addLineToPoint:CGPointMake(center.x + 20.0, migishita.y)];
    [path addLineToPoint:CGPointMake(center.x + 20.0, migishita.y - 20.0)];
    [path addLineToPoint:CGPointMake(center.x, migishita.y - 20.0 - (20.0*tan(theta)))];
    [path addLineToPoint:CGPointMake(center.x - 20.0, hidarishita.y - 20.0)];
    [path addLineToPoint:CGPointMake(center.x - 20.0, hidarishita.y)];
    [path closePath];
    
    path.lineWidth = 4.0;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [EEHUD_COLOR_IMAGE set];
    [path fill];
}

- (void)drawTweet:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat ueMargin = 5.0;
    CGFloat hidariMargin = -5.0;
    CGFloat migiMargin = -5.0;
    CGFloat shitaMargin = 0.0;
    
    CGPoint hidariue = CGPointMake(center.x - r + hidariMargin, center.y - r + ueMargin);
    CGPoint migiue = CGPointMake(center.x + r - migiMargin, center.y - r + ueMargin);
    //CGPoint migishita = CGPointMake(center.x + r - migiMargin, center.y + r - shitaMargin);
    CGPoint hidarishita = CGPointMake(center.x - r + hidariMargin, center.y + r - shitaMargin);
    /*********************************************************************************/
    
    UIBezierPath *path;
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(hidariue.x, 
                                                             hidariue.y, 
                                                             migiue.x - hidariue.x, 
                                                             hidarishita.y - hidariue.y - 8.0)];
    
    [path addArcWithCenter:CGPointMake(center.x - 15.0, center.y)
                    radius:4.0
                startAngle:0.0
                  endAngle:1.999999*M_PI
                 clockwise:YES];
    [path closePath];
    
    [path addArcWithCenter:CGPointMake(center.x - 0.0, center.y)
                    radius:4.0
                startAngle:0.0
                  endAngle:1.999999*M_PI
                 clockwise:YES];
    [path closePath];
    
    [path addArcWithCenter:CGPointMake(center.x + 15.0, center.y)
                    radius:4.0
                startAngle:0.0
                  endAngle:1.999999*M_PI
                 clockwise:YES];
    [path closePath];
    
    path.usesEvenOddFillRule = YES;
    [EEHUD_COLOR_IMAGE set];
    [path fill];
    
    path = nil;
    path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(hidarishita.x + 10.0, hidarishita.y - 15.0)];
    [path addQuadCurveToPoint:CGPointMake(hidarishita.x + 15.0, hidarishita.y)
                 controlPoint:CGPointMake(hidarishita.x + 20.0, hidarishita.y - 10.0)];
    [path addLineToPoint:CGPointMake(hidarishita.x + 40.0, hidarishita.y - 10.0)];
    [path closePath];
    
    [EEHUD_COLOR_IMAGE set];
    [path fill];
}

- (void)drawClock:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat ueMargin = 5.0;
    CGFloat hidariMargin = 5.0;
    CGFloat migiMargin = 5.0;
    CGFloat shitaMargin = 5.0;
    
    CGPoint hidariue = CGPointMake(center.x - r + hidariMargin, center.y - r + ueMargin);
    CGPoint migiue = CGPointMake(center.x + r - migiMargin, center.y - r + ueMargin);
    CGPoint hidarishita = CGPointMake(center.x - r + hidariMargin, center.y + r - shitaMargin);
    /*********************************************************************************/
    
    UIBezierPath *path;
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(hidariue.x, hidariue.y, (migiue.x - hidariue.x), hidarishita.y - hidariue.y)];
    
    path.lineWidth = 4.0;
    [EEHUD_COLOR_IMAGE set];
    [path stroke];
    
    path = nil;
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(center.x, center.y - 11.0)];
    [path addLineToPoint:center];
    [path addLineToPoint:CGPointMake(center.x + 11.0, center.y)];
    
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    
    [EEHUD_COLOR_IMAGE set];
    [path stroke];
}

- (void)drawWifiFull:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat ueMargin = 5.0;
    CGFloat shitaMargin = 5.0;
    
    CGPoint shita = CGPointMake(center.x, center.y + r - shitaMargin);
    CGFloat realHeight = 2.0f*r - ueMargin - shitaMargin;
    
    CGFloat theta = -M_PI_2;
    CGFloat coordinateTheta = (-M_PI - theta)*0.5;
    CGFloat lineWidth = 13.0;
    CGFloat lineSpace = (realHeight - 3.0f * lineWidth) * 0.5;
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGAffineTransform toGenten = CGAffineTransformMakeTranslation(shita.x, shita.y);
    CGAffineTransform rotate = CGAffineTransformRotate(toGenten, coordinateTheta);

    CGPathMoveToPoint(path, &rotate, 0.0, 0.0);
    CGPathAddLineToPoint(path, &rotate, lineWidth, 0.0);
    CGPathAddArc(path, &rotate, 0.0, 0.0, lineWidth, 0.0, theta, YES);
    CGPathCloseSubpath(path);
    
    CGPathMoveToPoint(path, &rotate, lineWidth + lineSpace, 0.0);
    CGPathAddLineToPoint(path, &rotate, 2.0f*lineWidth + lineSpace, 0.0);
    CGPathAddArc(path, &rotate, 0.0f, 0.0f, 2.0f*lineWidth + lineSpace, 0.0, theta, YES);
    CGPathAddLineToPoint(path, &rotate, 0.0, - (lineWidth + lineSpace));
    CGPathAddArc(path, &rotate, 0.0f, 0.0f, lineWidth + lineSpace, theta, 0.0, NO);
    CGPathCloseSubpath(path);
    
    CGPathMoveToPoint(path, &rotate, 2.0f*lineWidth + 2.0f*lineSpace, 0.0f);
    CGPathAddLineToPoint(path, &rotate, 3.0f*lineWidth + 2.0f*lineSpace, 0.0f);
    CGPathAddArc(path, &rotate, 0.0, 0.0, 3.0f*lineWidth + 2.0f*lineSpace, 0.0, theta, YES);
    CGPathAddLineToPoint(path, &rotate, 0.0, - (2.0f*lineWidth + 2.0f*lineSpace));
    CGPathAddArc(path, &rotate, 0.0f, 0.0f, 2.0f*lineWidth + 2.0f*lineSpace, theta, 0.0, NO); 
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    UIColor *color = EEHUD_COLOR_IMAGE;
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillPath(context);
}

- (void)drawWifiEmpty:(CGRect)rect
{
    /** definition *******************************************************************/
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
    
    CGFloat oneSide = (width < height) ? width : height;
    CGFloat r = oneSide * 0.5;
    
    CGFloat ueMargin = 5.0;
    CGFloat shitaMargin = 5.0;
    
    CGPoint shita = CGPointMake(center.x, center.y + r - shitaMargin);
    CGFloat realHeight = 2.0f*r - ueMargin - shitaMargin;
    
    CGFloat theta = -M_PI_2;
    CGFloat coordinateTheta = (-M_PI - theta)*0.5;
    CGFloat lineWidth = 13.0;
    CGFloat lineSpace = (realHeight - 3.0f * lineWidth) * 0.5;
    /*********************************************************************************/
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGAffineTransform toGenten = CGAffineTransformMakeTranslation(shita.x, shita.y);
    CGAffineTransform rotate = CGAffineTransformRotate(toGenten, coordinateTheta);
    
    CGPathMoveToPoint(path, &rotate, 0.0, 0.0);
    CGPathAddLineToPoint(path, &rotate, 3.0f*lineWidth + 2.0f*lineSpace, 0.0f);
    CGPathAddArc(path, &rotate, 0.0f, 0.0f, 3.0f*lineWidth + 2.0f*lineSpace, 0.0, theta, YES);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    CGContextSetLineWidth(context, 2.0);
    
    UIColor *color = EEHUD_COLOR_IMAGE;
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    
    CGContextStrokePath(context);
}

- (void)drawTurnArround:(CGRect)rect
{
//    /** definition *******************************************************************/
//    CGFloat width = rect.size.width;
//    CGFloat height = rect.size.height;
//    CGPoint center = CGPointMake(rect.origin.x + width*0.5, rect.origin.y + height*0.5);
//    
//    CGFloat oneSide = (width < height) ? width : height;
//    CGFloat r = oneSide * 0.5;
//    
//    CGFloat circleR = r * 0.4;
//    /*********************************************************************************/
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGMutablePathRef path = CGPathCreateMutable();
//    
//    CGPathAddArc(path, NULL, center.x, center.y, circleR, 0.0, 2*M_PI, YES);
//    
//    CGContextAddPath(context, path);
//    CGPathRelease(path);
//    
//    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
//    CGContextSetLineWidth(context, 2.0);
//    
//    CGContextStrokePath(context);
}

@end
