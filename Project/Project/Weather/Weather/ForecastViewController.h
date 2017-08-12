//
//  ForecastViewController.h
//  Weather
//
//  Created by Sahaj Singh on 7/14/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic)NSString *cityname;
@property (nonatomic) float forecastlatitude;
@property (nonatomic) float forecastlongitude;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
