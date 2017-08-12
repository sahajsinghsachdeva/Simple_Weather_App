//
//  CollectionControllerCell.h
//  Weather
//
//  Created by Amanjeet Singh on 7/6/17.
//  Copyright © 2017 Apptunix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionControllerCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *DateLabel;
@property (strong, nonatomic) IBOutlet UILabel *minLabel;
@property (strong, nonatomic) IBOutlet UILabel *minOutputLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxOutputLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@end
