//
//  DetailViewController.h
//  TestSplitView
//
//  Created by Rohit Kharat on 2/2/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
