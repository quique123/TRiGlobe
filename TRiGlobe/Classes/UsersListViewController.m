//
//  UsersListViewController.m
//  TRiGlobe
//
//  Created by Marcio Valenzuela on 4/24/13.
//  Copyright (c) 2013 Marcio Valenzuela. All rights reserved.
//

#import "UsersListViewController.h"
#import "SantiappsHelper.h"
#import "Users.h"

@interface UsersListViewController ()
@property (nonatomic, strong) NSMutableArray *usersArray;
@property (nonatomic, strong) NSMutableArray *usersPointsArray;
@property (nonatomic, strong) NSMutableArray *arrayOfUsersForList;

@property (nonatomic, strong) NSMutableData *buffer;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView  *spinner;
@property (nonatomic, strong) NSURLConnection *myConnection;


@end

@implementation UsersListViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    // begin animating the spinner
    [self.spinner startAnimating];
    
    [SantiappsHelper fetchUsersWithCompletionHandler:^(NSArray *users) {
        self.usersArray = [NSMutableArray array];

        for (NSDictionary *userDict in users) {
            [self.usersArray addObject:[userDict objectForKey:@"username"]];
        }
        
        //WHILE TESTING postarray method, comment this out...
        [self.tableView reloadData];
        [self getPoints];
    }];
}

-(void)getPoints{
    self.usersPointsArray = [[NSMutableArray alloc] init];
 
    [SantiappsHelper fetchPointForUsersArray:self.usersArray WithCompletionHandler:^(NSArray *usersPointsArray) {
        //NSLog(@"usersPointsArray %@", usersPointsArray);
        for (NSDictionary *usersDict in usersPointsArray) {
            Users *user = [[Users alloc] initWithUserName:[usersDict objectForKey:@"username"] userPoints:[usersDict objectForKey:@"PUNTOS"]];
            [self.usersPointsArray addObject:user];
        }
        //NSLog(@"self.usersPointsArray %@", self.usersPointsArray);
        [self.tableView reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.usersPointsArray count] == 0) {
        return [self.usersArray count];
    } else {
        return self.usersPointsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    //NSLog(@"self.usersArray oAIP-oFK %@", [[self.usersArray objectAtIndex:indexPath.row] objectForKey:@"username"]);
    
    if ([self.usersPointsArray count] == 0) {
        //call getpoints
        cell.textLabel.text = [self.usersArray objectAtIndex:indexPath.row];
    } else {
        Users *userToDisplay = [self.usersPointsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = userToDisplay.userName;
        cell.detailTextLabel.text = userToDisplay.userPoints;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



@end
