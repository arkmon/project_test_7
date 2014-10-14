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
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

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
    
    // code for telephone trig
   // NSString *phoneStr = [@"tel://" stringByAppendingString:_telLabel.text];
   // NSURL *phoneURL = [NSURL URLWithString:phoneStr];
   // [[UIApplication sharedApplication] openURL:phoneURL];
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view with data from second view
        [self configureView];
    }
}
- (IBAction)makeCall:(id)sender {
    NSString *ex = [self.detailItem objectForKey:@"extention"];
    NSString *ops = @"tel:+4402079115000,";
    NSString *com = [NSString stringWithFormat:@"%@%@", ops, ex];
    NSURL *phoneNumber = [[NSURL alloc] initWithString: com];
    
    //[[UIApplication sharedApplication] openURL:phoneNumber];
   //   NSURL *phoneNumber = [[NSURL alloc] initWithString: @"tel:867-5309"];

   // NSLog( @"%@", phoneNumber);
    
       [[UIApplication sharedApplication] openURL: phoneNumber];
}


- (IBAction)createEvent:(id)sender {
    
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKEventEditViewController* controller = [[EKEventEditViewController alloc]init];
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            /* This code will run when uses has made his/her choice */
        }];
    }
    controller.eventStore = eventStore;
    controller.editViewDelegate = self;
    
    [self presentViewController:controller animated:YES completion:nil];
    
    
    /*
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    event.title     = @"EVENT TITLE";
    
    event.startDate = [[NSDate alloc] init];
    event.endDate   = [[NSDate alloc] initWithTimeInterval:600 sinceDate:event.startDate];
    
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
*/
}
- (void) eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)openMail:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        //[mailer setSubject:@"A Message"];
        
        NSString *emailFragment = self.detailItem[@"email"];
        NSString *fullEmail = [emailFragment stringByAppendingString:@"@westminster.ac.uk"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:fullEmail, nil];
        [mailer setToRecipients:toRecipients];
      
              
        NSString *emailBody = @"Type your message here";
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
