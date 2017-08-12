//
//  Forecast_Cell.m
//  Weather
//
//  Created by Sahaj Singh on 7/14/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import "Forecast_Cell.h"
#import "QuartzCore/QuartzCore.h"
@implementation Forecast_Cell
@synthesize Date_field=_Date_field;
@synthesize Min_field=_Min_field;
@synthesize Max_field=_Max_field;
@synthesize Humidity_Value=_Humidity_Value;
@synthesize Precipitation_Value=_Precipitation_Value;
@synthesize Wind_Value=_Wind_Value;
@synthesize Visibility_Value=_Visibility_Value;
@synthesize Status_Field=_Status_Field;
@synthesize Day=_Day;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
