//
//  EPLDetailViewController.m
//  EplNews
//
//  Created by Rohit Kharat on 2/2/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import "EPLDetailViewController.h"
#import <iAd/iAd.h>
#import "BannerViewController.h"


@interface EPLDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *bottomConstraint;

- (void)configureView;
@end

@implementation EPLDetailViewController
{
    ADBannerView *_bannerView;
}
//@synthesize webView2;
@synthesize urlString;
@synthesize webView;



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
    
//-------------------------
    //iAds
    self.canDisplayBannerAds = YES;
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        _bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    } else {
        _bannerView = [[ADBannerView alloc] init];
    }
    _bannerView.delegate = self;
    [self.view addSubview:_bannerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:)name:UIDeviceOrientationDidChangeNotification object:nil];
//--------------------------
    
    
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
    label.text = @"EPL News Hub";
    // emboss in the same way as the native title
    [label setShadowColor:[UIColor darkGrayColor]];
    [label setShadowOffset:CGSizeMake(0, -0.5)];
    self.navigationItem.titleView = label;

    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHue:0.57 saturation:0.9 brightness:0.57 alpha:1];
        
       }
    

}


-(void)didRotate:(NSNotification *)notification
{
    NSLog(@"did Rotate");
    
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

- (void)layoutAnimated:(BOOL)animated
{
    CGRect contentFrame = self.view.bounds;
    
    // all we need to do is ask the banner for a size that fits into the layout area we are using
    CGSize sizeForBanner = [_bannerView sizeThatFits:contentFrame.size];
    
    // compute the ad banner frame
    CGRect bannerFrame = _bannerView.frame;
    if (_bannerView.bannerLoaded) {
        
        // bring the ad into view
        contentFrame.size.height -= sizeForBanner.height;   // shrink down content frame to fit the banner below it
        bannerFrame.origin.y = contentFrame.size.height;
        bannerFrame.size.height = sizeForBanner.height;
        bannerFrame.size.width = sizeForBanner.width;
        
        // if the ad is available and loaded, shrink down the content frame to fit the banner below it,
        // we do this by modifying the vertical bottom constraint constant to equal the banner's height
        //
        NSLayoutConstraint *verticalBottomConstraint = self.bottomConstraint;
        verticalBottomConstraint.constant = sizeForBanner.height;
        [self.view layoutSubviews];
        
    } else {
        // hide the banner off screen further off the bottom
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        self.webView.frame = contentFrame;
        [self.webView layoutIfNeeded];
        _bannerView.frame = bannerFrame;
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self layoutAnimated:NO];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
#endif

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLayoutSubviews
{
    [self layoutAnimated:[UIView areAnimationsEnabled]];
    NSLog(@"viewDidLayoutSubviews");
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"bannerViewDidLoadAd");
    
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"didFailToReceiveAdWithError %@", error);
    [self layoutAnimated:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"bannerViewActionShouldBegin");
    
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"bannerViewActionDidFinish");
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
