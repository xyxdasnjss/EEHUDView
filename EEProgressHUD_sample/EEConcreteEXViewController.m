//
//  EEConcreteEXViewController.m
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 12/06/16.
//  Copyright (c) 2012年 Milestoneeee.com. All rights reserved.
//

#import "EEConcreteEXViewController.h"
#import "EEHUDView.h"
#import "AppDelegate.h"

@interface EEConcreteEXViewController ()
{
    int count;
}

- (void)countDown:(NSTimer *)timer;
@end

@implementation EEConcreteEXViewController

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
    
    count = 3;
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
    NSInteger countInteger = [super numberOfSectionsInTableView:tableView];
    return countInteger;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int countInteger = [super tableView:tableView numberOfRowsInSection:section];
    return countInteger;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    int section = indexPath.section;
    
    switch (section) {
        case 0: // Always Show
            
            [(AppDelegate *)[UIApplication sharedApplication].delegate countUpIgnoringCounter];
            
            /***
             表示
             ***/
            [EEHUDView growlWithMessage:@"Always Show"
                              showStyle:EEHUDViewShowStyleNoAnime
                              hideStyle:EEHUDViewHideStyleFadeOut
                        resultViewStyle:EEHUDResultViewStyleChecked
                               showTime:3.0];
            
            /***
             PUSH
             ***/
            
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [self performSegueWithIdentifier:@"pushAlwaysShow" sender:nil];
                
                [(AppDelegate *)[UIApplication sharedApplication].delegate countDownIgnoringCounter];
            });
            
            break;
            
        case 1: // Count Down
            
            /***
             EEHUDViewは表示中に再び呼ばれるとresultViewStyleとmessageが瞬時に入れ替わります。またshowTimeは後から指定した物に更新されます。この特徴をいかし、カウントダウン表示を行います。
             ***/
            
            [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(countDown:)
                                           userInfo:nil
                                            repeats:YES];
            
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            break;
        
        default:
            
            NSLog(@"default");
            
            break;
    }
    
    
}


#pragma mark - Private
- (void)countDown:(NSTimer *)timer
{
    if (count == 3) {[(AppDelegate *)[UIApplication sharedApplication].delegate countUpIgnoringCounter];}
    if (count == 0) {
        
        [timer invalidate];
        
        [(AppDelegate *)[UIApplication sharedApplication].delegate countDownIgnoringCounter];
    }
    
    NSString *message;
    CGFloat showTime;
    EEHUDResultViewStyle resultViewStyle;
    
    switch (count) {
        case 3:
            
            message = @"countdown";
            showTime = 100;         // 今回は1secより長ければOK
            resultViewStyle = EEHUDResultViewStyleThree;
            
            break;
        case 2:
            
            message = @"countdown";
            showTime = 100;         // 今回は1secより長ければOK
            resultViewStyle = EEHUDResultViewStyleTwo;
            
            break;
            
        case 1:
            
            message = @"countdown";
            showTime = 100;         // 今回は1secより長ければOK
            resultViewStyle = EEHUDResultViewStyleOne;
            
            break;
        
        default:
            
            message = @"Finished";
            showTime = 1.5;         // 最後の時間は余韻時間をきっちり指定しておく。
            resultViewStyle = EEHUDResultViewStyleExclamation;
            
            break;
    }
    
    [EEHUDView growlWithMessage:message
                      showStyle:EEHUDViewHideStyleNoAnime
                      hideStyle:EEHUDViewHideStyleFadeOut
                resultViewStyle:resultViewStyle
                       showTime:showTime];
    
    // 
    if (count > 0) {
        count--;
    }else {
        count = 3;
    }
    
}
#pragma mark - Dealloc
- (void)dealloc
{
    
    
    [super dealloc];
}

@end
