//
//  EEHowToViewController.m
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 12/06/24.
//  Copyright (c) 2012年 Milestoneeee.com. All rights reserved.
//

#import "EEHowToViewController.h"
#import "EEHUDView.h"

@interface EEHowToViewController ()

@end

@implementation EEHowToViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([EEHUDView isShowing]) {
        [EEHUDView growlWithMessage:@""
                          showStyle:EEHUDViewShowStyleNoAnime
                          hideStyle:EEHUDViewHideStyleFadeOut
                    resultViewStyle:EEHUDResultViewStyleNG
                           showTime:0.0];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)up:(id)sender
{
    if ([EEHUDView isShowing]) {
        [EEHUDView growlWithMessage:@"OK"
                          showStyle:EEHUDViewShowStyleNoAnime
                          hideStyle:EEHUDViewHideStyleFadeOut
                    resultViewStyle:EEHUDResultViewStyleChecked
                           showTime:1.0];
    }
}


@end
