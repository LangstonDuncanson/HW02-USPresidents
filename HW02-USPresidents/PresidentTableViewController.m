//
//  PresidentTableViewController.m
//  HW02-USPresidents
//
//  Created by Lanjoudun on 11/18/17.
//  Copyright © 2017 Lanjoudun. All rights reserved.
//

#import "PresidentTableViewController.h"
#import "PresidentTableViewCell.h"
#import "PresidentDetailViewController.h"

@interface PresidentTableViewController ()
@property (nonatomic, strong) NSArray *  presidents;
@property (nonatomic, strong) NSArray * sortedPresidents;
@property (nonatomic, strong) NSArray * keys;
@property (nonatomic, strong) NSMutableDictionary *nameDictionary;

@end

@implementation PresidentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString * path = [[NSBundle mainBundle] pathForResource:@"presidents" ofType:@"plist"];
    self.presidents = [NSArray arrayWithContentsOfFile:path];
    //NSLog(@"%@",self.presidents);
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *sortedArray = [self.presidents sortedArrayUsingDescriptors:sortDescriptors];
    self.sortedPresidents = [NSArray arrayWithArray:sortedArray];
    //NSLog(@"%@",self.sortedPresidents);
    
    
    self.nameDictionary = [[NSMutableDictionary alloc] init];
    NSUInteger index = 0;
    
    for (NSDictionary * president in _sortedPresidents) {
        
        NSString *key =  [[[president objectForKey:@"name"] substringToIndex: 1] uppercaseString];
        
        if ([self.nameDictionary objectForKey:key] != nil ){
            
            NSMutableArray *tempArray = [self.nameDictionary objectForKey:key];
            [tempArray addObject: president];
            [self.nameDictionary setObject:tempArray forKey:key];
        } else {
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects: president, nil];
            [self.nameDictionary setObject:tempArray forKey:key];
        }
        index++;
    }
    //NSLog(@"Hey there! %@",self.nameDictionary);
    self.keys = [[self.nameDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString* key = self.keys[section];
    NSArray* keyValues = self.nameDictionary[key];
    return [keyValues count];
}
/*-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sortedPresidents[section][@"name"];
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * key = self.keys[indexPath.section];
    NSArray* keyValues = self.nameDictionary[key];
    
    static NSString *CellIdentifier = @"PresidentCell";
    PresidentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.presidentName.text = [[keyValues objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.presidentJob.text = [[keyValues objectAtIndex:indexPath.row] objectForKey:@"occupation"];
    cell.presidentParty.text = [[keyValues objectAtIndex:indexPath.row] objectForKey:@"partyAffilation"];
    NSString *image = [[keyValues objectAtIndex:indexPath.row] objectForKey:@"image"];
    cell.presidentImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"presidentPortrait/%@",image]];
    // Configure the cell...
    
    return cell;
}

-(NSArray*) sectionIndexTitlesForTableView:(UITableView *) tableView{
    return self.keys;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([[segue identifier] isEqualToString:@"showDetail"]){
        PresidentDetailViewController * detailVC = [segue destinationViewController];
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"This is self keys %@", self.keys);
        NSString *key = [self.keys objectAtIndex:myIndexPath.section];
        NSLog(@"This is key %@", key);
        NSLog(@"This is myIndexPath row %ld", myIndexPath.row);
        detailVC.presidentDetails = [NSMutableDictionary dictionaryWithDictionary:self.nameDictionary[key][myIndexPath.row]];
        NSLog(@"%ld",myIndexPath.row);
        NSLog(@"%@",[self.nameDictionary[key] class]);
    }
    // Pass the selected object to the new view controller.
}


@end
