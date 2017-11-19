//
//  PresidentTableViewCell.h
//  HW02-USPresidents
//
//  Created by Lanjoudun on 11/18/17.
//  Copyright © 2017 Lanjoudun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresidentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *presidentImageView;
@property (weak, nonatomic) IBOutlet UILabel *presidentName;
@property (weak, nonatomic) IBOutlet UILabel *presidentParty;
@property (weak, nonatomic) IBOutlet UILabel *presidentJob;

@end
