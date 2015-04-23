//
//  AnimationSectionViewController.h
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <SceneKit/SceneKit.h>
#import "ParticleView.h"

@interface AnimationSectionViewController : UIViewController <UIGestureRecognizerDelegate>

- (IBAction)spinButtonPressed:(id)sender;
- (IBAction)handlePan:(UIPanGestureRecognizer *)sender;


@property (strong, nonatomic) IBOutlet UIImageView *appPartnerIcon;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *appIconPan;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (strong, nonatomic) IBOutlet UIButton *spinButton;
@property (nonatomic, strong) UIPushBehavior *pusher;

@property (nonatomic, strong) ParticleView *particleView;



@end
