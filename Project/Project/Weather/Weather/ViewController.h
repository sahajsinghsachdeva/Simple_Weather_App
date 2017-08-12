//
//  ViewController.h
//  Weather
//
//  Created by Sahaj Singh on 6/30/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate,UITableViewDelegate, UITableViewDataSource>


@property (nonatomic) float newlatitude;
@property (nonatomic) float newlongitude;
@property (nonatomic) int status;
@property (strong, nonatomic) IBOutlet UILabel *cityname;
@property (strong, nonatomic) IBOutlet UILabel *humid_var;
@property (strong, nonatomic) IBOutlet UILabel *wind_var;
@property (strong, nonatomic) IBOutlet UILabel *visi_var;
@property (strong, nonatomic) IBOutlet UILabel *ppt_var;
@property (strong, nonatomic) IBOutlet UILabel *status_var;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *lastup_var;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *currtemp;
@property (strong, nonatomic) IBOutlet UIImageView *currimage;
@property (strong, nonatomic) IBOutlet UIImageView *precipitationimage;
- (IBAction)forecast:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;



@end

