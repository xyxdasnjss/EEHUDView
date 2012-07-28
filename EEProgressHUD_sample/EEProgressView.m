//
//  EEProgressView.m
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 12/07/25.
//  Copyright (c) 2012年 Milestoneeee.com. All rights reserved.
//

#import "EEProgressView.h"
#import "EEHUDViewConstants.h"

@interface EEProgressView ()
{
    float _progress;
}

@end

@implementation EEProgressView

@synthesize progress = _progress;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.progress = 0.0;
    }
    return self;
}

- (void)setProgress:(float)progress
{
    if (progress > 1.0) {
        progress = 1.0;
    }else if (progress < 0.0) {
        progress = 0.0;
    }
    
    _progress = progress;
    if (progress != 0.0) {
        [self setNeedsDisplay];
    }
    
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGFloat width = rect.size.width;
    CGFloat realWidth = width * _progress;
    CGFloat height = rect.size.height;
    CGFloat minWidth = height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0.0, height*0.5);
    if (realWidth <= minWidth) {
        CGPathAddArc(path, NULL,
                     height*0.5, height*0.5, 
                     height*0.5, 0.0, 2.0*M_PI, YES);
    }else {
        
        CGPathAddArc(path, NULL,
                     height*0.5, height*0.5, 
                     height*0.5, M_PI, 3.0*M_PI_2, NO);
        CGPathAddLineToPoint(path, NULL, realWidth - height*0.5, 0.0);
        CGPathAddArc(path, NULL, 
                     realWidth - height*0.5, height*0.5, 
                     height*0.5, 3.0*M_PI_2, 5.0*M_PI_2, NO);
        CGPathAddLineToPoint(path, NULL, height*0.5, height);
        CGPathAddArc(path, NULL, height*0.5, height*0.5, 
                     height*0.5, 5.0*M_PI_2, 6.0*M_PI_2, NO);
    }
    
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    CGPathRelease(path);
    
    UIColor *color = EEHUD_COLOR_PROGRESS;
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillPath(context);
}

@end
