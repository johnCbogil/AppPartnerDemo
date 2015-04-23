//
//  TableSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatSectionViewController.h"
#import "MainMenuViewController.h"
#import "ChatCell.h"


@interface ChatSectionViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *loadedChatData;
@property (nonatomic, strong) ChatCell *cell;

@end

@implementation ChatSectionViewController

static NSString *cellIdentifier = @"ChatCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loadedChatData = [[NSMutableArray alloc] init];
    [self loadJSONData];
    
    
    // dont need this when using storyboard
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
}


- (void)loadJSONData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chatData" ofType:@"json"];
    
    NSError *error = nil;
    
    NSData *rawData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    
    id JSONData = [NSJSONSerialization JSONObjectWithData:rawData options:NSJSONReadingAllowFragments error:&error];
    
    [self.loadedChatData removeAllObjects];
    if ([JSONData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *jsonDict = (NSDictionary *)JSONData;
        
        NSArray *loadedArray = [jsonDict objectForKey:@"data"];
        if ([loadedArray isKindOfClass:[NSArray class]])
        {
            for (NSDictionary *chatDict in loadedArray)
            {
                ChatData *chatData = [[ChatData alloc] init];
                [chatData loadWithDictionary:chatDict];
                [self.loadedChatData addObject:chatData];
            }
        }
    }
    
    [self.tableView reloadData];
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


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    self.cell.messageLabel.text = [[self.loadedChatData objectAtIndex:indexPath.row]message];
    self.cell.usernameLabel.text = [[self.loadedChatData objectAtIndex:indexPath.row]username];
    
    self.cell.avatarImage.image  = nil;
    
    NSURL *url = [[NSURL alloc]initWithString:[[self.loadedChatData objectAtIndex:indexPath.row]avatar_url]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[[self.loadedChatData objectAtIndex:indexPath.row]username]]];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fileName];
    
    if (!fileExists) {
        

        [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                
                // Return to main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    ChatCell *updateCell =(ChatCell *)[tableView cellForRowAtIndexPath:indexPath];
                    updateCell.avatarImage.image = image;
                });
                
                // Download the image data
                NSData *imageData = [[NSData alloc]initWithContentsOfURL:url];
                [imageData writeToFile:fileName atomically:YES];
            }
        }];
        

    }
        
        self.cell.avatarImage.image = [[UIImage alloc]initWithContentsOfFile:fileName];
        



    return self.cell;
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.loadedChatData.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.cell.bounds));
    
    [self.cell layoutIfNeeded];
    
    CGSize size = [self.cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height+1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


@end
