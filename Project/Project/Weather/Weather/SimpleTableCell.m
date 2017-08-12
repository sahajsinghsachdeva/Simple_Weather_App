//
//  SimpleTableCell.m
//  Weather
//
//  Created by Sahaj Singh on 7/3/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell
@synthesize day_var=_day_var;
@synthesize dayimage_var=_dayimage_var;
@synthesize min_var=_min_var;
@synthesize max_var=_max_var;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
