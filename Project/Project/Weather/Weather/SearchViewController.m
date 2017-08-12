//
//  SearchViewController.m
//  Weather
//
//  Created by Sahaj Singh on 7/13/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import "SearchViewController.h"
#import "ViewController.h"
@interface SearchViewController (){
    NSMutableArray *cityname;
    NSMutableArray *discityname;
    NSMutableArray *countrynames; // to store city name
    NSMutableArray *discountryname; // to store country name
    NSMutableArray *latitudenames; // to store latitude
    NSMutableArray *longitudenames; // to store longitude
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *background = [UIImage imageNamed:@"background.jpg"];
    imageView.image = background; //background image
    
    // Providing memory to the mutable arrays
    cityname = [[NSMutableArray alloc]init];
    discityname = [[NSMutableArray alloc]initWithArray:cityname];
    countrynames = [[NSMutableArray alloc]init];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }


//Number of sections in the tabe view
-(NSInteger)numberOfSectionsInTableView:(UITableView *)atableView{
    return 1;
}


// Number of rows in the table view
-(NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section{
    return discityname.count;
}


// Initialising cells with the json result values
-(UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@",[discityname objectAtIndex:indexPath.row],[discountryname objectAtIndex:indexPath.row]]; // Setting up the city name along with the country name in the cell
    return cell;
}


//When the user will click on the any row than the following action will occur
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger rowno = indexPath.row;
    ViewController *myVc  = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    myVc.newlatitude = [[latitudenames objectAtIndex:rowno]floatValue]; // Sending the latitude of the selected city to the first view controller
    myVc.newlongitude = [[longitudenames objectAtIndex:rowno]floatValue]; // Sending the longitude of the selected city to the first view controller
    myVc.status = 1;  // Sending the status to the first view controller
    [self.navigationController pushViewController:myVc animated:true];

}
-(void)searchBar:(UISearchBar *)asearchBar textDidChange:(NSString *)searchText{
   /* UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    [searchBar addSubview: spinner];
    [spinner startAnimating];
    [spinner sizeToFit];
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;*/

    if ([searchText length] <= 1) // Check that if searchbar have more than one value or not
        return;
    if ([searchText length]==0)// Check that if searchbar have no values
    {
        [discityname removeAllObjects];
        [discityname addObjectsFromArray:cityname];
    }
    else
    {
        [discityname removeAllObjects];
        
        
        //Session started
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *complete_url = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20geo.places%%20where%%20text%%3D%%22%@%%25%%22&format=json&diagnostics=true&callback=",searchText]; // URL of the API key
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:complete_url]completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableDictionary *currentDict = [[NSMutableDictionary alloc]initWithDictionary:json[@"query"]];
            int a = [[currentDict valueForKey:@"count"] intValue];
            if (a!=0) {
                cityname = [[NSMutableArray alloc]init];
                countrynames = [[NSMutableArray alloc]init];
                NSMutableDictionary *conDict = [[NSMutableDictionary alloc]initWithDictionary:currentDict[@"results"]];
                NSMutableArray *places = [[NSMutableArray alloc]init];
                NSMutableArray *country = [[NSMutableArray alloc]init];
                NSMutableArray *centroid = [[NSMutableArray alloc]init];
                NSMutableArray *latitude = [[NSMutableArray alloc]init];
                NSMutableArray *longitude = [[NSMutableArray alloc]init];
                // Check whether the json is in dictionary format or array format
                if ([[conDict valueForKey:@"place"] isKindOfClass:[NSArray class]])
                {
                    //Setting up the places
                    places = [conDict valueForKey:@"place"];
                    NSString *placename = [NSString new];
                    for (int i = 0; i<places.count; i++) {
                        placename = [places[i] valueForKey:@"name"];
                        [cityname addObject:placename];
                      }
                    
                    //Setting up the country
                    country = [places valueForKey:@"country"];
                    NSString *countryname = [NSString new];
                    for (int i = 0; i<country.count; i++)
                    {
                        countryname = [country[i] valueForKey:@"content"];
                        [countrynames addObject:countryname];
                    }
                    
                    //Setting up latitude and longitude
                    centroid = [places valueForKey:@"centroid"];
                    latitude = [centroid valueForKey:@"latitude"];
                    longitude = [centroid valueForKey:@"longitude"];
                    
                }
                
                else
                {
                    //Setting up the city
                    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithDictionary:conDict[@"place"]];
                    NSString *singlecityname = [NSString new];
                    singlecityname = [dictionary valueForKey:@"name"];
                    [cityname addObject:singlecityname];
                    
                    //Setting up the country
                    NSMutableDictionary *nary = [[NSMutableDictionary alloc]initWithDictionary:dictionary[@"country"]];
                    NSString *singlecountryname = [NSString new];
                    singlecountryname = [nary valueForKey:@"content"];
                    [countrynames addObject:singlecountryname];
                    
                    
                    //Setting up the latitude and longitude
                    centroid = [dictionary valueForKey:@"centroid"];
                    NSString *singlelatitude = [NSString new];
                    singlelatitude = [centroid valueForKey:@"latitude"];
                    [latitude addObject:singlelatitude];
                    NSString *singlelongitude = [NSString new];
                    singlelongitude = [centroid valueForKey:@"longitude"];
                    [longitude addObject:singlelongitude];
                    
                    
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    discityname = [[NSMutableArray alloc]initWithArray:cityname];
                    discountryname = [[NSMutableArray alloc]initWithArray:countrynames];
                    latitudenames = [[NSMutableArray alloc]initWithArray:latitude];
                    longitudenames = [[NSMutableArray alloc]initWithArray:longitude];
                    [tableView reloadData];
                });
            }
        }];
        [dataTask resume];
        for (NSString *string in discityname) {
            NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location!=NSNotFound) {
                [discityname addObject:string];
            }
        }
    }
    [tableView reloadData];
}

@end
