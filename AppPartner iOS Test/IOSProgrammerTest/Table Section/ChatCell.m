//
//  TableSectionTableViewCell.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatCell.h"

@interface ChatCell ()

@end

@implementation ChatCell

- (void)awakeFromNib
{

    self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2;
    self.avatarImage.layer.masksToBounds = YES;


}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    self.messageLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.messageLabel.frame);
    

}


@end
