//
//  EPLDetailViewController.h
//  EplNews
//
//  Created by Rohit Kharat on 2/2/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface EPLDetailViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate,ADBannerViewDelegate>

@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *refreshButton;


@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
//@property (strong, nonatomic) IBOutlet ADBannerView *adView;

-(IBAction)reloadPage:(id)sender;
-(IBAction)previousPage:(id)sender;
-(void)back;


@end
