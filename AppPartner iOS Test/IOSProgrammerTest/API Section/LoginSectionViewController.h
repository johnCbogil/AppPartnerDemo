//
//  APISectionViewController.h
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginSectionViewController : UIViewController <NSURLConnectionDelegate>


@property (nonatomic, strong) NSURLConnection *loginConnection;
@property (nonatomic, strong) NSMutableData *loginResponseData;

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) NSDate *requestStartTime;
@property (strong, nonatomic) NSDate *requestFinishTime;
@property (nonatomic) NSTimeInterval totalRequestTime;





- (IBAction)loginButtonPressed:(id)sender;

@end
