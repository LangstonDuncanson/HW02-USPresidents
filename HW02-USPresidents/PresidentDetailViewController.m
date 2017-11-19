//
//  PresidentDetailViewController.m
//  HW02-USPresidents
//
//  Created by Lanjoudun on 11/18/17.
//  Copyright © 2017 Lanjoudun. All rights reserved.
//

#import "PresidentDetailViewController.h"

@interface PresidentDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *presidentImageView;
@property (weak, nonatomic) IBOutlet UITextView *presidentDetailsText;

@end

@implementation PresidentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString * image = self.presidentDetails[@"image"];
    self.presidentImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"presidentImages/%@",image]];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat =@"MMM dd yyyy";
    NSMutableString * yearBorn,* yearDeath,* yearOffice;
    yearBorn = [NSMutableString stringWithFormat:@"%@",[format stringFromDate:self.presidentDetails[@"yearBorn"]]];
    yearDeath = [NSMutableString stringWithFormat:@"%@",[format stringFromDate:self.presidentDetails[@"yearDeath"]]];
    if([yearDeath isEqualToString:@"Jan 01 0001"])
        yearDeath = [NSMutableString stringWithFormat:@"Still Alive"];
    yearOffice = [NSMutableString stringWithFormat:@"%@",[format stringFromDate:self.presidentDetails[@"yearOffice"]]];
    self.presidentDetailsText.text = [NSString stringWithFormat:@"Name:%@\n\nYear Born:%@\n Place Born: %@\n\nYear of Death:%@\nPlace of Death:%@\n\nYear in Office:%@\nTerms Served:%@\n\nOccupation:%@\nParty Affiliation:%@",self.presidentDetails[@"name"],yearBorn,self.presidentDetails[@"placeBorn"],yearDeath,self.presidentDetails[@"placeDeath"],yearOffice,[self.presidentDetails[@"numOfTerms"] stringValue],self.presidentDetails[@"occupation"],self.presidentDetails[@"partyAffilation"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
