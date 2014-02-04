//
//  EPLDetailViewController.m
//  EplNews
//
//  Created by Rohit Kharat on 2/2/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import "EPLDetailViewController.h"
#import <iAd/iAd.h>

@interface EPLDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation EPLDetailViewController

//@synthesize webView2;
@synthesize urlString;

#pragma mark - Managing the detail item

//- (void)setUrl:(NSURL *)urlOfPage
//{
//    NSLog(@"set url");
//    if (self.url != urlOfPage) {
//        NSLog(@"inside if");
//        self.url = urlOfPage;
//        
//        // Update the view.
//        [self configureView];
//    }
//
//    if (self.masterPopoverController != nil) {
//        [self.masterPopoverController dismissPopoverAnimated:YES];
//    }        
//}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}


- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        NSLog(@"configuring view");
        self.urlString = [self.detailItem description];
        NSLog(@"url string %@", self.urlString);
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        self.webView.scalesPageToFit = YES;
        [self.webView loadRequest:request];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:self.refreshButton, self.backButton, nil];
    self.navigationController.toolbarHidden = YES;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.urlString = @"http://www.premierleague.com/";
    }
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:request];
    
    self.navigationController.navigationBar.topItem.title = @"";
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

    UIImage *backButtonImage = [UIImage imageNamed:@"list.png"];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]init];
    barButtonItem.image = backButtonImage;
    self.navigationItem.backBarButtonItem.image = backButtonImage;
   // barButtonItem.image = backButtonImage;
    
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                       initWithImage:backButtonImage
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(back)];
    
    
    self.navigationItem.backBarButtonItem = backButton;
    
      [self.navigationItem setLeftBarButtonItem:backButton animated:YES];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"EPL News";
    // emboss in the same way as the native title
    [label setShadowColor:[UIColor darkGrayColor]];
    [label setShadowOffset:CGSizeMake(0, -0.5)];
    self.navigationItem.titleView = label;

    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHue:0.57 saturation:0.9 brightness:0.57 alpha:1];
        
        //iAds
        self.canDisplayBannerAds = YES;
        //ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
        //adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        //[self.view addSubview:adView];
        
}

}

-(void)back
{
    NSLog(@"back");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
   // barButtonItem.title = NSLocalizedString(@"Source", @"Source");
    
    
//    CGRect frame = CGRectMake(0, 0, 100, 44);
//    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor];
//    label.text = @"Source";
//    // emboss in the same way as the native title
//    [label setShadowColor:[UIColor darkGrayColor]];
//    [label setShadowOffset:CGSizeMake(0, -0.5)];
//    
//    
//    [barButtonItem setCustomView:label];

    UIImage *backButtonImage = [UIImage imageNamed:@"list.png"];
    
    barButtonItem.image = backButtonImage;
    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
//                                   initWithImage:backButtonImage
//                                   style:UIBarButtonItemStylePlain
//                                   target:nil
//                                   action:nil];
    
    
    //self.navigationItem.backBarButtonItem = backButton;
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];

    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	// starting the load, show the activity indicator in the status bar
    NSLog(@"did start load page");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	// finished loading, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(IBAction)reloadPage:(id)sender
{
    [self.webView reload];
}

-(IBAction)previousPage:(id)sender
{
    [self.webView goBack];
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self.view addSubview:banner];
    [self.view layoutIfNeeded];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"error: %@", error);
    [banner removeFromSuperview];
    [self.view layoutIfNeeded];
}



@end
