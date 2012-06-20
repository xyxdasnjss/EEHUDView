//
//  EEProgressViewController.m
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 12/06/20.
//  Copyright (c) 2012年 Milestoneeee.com. All rights reserved.
//

#import "EEProgressViewController.h"
#import "EEHUDView.h"
#import "AppDelegate.h"

@interface EEProgressViewController ()
{
    float progress_;
}

- (void)continuousCountUPHUD:(NSTimer *)timer;
@end

@implementation EEProgressViewController

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
    
    progress_ = 0.0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //return 0;
    
    NSInteger count = [super numberOfSectionsInTableView:tableView];
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 0;
    NSInteger count = [super tableView:tableView numberOfRowsInSection:section];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    
//    return cell;
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = indexPath.section;
    switch (section) {
        case 0:
            
            [NSTimer scheduledTimerWithTimeInterval:0.03
                                             target:self
                                           selector:@selector(continuousCountUPHUD:)
                                           userInfo:nil
                                            repeats:YES];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            break;
            
        default:
            break;
    }
}

#pragma mark - Private
- (void)continuousCountUPHUD:(NSTimer *)timer
{
    //NSLog(@"%s", __func__);
    
    if (progress_ <= 0.0) {
        [(AppDelegate *)[UIApplication sharedApplication].delegate countUpIgnoringCounter];
    }else if (progress_ >= 1.0) {
        [(AppDelegate *)[UIApplication sharedApplication].delegate countDownIgnoringCounter];
        
        [timer invalidate];
    }
    
    [EEHUDView progressWithMessage:@"is Downloading..."
                         showStyle:EEHUDViewShowStyleFadeIn
                         hideStyle:EEHUDViewHideStyleFadeOut
                 progressViewStyle:EEHUDProgressViewStyleBar
                          progress:progress_];
    
    //
    if (progress_ >= 1.0) {
        progress_ = 0.0;
    }else {
        progress_ += 0.01;
    }
    
    
}

@end
