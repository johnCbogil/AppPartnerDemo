//
//  ParticleView.h
//  IOSProgrammerTest
//
//  Created by Aditya Narayan on 4/22/15.
//  Copyright (c) 2015 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParticleView : UIImageView


@property (nonatomic, strong) CAEmitterLayer *emitter;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) CAEmitterCell *firework;
@property (nonatomic) CGFloat decayAmount;

-(void)createFireWorksLayer:(int)birthRate;






@end
