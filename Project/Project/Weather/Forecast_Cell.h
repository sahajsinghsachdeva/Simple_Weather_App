//
//  Forecast_Cell.h
//  Weather
//
//  Created by Sahaj Singh on 7/14/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Forecast_Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *Date_field;
@property (strong, nonatomic) IBOutlet UILabel *Min_field;
@property (strong, nonatomic) IBOutlet UILabel *Max_field;
@property (strong, nonatomic) IBOutlet UILabel *Precipitation_Value;
@property (strong, nonatomic) IBOutlet UILabel *Wind_Value;
@property (strong, nonatomic) IBOutlet UILabel *Visibility_Value;
@property (strong, nonatomic) IBOutlet UILabel *Humidity_Value;
@property (strong, nonatomic) IBOutlet UILabel *Status_Field;
@property (strong, nonatomic) IBOutlet UIImageView *Status_Image;
@property (strong, nonatomic) IBOutlet UILabel *Day;

@end
