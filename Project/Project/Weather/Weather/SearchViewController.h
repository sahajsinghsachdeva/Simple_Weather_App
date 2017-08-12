//
//  SearchViewController.h
//  Weather
//
//  Created by Sahaj Singh on 7/13/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate>{
    IBOutlet UITableView *tableView;
    IBOutlet UISearchBar *searchBar;
    NSArray *allItems;
    NSMutableArray *displayedarray;
    IBOutlet UIImageView *imageView;
    

}


@end
