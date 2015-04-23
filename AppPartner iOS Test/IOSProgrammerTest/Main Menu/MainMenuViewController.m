//
//  ViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ChatSectionViewController.h"
#import "LoginSectionViewController.h"
#import "AnimationSectionViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    UIMotionEffectGroup *motionEffect = [self createMotionEffect];
    [self.codingTasksLabel addMotionEffect:motionEffect];
    [self.chatButton addMotionEffect:motionEffect];
    [self.loginButton addMotionEffect:motionEffect];
    [self.animationTestButton addMotionEffect:motionEffect];
    
}

- (UIMotionEffectGroup*) createMotionEffect {
    
    UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-8);
    verticalMotionEffect.maximumRelativeValue = @(8);
    
    UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x"type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-8);
    horizontalMotionEffect.maximumRelativeValue = @(8);
    
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    return group;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tableSectionAction:(id)sender
{
    ChatSectionViewController *tableSectionViewController = [[ChatSectionViewController alloc] init];
    [self.navigationController pushViewController:tableSectionViewController animated:YES];
}
- (IBAction)apiSectionAction:(id)sender
{
    LoginSectionViewController *apiSectionViewController = [[LoginSectionViewController alloc] init];
    [self.navigationController pushViewController:apiSectionViewController animated:YES];
}
- (IBAction)animationSectionAction:(id)sender
{
    AnimationSectionViewController *animationSectionViewController = [[AnimationSectionViewController alloc] init];
    [self.navigationController pushViewController:animationSectionViewController animated:YES];
}
@end
