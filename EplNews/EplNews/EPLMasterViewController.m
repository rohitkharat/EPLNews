//
//  EPLMasterViewController.m
//  EplNews
//
//  Created by Rohit Kharat on 2/2/14.
//  Copyright (c) 2014 Rohit Kharat. All rights reserved.
//

#import "EPLMasterViewController.h"

#import "EPLDetailViewController.h"

@interface EPLMasterViewController () {
    NSMutableArray *_objects;
}
@end


@implementation EPLMasterViewController

@synthesize siteNames;
@synthesize siteAddress;
@synthesize url;
@synthesize urlString;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    visitedSites = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view, typically from a nib.
    //    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    siteNames = [[NSArray alloc] initWithObjects:@"Premier League",
                 @"BBC Sport",
                 @"Goal",
                 @"Fox Sports",
                 @"Sky Sports",
                 @"ESPN FC",
                 @"Bleacher Report",
                 @"The Telegraph",
                 @"Football365",
                 nil];
    
    siteAddress = [[NSArray alloc]
                   initWithObjects:@"http://www.premierleague.com/en-gb/news.html",
                   @"http://www.bbc.com/sport/0/football/premier-league/",
                   @"http://www.goal.com/en/news/9/england", @"http://msn.foxsports.com/foxsoccer/premierleague",
                   @"http://www1.skysports.com/football/competitions/premier-league",
                   @"http://espnfc.com/league/_/id/eng.1/english-premier-league",
                   @"http://bleacherreport.com/epl",
                   @"http://www.telegraph.co.uk/sport/football/",
                   @"http://www.football365.com/premier-league",
                   nil];
    
    //    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (EPLDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.opaque = NO;
    //self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blue-gradient.png"]];
    
    if (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) && [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        self.tableView.backgroundView.alpha = 0.5;
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHue:0.57 saturation:0.9 brightness:0.57 alpha:1];
    self.detailViewController.navigationController.navigationBar.barTintColor = [UIColor colorWithHue:0.57 saturation:0.9 brightness:0.57 alpha:1];
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.detailViewController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.detailViewController.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    // self.navigationItem.backBarButtonItem.title = @"SOURCE";
    
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = self.navigationItem.title;
    // emboss in the same way as the native title
    [label setShadowColor:[UIColor darkGrayColor]];
    [label setShadowOffset:CGSizeMake(0, -0.5)];
    self.navigationItem.titleView = label;
    
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    //self.detailViewController.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
}

- (void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBar.topItem.title = @"EPL News Hub";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        //NSLog(@"portrait ipad");
        self.tableView.backgroundView.alpha = 0.5;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return siteNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //NSDate *object = _objects[indexPath.row];
    //cell.textLabel.text = [object description];
    
    cell.textLabel.text = [siteNames objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    //cell.textLabel.textColor = [UIColor blackColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([visitedSites containsObject:indexPath])
    {
        cell.textLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:25];
        cell.textLabel.textColor = [UIColor colorWithHue:0.57 saturation:0.9 brightness:0.7 alpha:1];

    }
    else
    {
        cell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:20];
        cell.textLabel.textColor = [UIColor colorWithHue:0.57 saturation:0.9 brightness:0.57 alpha:1];

    }
    
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return NO;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}


// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//    
//}



// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath
{
    if ([visitedSites containsObject:indexPath] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return 70;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [visitedSites removeAllObjects];
    [visitedSites addObject:indexPath];
    [tableView reloadData];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.urlString = [siteAddress objectAtIndex:indexPath.row];
        //NSLog(@"site selected = %@", [siteNames objectAtIndex:indexPath.row]);
        
        self.url = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
        self.detailViewController.webView.scalesPageToFit = YES;
        [self.detailViewController.webView loadRequest:request];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *object = self.siteAddress[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
