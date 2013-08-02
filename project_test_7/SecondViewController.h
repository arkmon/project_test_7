//
//  SecondViewController.h
//  project_test_7
//
//  Created by Arkadiusz Dowejko on 13/04/2013.
//  Copyright (c) 2013 ArkadiuszDowejko. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *results;
@property (retain, nonatomic) NSMutableArray *displayItems;
@property (retain, nonatomic) IBOutlet UISearchBar *serchBar;
@property (weak, nonatomic)  NSDictionary *tweet;
@end
