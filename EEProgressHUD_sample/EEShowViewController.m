//
//  EEShowViewController.m
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 12/06/16.
//  Copyright (c) 2012年 Milestoneeee.com. All rights reserved.
//

#import "EEShowViewController.h"
#import "EEShowDetailViewController.h"
#import "EEData.h"

@interface EEShowViewController () 
{
    EEData *data_;
}

@property (nonatomic) EEHUDViewShowStyle showStyle;
@property (nonatomic) EEHUDViewHideStyle hideStyle;
@property (nonatomic) EEHUDResultViewStyle resultStyle;

@property (nonatomic, strong) EEData *data;
@end

@implementation EEShowViewController
@synthesize showStyle, hideStyle, resultStyle;
@synthesize data = data_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.showStyle = EEHUDViewShowStyleFadeIn;
    self.hideStyle = EEHUDViewHideStyleCrush;
    self.resultStyle = EEHUDResultViewStyleOK;
    
    if (!self.data) {
        EEData *dataObject = [[EEData alloc] init];
        self.data = dataObject;
    }
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [super numberOfSectionsInTableView:tableView];
    //return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [super tableView:tableView numberOfRowsInSection:section];
    //return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.reuseIdentifier isEqualToString:@"showStyle"]) {
        cell.detailTextLabel.text = [self.data stringShowStyle:self.showStyle];
        cell.textLabel.text = [self.data abbreviatedStringShowStyle:self.showStyle];
    }else if ([cell.reuseIdentifier isEqualToString:@"hideStyle"]) {
        cell.detailTextLabel.text = [self.data stringHideStyle:self.hideStyle];
        cell.textLabel.text = [self.data abbreviatedStringHideStyle:self.hideStyle];
    }else if ([cell.reuseIdentifier isEqualToString:@"resultStyle"]) {
        cell.detailTextLabel.text = [self.data stringResultStyle:(self.resultStyle-1)];
        cell.textLabel.text = [self.data abbreviatedStringResultStyle:(self.resultStyle-1)];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
    }else {
        [EEHUDView growlWithMessage:@"test message"
                          showStyle:self.showStyle
                          hideStyle:self.hideStyle
                    resultViewStyle:self.resultStyle
                           showTime:1.5];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    int section = indexPath.section;
    
    EEShowDetailViewController *nextViewController;
    nextViewController = (EEShowDetailViewController *)segue.destinationViewController;
    nextViewController.showViewController = self;
    nextViewController.type = section;
}

- (void)updateShowStyle:(int)newShowStyle
{
    self.showStyle = newShowStyle;
    [self.tableView reloadData];
}

- (void)updateHideStyle:(EEHUDViewHideStyle)newHideStyle
{
    self.hideStyle = newHideStyle;
    [self.tableView reloadData];
}

- (void)updateResultStyle:(EEHUDResultViewStyle)newResultStyle
{
    newResultStyle++;
    self.resultStyle = newResultStyle;
    [self.tableView reloadData];
}

@end
