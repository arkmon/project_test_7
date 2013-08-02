//
//  PersonDetailViewController.h
//  iMLecturer
//
//  Created by Arkadiusz Dowejko on 15/04/2013.
//  Copyright (c) 2013 ArkadiuszDowejko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"
#import "AFNetworking.h"
#import <MessageUI/MessageUI.h>
#import <EventKitUI/EventKitUI.h>

@interface PersonDetailViewController : UIViewController <MFMailComposeViewControllerDelegate, EKEventEditViewDelegate>
- (IBAction)openMail:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *makeCall;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *fNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *deptLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UIButton *createEvent;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
