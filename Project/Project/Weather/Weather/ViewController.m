//
//  ViewController.m
//  Weather
//
//  Created by Sahaj Singh on 6/30/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SimpleTableCell.h"
#import "ForecastViewController.h"
@interface ViewController ()<CLLocationManagerDelegate>
{
    NSArray *data; // to store 24 hours time
    NSMutableArray *min; // to store an array of minimum temperature
    NSMutableArray *max; // to store an array of maximum temperature
    NSMutableArray *images; // to store an array of images of 24 hr temperature
    NSMutableArray *finalImages;
}
@end
@implementation ViewController


// Declarations
CLLocationManager *locationManager; //location manager
float a; // to store latitude
float b;// to store longitude
NSString *complete_name; // to store complete name of the city along with the country
NSString *humidityvariable; // to store value of current humidity
NSString *currentTemperature;
// to store value of current temperature
- (void)viewDidLoad
{

    [self.activityIndicatorView startAnimating]; // start the activity indicator
    

    // Location of the Device
    locationManager = [[CLLocationManager alloc]init];
    locationManager.distanceFilter = 5000;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingHeading];
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    locationManager.delegate = self;
    
    NSLog(@"%@",[self deviceLocation]);
    
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



// To find the latitude and longitude of the device
-(NSString *) deviceLocation{
    a = locationManager.location.coordinate.latitude;
    b = locationManager.location.coordinate.longitude;
    return [NSString stringWithFormat:@"latitude: %f longitude:%f",a,b];
}


// to make status bar visible according to background
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // make cell color clear
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
}


// Return number of sections in 24 hour update table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",data.count);
    return data.count;
    
}


// Defining cells and its values for the rows of 24 hours update table
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"SimpleTableCell"; // Cell identifier
    SimpleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine]; // Seperator line between the cells
    cell.day_var.text = [data objectAtIndex:indexPath.row]; // initialising time on label
    cell.dayimage_var.image = [UIImage imageNamed:[finalImages objectAtIndex:indexPath.row]]; // initialising images on label
    cell.min_var.text = [NSString stringWithFormat:@"%@",[min objectAtIndex:indexPath.row]];  // initialising minimum temperature on label
    cell.max_var.text = [NSString stringWithFormat:@"%@",[max objectAtIndex:indexPath.row]];  // initialising maximum temperature on label
    cell.day_var.textColor=[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f];
    cell.min_var.textColor=[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f];
    cell.max_var.textColor=[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f];

    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 410, 1)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor colorWithRed:202/255.0f green:120/255.0f blue:69/255.0f alpha:1.0f];
    [cell.contentView addSubview:separatorLineView];

    return cell;
}


// Height of each row 24 hour table
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}


// Height of header row of the 24 hour table
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 68.0;
}


// Defining cells and its values for the rows of 24 hours update table
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *tableIdentifier = @"SimpleTableCell";
    SimpleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell==nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.day_var.text = @"24 Hour Update";
        cell.backgroundColor = [UIColor colorWithRed:202/255.0f green:120/255.0f blue:69/255.0f alpha:1.0f];
        
    }
    return cell;
}


// This function will be called everytime when the view will appear
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated]; // to start activity indicator until the data is filled in all the labels
    [self.navigationController setNavigationBarHidden:YES animated:animated]; // to hide the navigation bar
    NSLog(@"The status is:%d",_status);

    
// Now the app will check whether the latitude and longitudes are zero or not. If they are zero than this must be an error.
    if (a!=0.00 && b!=0.00)
    {
    data = @[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00"]; // An array of 24 hour time

 
//check whether user starts from this view or have changed the city name
        if(_status==1)
            a=_newlatitude;
        if(_status==1) //check
            b=_newlongitude;
        if(_status==1)
          [ locationManager stopUpdatingLocation];
        
// to find the name with the latitude and longitude
        CLGeocoder *ceo = [[CLGeocoder alloc]init];
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:a longitude:b];// insert your coordinates
        [ceo reverseGeocodeLocation:loc
                  completionHandler:^(NSArray *placemarks, NSError *error)
        {
                      CLPlacemark *placemark = [placemarks objectAtIndex:0];
                      if (placemark)
                      {
                      complete_name = [NSString stringWithFormat:@"%@, %@",placemark.locality,placemark.country];
                      _cityname.text = complete_name; // Initialising City Name along with the country name to the city label
                      }
                      else
                      {
                      NSLog(@"Could not locate");
                      }
        }
         ];
        

// to find all the details of present time
        
        NSURLSession *session = [NSURLSession sharedSession]; // Session created
        NSString *complete_url = [NSString stringWithFormat:@"https://api.apixu.com/v1/current.json?key=34754dafe5974fe58ab95748172407&q=%f,%f",a,b]; // URL for the API
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:complete_url]completionHandler:^(NSData *datao, NSURLResponse *response, NSError *error)
        {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:datao options:0 error:nil];
            NSMutableDictionary *currentDict = [[NSMutableDictionary alloc]initWithDictionary:json[@"current"]];
            NSMutableDictionary *conDict = [[NSMutableDictionary alloc]initWithDictionary:currentDict[@"condition"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                NSString *currentstatus = [conDict valueForKey:@"icon"]; // present temperature icon
                NSArray *livetemp = [currentstatus componentsSeparatedByString:@"//cdn.apixu.com/weather/"];
                UIImage *currenticon = [UIImage imageNamed:[NSString stringWithFormat:@"%@",livetemp[1]]];// temperature icon after eliminating the substring
                _currimage.image = currenticon; // setting up the temperature icon to the label
                
                
                currentTemperature = [currentDict valueForKey:@"temp_c"];
                _currtemp.text = [NSString stringWithFormat:@"%@\u00b0c",currentTemperature]; // setting up the temperature to the present temperature label
                
                
                humidityvariable =  [currentDict valueForKey:@"humidity"];
                _humid_var.text = [NSString stringWithFormat:@"%@ %% ",humidityvariable]; // setting up the humidity to the label
                
                
                NSString *windvariable = [currentDict valueForKey:@"wind_kph"];
                _wind_var.text = [NSString stringWithFormat:@"%@ Km/h",windvariable]; // setting up the wind speed to the label

                
                NSString *visiblityvariable = [currentDict valueForKey:@"vis_km"];
                _visi_var.text = [NSString stringWithFormat:@"%@ Km",visiblityvariable]; // setting up the visibility to the label

                
                NSString *pptvariable = [currentDict valueForKey:@"precip_mm"];
                _ppt_var.text = [NSString stringWithFormat:@"%@ mm",pptvariable]; // setting up the precipitation to the label

                
                NSString *lastupdate = [currentDict valueForKey:@"last_updated"];
                _lastup_var.text = [NSString stringWithFormat:@"%@", lastupdate]; // setting up the last updated time to the label
                
                
                NSString *statusvariable=[conDict valueForKey:@"text"];
                _status_var.text = [NSString stringWithFormat:@"%@",statusvariable]; // setting up the status of the weather to the label
                
                
                    UIImage *background = [UIImage imageNamed:@"bgp.jpg"];
                    _imageView.image = background;
                    
                
                
            });
            
        }];
        [dataTask resume];
        
        
        
//to find the details of 24 hour update
{
  NSURLSession *sessiontwo = [NSURLSession sharedSession]; // Session created
  NSString *complete_urltwo = [NSString stringWithFormat:@"https://api.apixu.com/v1/forecast.json?key=34754dafe5974fe58ab95748172407&q=%f,%f",a,b]; //URL of the API
  NSURLSessionDataTask *dataTask = [sessiontwo dataTaskWithURL:[NSURL URLWithString:complete_urltwo]completionHandler:^(NSData *jsondata, NSURLResponse *response, NSError *error){
      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
      NSMutableDictionary *currentDict = [[NSMutableDictionary alloc]initWithDictionary:json[@"forecast"]];
      NSMutableArray *conDict = [currentDict valueForKey:@"forecastday"];
      NSMutableArray *tabled = [conDict valueForKey:@"hour"];
      NSMutableArray *mintemp = [tabled valueForKey:@"temp_c"];
      NSMutableArray *maxtemp = [tabled valueForKey:@"feelslike_c"];
      NSMutableArray *imageurl = [tabled valueForKey:@"condition"];
      NSMutableArray *imagearray = [imageurl valueForKey:@"icon"];
      min = mintemp[0];
      max = maxtemp[0];
      images = imagearray[0];
      finalImages = [[NSMutableArray alloc] init];
      for (int i = 0; i<images.count; i++)
          {
           NSString *eliminated = images[i];
           NSArray *sepArray = [eliminated componentsSeparatedByString:@"//cdn.apixu.com/weather/"];//transfer all the strings into a array[1]
           [finalImages addObject:sepArray[1]];//transfer the array[1] to into the arrayof i to last element.
          }
      dispatch_async(dispatch_get_main_queue(), ^{
      [self.activityIndicatorView stopAnimating];
      [self.tableView reloadData];
      });
      }];
      [dataTask resume];
      }}
    
}

//MARK: CLLocation Manager Delegates

// This method will be called whenever the location will be updated
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"location updated");
    [self viewDidLoad];
    
}


// This method will be called after the location is updated
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    NSLog(@"didUpdate Calls");
    [manager stopUpdatingLocation];
    [self viewDidLoad];
    [self viewWillAppear:YES];
}


// This method will be called when the app will get error from the location
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
    NSLog(@"error getting Location");
    NSLog(@"error is %@",error.localizedDescription);
    
    
}


// Any change in app authorisation method
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    
}

// After the view will be fully appeared
-(void)viewDidAppear:(BOOL)animated{
}

// This will run when view will disappear
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

// Action for the forecast button
- (IBAction)forecast:(id)sender {
    ForecastViewController *myfvc  = [self.storyboard instantiateViewControllerWithIdentifier:@"ForecastViewController"];
    myfvc.forecastlatitude = a;
    myfvc.forecastlongitude = b;
    myfvc.cityname=complete_name;
    [self.navigationController pushViewController:myfvc animated:true];

}


// Inorder to scroll the table view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (SimpleTableCell *cell in self.tableView.visibleCells) {
        CGFloat hiddenFrameHeight = scrollView.contentOffset.y + self.navigationController.navigationBar.frame.size.height - cell.frame.origin.y;
        if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
            [self maskCell:cell fromTopWithMargin:hiddenFrameHeight];
        }
    }
}


// Margin from the top of the table
- (void)maskCell:(UITableViewCell *)cell fromTopWithMargin:(CGFloat)margin
{
    cell.layer.mask = [self visibilityMaskForCell:cell withLocation:margin/cell.frame.size.height];
    cell.layer.masksToBounds = YES;
}

// background for header
- (CAGradientLayer *)visibilityMaskForCell:(UITableViewCell *)cell withLocation:(CGFloat)location
{
    CAGradientLayer *mask = [CAGradientLayer layer];
    mask.frame = cell.bounds;
    mask.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:1 alpha:0] CGColor], (id)[[UIColor colorWithWhite:1 alpha:1] CGColor], nil];
    mask.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:location], [NSNumber numberWithFloat:location], nil];
    return mask;
}


@end
