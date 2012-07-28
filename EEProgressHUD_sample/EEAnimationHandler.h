//
//  EEAnimationHandler.h
//  AnimationTest
//
//  Created by Kudo Yoshiki on 12/07/24.
//  Copyright (c) 2012年 milestoneeee.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef void (^EEAnimationDidStopHandlerBlock)(CAAnimation *anim, BOOL finished);
typedef void (^EEAnimationDidStartHandlerBlock)(CAAnimation *anim);

@interface CAAnimation (handle)

@property (nonatomic, strong) EEAnimationDidStartHandlerBlock startHandlerBlock;
@property (nonatomic, strong) EEAnimationDidStopHandlerBlock stopHandlerBlock;
@property (nonatomic, strong) NSString *animationKey;
@property (nonatomic, weak) CALayer *addedLayer;

@end


@interface EEAnimationHandler : NSObject

+ (EEAnimationHandler *)sharedHandler;

- (NSString *)registerAnimation:(CAAnimation *)animation toLayer:(CALayer *)layer forKey:(NSString *)key;

- (void)pauseLayer:(CALayer *)layer;
- (void)resumeLayer:(CALayer *)layer;

@end
