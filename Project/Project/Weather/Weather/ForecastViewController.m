//
//  ForecastViewController.m
//  Weather
//
//  Created by Sahaj Singh on 7/14/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import "ForecastViewController.h"
#import "Forecast_Cell.h"
#import "ViewController.h"
@interface ForecastViewController ()

{
    NSMutableArray *dated;
    NSMutableArray *min;
    NSMutableArray *max;
    NSMutableArray *status; // Array to store status of the week
    NSMutableArray *images; // Array to store the weather icon of the week
    NSMutableArray *prec; // Array to store precipitation details of the week
    NSMutableArray *humid; // Array to store humidity of the week
    NSMutableArray *winspd; // Array to store windspeed of the week
    NSMutableArray *finaldate; //Array to store dates of the week
    NSMutableArray *finaldays; //Array to store days of the week
    NSMutableArray *finalmintempincel; // Array to store minimum temperature of the week
NSMutableArray *finalmaxtempincel; //Array to store maximum temperature of the week
    float a; //To store latitude
    float b;// To store longitude
}
@end

@implementation ForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating]; // Start the activity indicator until the data is processed
    a = _forecastlatitude;
    b = _forecastlongitude;
    _cityLabel.text = _cityname; // Setting up the city name in the label
    
    //Session started
    NSURLSession *sessiontwo = [NSURLSession sharedSession];
    NSString *complete_urltwo = [NSString stringWithFormat:@"https://api.darksky.net/forecast/b31c3a3e8e889445ac4434da52c69c70/%f,%f",a,b]; //Url of the API
    NSURLSessionDataTask *dataTask = [sessiontwo dataTaskWithURL:[NSURL URLWithString:complete_urltwo]completionHandler:^(NSData *jsondata, NSURLResponse *response, NSError *error){
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
            NSMutableDictionary *currentDict = [[NSMutableDictionary alloc]initWithDictionary:json[@"daily"]];
            NSMutableArray *conDict = [currentDict valueForKey:@"data"];
            NSMutableArray *timed = [conDict valueForKey:@"time"];
            NSMutableArray *minte = [conDict valueForKey:@"temperatureMin"];
            NSMutableArray *maxte = [conDict valueForKey:@"temperatureMax"];
            NSMutableArray *statuste = [conDict valueForKey:@"summary"];
            NSMutableArray *humidityte = [conDict valueForKey:@"humidity"];
            NSMutableArray *precite = [conDict valueForKey:@"precipProbability"];
            NSMutableArray *winspdte = [conDict valueForKey:@"windSpeed"];
            NSMutableArray *icon = [conDict valueForKey:@"icon"];
            
            //Providing space and initialising them with the json returned array
            images = [[NSMutableArray alloc]initWithArray:icon];
            dated = [[NSMutableArray alloc]initWithArray:timed];
            min = [[NSMutableArray alloc]initWithArray:minte];
            max = [[NSMutableArray alloc]initWithArray:maxte];
            status = [[NSMutableArray alloc]initWithArray:statuste];
            humid = [[NSMutableArray alloc]initWithArray:humidityte];
            prec = [[NSMutableArray alloc]initWithArray:precite];
            winspd = [[NSMutableArray alloc]initWithArray:winspdte];
            NSMutableArray *final_date = [[NSMutableArray alloc]init];
            NSMutableArray *mincel = [[NSMutableArray alloc]init];
            NSMutableArray *maxcel = [[NSMutableArray alloc]init];
        
        //Converting unix time (that we got from json data) to human readable format
            for(int z = 0;z<[dated count];z++){
                double unixTimeStamp = [[dated objectAtIndex:z] doubleValue];
                NSTimeInterval _interval = unixTimeStamp;
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setLocale:[NSLocale currentLocale]];
                [formatter setDateFormat:@"dd.MM.yyyy"];
                NSString *dateString = [formatter stringFromDate:date];
                [final_date addObject:dateString];
        
        // Converting f temp into c
                float mintempinf = [[min objectAtIndex:z]floatValue];
                float mintempincel = ((mintempinf-32)*0.55);
                NSString *finalmintemp = [[NSString alloc]initWithFormat:@"%.2f",mintempincel ];
                [mincel addObject:finalmintemp];
                
                float maxtempinf = [[max objectAtIndex:z]floatValue];
                float maxtempincel = ((maxtempinf-32)*0.55);
                NSString *finalmaxtemp = [[NSString alloc]initWithFormat:@"%.2f",maxtempincel ];
                [maxcel addObject:finalmaxtemp];
            
            }
        
        //Providing space and initialising them with the json returned array
        finaldate = [[NSMutableArray alloc]initWithArray:final_date];
        finalmintempincel = [[NSMutableArray alloc]initWithArray:mincel];
        finalmaxtempincel = [[NSMutableArray alloc]initWithArray:maxcel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        [self.tableView reloadData];
        });
            
        }];
        [dataTask resume];
    // Calculating next week days from present day
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"EEEE"];
    NSDate *now = [NSDate date];
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:7];
    for (int i = 1; i <= 7; i++)
    {
        NSDate *date = [NSDate dateWithTimeInterval:(i * (60 * 60 * 24)) sinceDate:now];
        [results addObject:[dateformatter stringFromDate:date]];
    }
    finaldays=[[NSMutableArray alloc]initWithArray:results];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// To manupulate searchbar visibility according to the background of the view
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



//Number of rows in the section
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
    
}


// Defining cells and its values for the rows of the week forecast table
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"Forecast_Cell"; //Initialising cell Identifier
    Forecast_Cell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Forecast_Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 410, 3)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor whiteColor];// you can also put image here
    [cell.contentView addSubview:separatorLineView];

    
    if(indexPath.row==0||indexPath.row==2||indexPath.row==4||indexPath.row==6){
        cell.contentView.backgroundColor = [UIColor colorWithRed:202/255.0f green:120/255.0f blue:69/255.0f alpha:1.0f];

    }else{
        cell.contentView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];

    }
    
    // alternate colour to each row
    
    //check for climate conditions for icon
    NSRange range = [[NSString stringWithFormat:@"%@",[images objectAtIndex:indexPath.row+1]] rangeOfString:@"rain"];
    NSRange rangeone = [[NSString stringWithFormat:@"%@",[images objectAtIndex:indexPath.row+1]] rangeOfString:@"cloudy"];
    NSRange rangetwo = [[NSString stringWithFormat:@"%@",[images objectAtIndex:indexPath.row+1]] rangeOfString:@"clear"];

    if (range.location!=NSNotFound) {
        cell.Status_Image.image = [UIImage imageNamed:@"64x64/day/356.png"];
    }
    else if (rangeone.location!=NSNotFound) {
        cell.Status_Image.image = [UIImage imageNamed:@"64x64/day/116.png"];
    }
    else if (rangetwo.location!=NSNotFound) {
        cell.Status_Image.image = [UIImage imageNamed:@"64x64/day/113.png"];
    }
    else{
        NSLog(@"Not Rain");    }
    
    
    
// Setting up the labels of the view according to the json data
    cell.Date_field.text = [NSString stringWithFormat:@"%@",[finaldate objectAtIndex:indexPath.row+1]]; // Setting up the date to the label
    cell.Min_field.text = [NSString stringWithFormat:@"%@\u00b0C",[finalmintempincel objectAtIndex:indexPath.row+1]]; // Setting up the minimum temperature to the label
    cell.Max_field.text = [NSString stringWithFormat:@"%@\u00b0C",[finalmaxtempincel objectAtIndex:indexPath.row+1]]; // Setting up the maximum temperature to the label
    cell.Status_Field.text = [NSString stringWithFormat:@"%@",[status objectAtIndex:indexPath.row+1]]; // Setting up the status to the label
    cell.Humidity_Value.text = [NSString stringWithFormat:@"%@",[humid objectAtIndex:indexPath.row+1]]; // Setting up the humidity to the label
    cell.Precipitation_Value.text = [NSString stringWithFormat:@"%@",[prec objectAtIndex:indexPath.row+1]]; // Setting up the precipitation to the label
    cell.Wind_Value.text = [NSString stringWithFormat:@"%@",[winspd objectAtIndex:indexPath.row+1]]; // Setting up the wind speed to the label
    cell.Day.text = [NSString stringWithFormat:@"(%@)",[finaldays objectAtIndex:indexPath.row]]; // Setting up the day to the label

    return cell;
}
-(void)viewWillAppear:(BOOL)animated{

}

@end
