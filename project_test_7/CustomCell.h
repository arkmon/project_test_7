//
//  CustomCell.h
//  iMLecturer
//
//  Created by Arkadiusz Dowejko on 15/04/2013.
//  Copyright (c) 2013 ArkadiuszDowejko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *deptLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailText;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
