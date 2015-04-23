//
//  TableSectionTableViewCell.h
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatData.h"
@interface ChatCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@end
