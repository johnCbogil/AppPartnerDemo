//
//  ParticleView.m
//  IOSProgrammerTest
//
//  Created by Aditya Narayan on 4/22/15.
//  Copyright (c) 2015 AppPartner. All rights reserved.
//

#import "ParticleView.h"

@implementation ParticleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(Class)layerClass{
    
    // ensures that a CAEmitterLayer is returned instead of a CALayer
    return [CAEmitterLayer class];
}

-(void)createFireWorksLayer:(int)birthRate{

    
    self.emitter = (CAEmitterLayer*)self.layer;
    
    self.emitter.emitterPosition = CGPointMake(50, 50);
    self.emitter.emitterSize = CGSizeMake(5, 5);
    
    self.firework = [CAEmitterCell emitterCell];
    self.firework.birthRate = birthRate;
    self.emitter.birthRate = birthRate;
    self.firework.lifetime = 2.0;
    self.firework.lifetimeRange = 0.5;
    self.firework.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.6] CGColor];
    self.firework.contents = (id)[[UIImage imageNamed:@"firework.png"] CGImage];
    [self.firework setName:@"fire"];
    
    self.firework.velocity = 100;
    self.firework.velocityRange = 20;
    self.firework.emissionRange = M_PI * 2.0f;
    
    self.firework.scaleSpeed = 0.1;
    self.firework.spin = 0.5;
    self.firework.scale = .15;
    
    self.emitter.emitterCells = [NSArray arrayWithObject:self.firework];
    
    self.emitter.renderMode = kCAEmitterLayerAdditive;
    
    [self decayOverTime:3];
    
    
}

- (void) decayStep {
    self.emitter.birthRate -=_decayAmount;
    if (self.emitter.birthRate < 0) {
        self.emitter.birthRate = 0;
    } else {
        [self performSelector:@selector(decayStep) withObject:nil afterDelay:.1];
    }
}

- (void) decayOverTime:(NSTimeInterval)interval {
    _decayAmount = (CGFloat) (self.emitter.birthRate /  (interval / .1));
    [self decayStep];
}

- (void) stopEmitting {
    self.emitter.birthRate = 0.0;
}

@end
