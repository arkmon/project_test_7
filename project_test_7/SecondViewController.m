//
//  SecondViewController.m
//  project_test_7
//
//  Created by Arkadiusz Dowejko on 13/04/2013.
//  Copyright (c) 2013 ArkadiuszDowejko. All rights reserved.
//

#import "SecondViewController.h"
#import "AFNetworking.h"
#import "CustomCell.h"
#import "PersonDetailViewController.h"
//importing all classes involved
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.90 alpha:1.0];  
    // above code apply formatting to my table
    NSURL *url = [NSURL URLWithString:@"http://www.imlecturer.arkmon.co.uk/index.php/json"];
    //above code defines my url for json formatted data
    NSURLRequest *request = [NSURLRequest requestWithURL:url]; // im setting up the request with url
    
    //code below creates the json request operation and proceed with the request
    
    AFJSONRequestOperation *operation;
    operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
    success:^(NSURLRequest *req, NSHTTPURLResponse *response, id jsonObject) {
        //NSLog(@"Response: %@", jsonObject);
        self.results = [jsonObject objectForKey:@"results"]; //if success: put all objects from fesults to the array 
        self.displayItems = [[NSMutableArray alloc] initWithArray:self.results]; //copy array to mutable array
        [self.tableView reloadData]; //refresh the table
        NSLog(@"Response: %@", _displayItems); //show what is in the array in log
    } failure:^(NSURLRequest *req, NSHTTPURLResponse *response, NSError *error, id jsonObject) {
        //NSLog(@"Success %d", response.statusCode);
        //NSLog(@"Error: %@", error);
        // if failure, show me the error
    }];
    [operation start];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.serchBar resignFirstResponder]; //hide keyboard when scroll detected
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // i want one section in my table
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.displayItems.count;  // display as many cells ad data contains
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[CustomCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellIdentifier]; // if no cell, put one
        
       // cell.contentView.backgroundColor = self.tableView.backgroundColor;
       // cell.mainLabel.font = [UIFont boldSystemFontOfSize:14];
       // cell.mainLabel.textColor = [UIColor darkGrayColor];
      //  cell.mainLabel.backgroundColor = cell.contentView.backgroundColor;
      //  cell.detailText.backgroundColor = cell.mainLabel.backgroundColor;
      //  cell.deptLabel.textColor = [UIColor redColor];
        
    }
    
    self.tweet = [self.displayItems objectAtIndex:indexPath.row]; // in dictionairy i want only one lecturer
    cell.mainLabel.text = [self.tweet objectForKey:@"firstName"]; //print value 
    cell.detailText.text = [self.tweet objectForKey:@"lastName"];
    cell.deptLabel.text = [self.tweet objectForKey:@"department"];
    NSString *url = [self.tweet objectForKey:@"profile_image"];
    [cell.imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"avatar.png"]];
   // if no image, put one from the directory
    return cell;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.displayItems removeAllObjects];// if no text in field, display whole table
    if ([searchText length] == 0) {
        [_displayItems removeAllObjects];
        [_displayItems addObjectsFromArray:_results];
    }
    else { //if ther is a text
        [_displayItems removeAllObjects];
        
        for (NSDictionary *tweet in _results) { //search the array with objects
            
            for (NSString * string in [tweet allValues])  {
                NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
                //with the range of text from the search
                if (r.location !=NSNotFound) {
                    [_displayItems addObject:tweet];//show what you found
                    //NSLog(@"ok %@", string);
                    break;
                }
            }
        }
    }
    [_tableView reloadData];
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];   //hide keyboard with search clicked
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) { // if my table is clicked
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; //define the path for selected row
        NSArray *object = _displayItems[indexPath.row]; //put only selected lecturer to new array
        NSLog(@"String %@", object); // show me what you did
        [[segue destinationViewController] setDetailItem:object]; // send the array to the next view
    }
    
}


@end
