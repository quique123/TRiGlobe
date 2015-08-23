//
//  TagListController.m
//  iGlobe
//
//  Created by Marcio Valenzuela on 9/24/10.
//  Copyright 2010 Personal. All rights reserved.
//

#import "TagListController.h"
#import "SantiappsHelper.h"

@interface TagListController ()

@property (nonatomic, strong) NSMutableArray *tagsArray;
@property (strong, nonatomic) UIActivityIndicatorView  *spinner;

@end

@implementation TagListController


#warning PENDING
- (void)viewDidLoad {
    [super viewDidLoad];
    // change background
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //##########################################################################################################PENDING
    //1. Connect to internet --- DONE
    //2. Fetch tags from tags table that DONT have FOUND CHECKED --- DONE
    //3. List them here  --- DONE
    //4. On User Select ... Call NewMapViewController???? #PENDING

    // begin animating the spinner
    [self.spinner startAnimating];
    
    [SantiappsHelper fetchUsersWithCompletionHandler:^(NSArray *users) {
        self.tagsArray = [NSMutableArray array];
        
        for (NSDictionary *userDict in users) {
            [self.tagsArray addObject:[userDict objectForKey:@"username"]];
        }
        
        //WHILE TESTING postarray method, comment this out...
        [self.tableView reloadData];
    }];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackleather.png"]];

}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.tagsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    // change background of cell
    cell.backgroundColor = [UIColor clearColor];
    //cell.contentView.backgroundColor = [UIColor blackColor];
    //cell.contentView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"greenwood.png"]];

    if (indexPath.section == 0) {
		// Configure the cell...
		cell.textLabel.text = [self.tagsArray objectAtIndex:indexPath.row];
        cell.textLabel.backgroundColor=[UIColor clearColor];

		return cell;
	}
	else {
		// Configure cell with your stats
		cell.textLabel.text = @"Total points:";
		cell.detailTextLabel.text = @"You've infected:";
        cell.textLabel.backgroundColor=[UIColor clearColor];

		return cell;
	}

    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}



@end

