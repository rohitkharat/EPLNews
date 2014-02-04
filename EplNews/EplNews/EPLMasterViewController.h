//
//  EPLMasterViewController.h
//  EplNews
//
//  Created by Rohit Kharat on 2/2/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPLDetailViewController;

@interface EPLMasterViewController : UITableViewController

{
    NSMutableArray *visitedSites;
}

@property (nonatomic, retain) NSArray *siteNames;
@property (nonatomic, retain) NSArray *siteAddress;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic ,retain) NSURL *url;

@property (strong, nonatomic) EPLDetailViewController *detailViewController;

@end
