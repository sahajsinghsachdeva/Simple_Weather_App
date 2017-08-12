//
//  SimpleTableCell.h
//  Weather
//
//  Created by Sahaj Singh on 7/3/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *day_var;
@property (strong, nonatomic) IBOutlet UIImageView *dayimage_var;

@property (strong, nonatomic) IBOutlet UILabel *min_var;
@property (strong, nonatomic) IBOutlet UILabel *max_var;
@end
