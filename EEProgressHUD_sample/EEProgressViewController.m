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
@property (nonatomic, weak) NSTimer *timer;
- (void)continuousCountUPHUD:(NSTimer *)timer;
@end

@implementation EEProgressViewController

@synthesize timer = _timer;

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
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = indexPath.section;
    switch (section) {
        case 0:

            [EEHUDView showProgressWithMessage:@"is Downloading..."
                                     showStyle:EEHUDViewShowStyleFadeIn
                             activityViewStyle:EEHUDActivityViewStyleBeat];
            
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                          target:self
                                                        selector:@selector(continuousCountUPHUD:)
                                                        userInfo:nil
                                                         repeats:YES];
            
            [(AppDelegate *)[UIApplication sharedApplication].delegate countUpIgnoringCounter];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            break;
            
        case 1:
            
            [EEHUDView showProgressWithMessage:@"is Downloading..."
                                     showStyle:EEHUDViewShowStyleFadeIn
                             activityViewStyle:EEHUDActivityViewStyleElectrocardiogram];
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.07
                                                          target:self
                                                        selector:@selector(continuousCountUPHUD:)
                                                        userInfo:nil
                                                         repeats:YES];
            
            double delayInSeconds = 1.2;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [EEHUDView growlWithMessage:@"tweeted!"
                                  showStyle:EEHUDViewShowStyleFadeIn
                                  hideStyle:EEHUDViewHideStyleFadeOut
                            resultViewStyle:EEHUDResultViewStyleTweet
                                   showTime:1.5];
            });
            
            [(AppDelegate *)[UIApplication sharedApplication].delegate countUpIgnoringCounter];
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            
            break;            
        default:
            break;
    }
}

#pragma mark - Private
- (void)continuousCountUPHUD:(NSTimer *)timer
{
    if (progress_ >= 1.0) {
        
        [self.timer invalidate];
        self.timer = nil;
        
        [EEHUDView hideProgressWithMessage:@"Finished"
                                 hideStyle:EEHUDViewHideStyleFadeOut
                           resultViewStyle:EEHUDResultViewStyleChecked
                                  showTime:1.5];
        
        [(AppDelegate *)[UIApplication sharedApplication].delegate countDownIgnoringCounter];
        progress_ = 0.0;
        
    }else {
        
        [EEHUDView updateProgress:progress_];
        
        //
        if (progress_ >= 1.0) {
            progress_ = 1.0;
        }else {
            progress_ += 0.01;
        }
    }
    
}

@end
