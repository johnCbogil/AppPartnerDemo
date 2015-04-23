//
//  AnimationSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "AnimationSectionViewController.h"
#import "MainMenuViewController.h"



@interface AnimationSectionViewController ()

@end

@implementation AnimationSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"AnimationBackground.png"]];
    

    self.particleView = (ParticleView*)self.appPartnerIcon;
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)spinButtonPressed:(id)sender {
    
    [self.particleView createFireWorksLayer:2];

    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2;
    
    [self.appPartnerIcon.layer addAnimation:rotationAnimation forKey:@"transform.rotation"];
    
    
}


- (IBAction)handlePan:(UIPanGestureRecognizer *)sender {
    
    self.appIconPan.delegate = self;
    CGPoint translation = [sender translationInView:self.view];
    sender.view.center = CGPointMake(sender.view.center.x + translation.x,
                                         sender.view.center.y + translation.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [sender velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 1000;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(sender.view.center.x + (velocity.x * slideFactor),
                                         sender.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            sender.view.center = finalPoint;
        } completion:nil];
        
    }
}


@end
