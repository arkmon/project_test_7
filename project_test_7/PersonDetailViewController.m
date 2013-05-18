//
//  PersonDetailViewController.m
//  iMLecturer
//
//  Created by Arkadiusz Dowejko on 15/04/2013.
//  Copyright (c) 2013 ArkadiuszDowejko. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "AFNetworking.h"
#import "SecondViewController.h"

@interface PersonDetailViewController ()

@end

@implementation PersonDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureView
{
    // Update the user interface for the detail item.
    
    
    if (self.detailItem) {
        self.fNameLabel.text = [self.detailItem objectForKey:@"firstName"];
        self.lNameLabel.text = [self.detailItem objectForKey:@"lastName"];
        self.titleLabel.text = [self.detailItem objectForKey:@"title"];
        self.deptLabel.text = [self.detailItem objectForKey:@"department"];
        self.dayLabel.text = [self.detailItem objectForKey:@"officeDay"];
        self.hourLabel.text = [self.detailItem objectForKey:@"officeHours"];
        self.telLabel.text = [self.detailItem objectForKey:@"extention"];
        self.roomLabel.text = [self.detailItem objectForKey:@"room"];
        self.statusLabel.text = [self.detailItem objectForKey:@"AvStatus"];
        NSString *url = [self.detailItem objectForKey:@"profile_image"];
        [self.imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"avatar.png"]];
     
    }
    if ([self.statusLabel.text isEqual: @"Available"])
    {  //color for user's better atention
        self.statusLabel.textColor = [UIColor greenColor];
    } else {
        self.statusLabel.textColor = [UIColor redColor];
    }
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view with data from second view
        [self configureView];
    }
}

@end
