//
//  MasterViewController.h
//  TestSplitView
//
//  Created by Rohit Kharat on 2/2/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
