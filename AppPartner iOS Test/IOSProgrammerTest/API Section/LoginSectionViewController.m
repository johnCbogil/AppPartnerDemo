//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"

@interface LoginSectionViewController ()

@end

@implementation LoginSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LoginBackground"]];
    
    // Set the placeholder font color
    if ([self.usernameTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"username" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    if ([self.passwordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
}

#pragma mark - NSURLConnectionDelegate Methods

- (void)startLoginRequest{

    
    NSURL *url = [[NSURL alloc] initWithString:@"http://dev.AppPartner.com/AppPartnerProgrammerTest/scripts/login.php"];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    
    
    postRequest.HTTPMethod = @"POST";
    
    //NSString *successCredentials = @"username=SuperBoise&password=qwerty";
    NSString *credentials = [NSString stringWithFormat:@"username=%@&password=%@", self.usernameTextField.text, self.passwordTextField.text];
    
    
    
    NSData *requestBodyData = [credentials dataUsingEncoding:NSUTF8StringEncoding];
    postRequest.HTTPBody = requestBodyData;

    self.loginConnection = [[NSURLConnection alloc]initWithRequest:postRequest delegate:self startImmediately:YES];
    
    self.requestStartTime = [NSDate date];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    self.loginResponseData = [[NSMutableData alloc]init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.loginResponseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    self.requestFinishTime = [NSDate date];
    self.totalRequestTime = [self.requestFinishTime timeIntervalSinceDate:self.requestStartTime];
    NSLog(@"%f", self.totalRequestTime);

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    [self parseAPIResponse];
    

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"%@", error);
}


- (void)parseAPIResponse{
    
    NSMutableDictionary *decodedData = [NSJSONSerialization JSONObjectWithData:self.loginResponseData options:0 error:nil];
    NSLog(@"%@",decodedData);
    
    NSString *code = [decodedData valueForKey:@"code"];
    NSString *message = [decodedData valueForKey:@"message"];
    NSString *alertViewMessage = [NSString stringWithFormat:@"%@\n The API request took %f milliseconds",message, self.totalRequestTime *1000 ];
    
    
    UIAlertView *apiResponse = [[UIAlertView alloc]initWithTitle:code message:alertViewMessage delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [apiResponse show];
    
    
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

- (IBAction)loginButtonPressed:(id)sender {
    
    [self startLoginRequest];
}
@end
