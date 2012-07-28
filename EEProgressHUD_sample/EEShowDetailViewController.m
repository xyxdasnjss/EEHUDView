//
//  EEShowDetailViewController.m
//  EEProgressHUD_sample
//
//  Created by Kudo Yoshiki on 12/06/16.
//  Copyright (c) 2012年 Milestoneeee.com. All rights reserved.
//

#import "EEShowDetailViewController.h"
#import "EEData.h"

@interface EEShowDetailViewController ()
{
    EEData *data_;
}
@property (nonatomic, strong) EEData *data;
@end

@implementation EEShowDetailViewController
@synthesize showViewController;
@synthesize tableView;
@synthesize type;
@synthesize data = data_;

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
    
    if (!self.data) {
        self.data = [[EEData alloc] init];
    }
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (self.type) {
        case 1:
            return [self.data countOfShowStyle];
            break;
        case 2:
            return [self.data countOfHideStyle];
            break;
        case 3:
            return [self.data countOfResultStyle];
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"detail";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    int row = indexPath.row;
    switch (self.type) {
        case 1:
            cell.detailTextLabel.text = [self.data stringShowStyle:row];
            cell.textLabel.text = [self.data abbreviatedStringShowStyle:row];
            break;
        case 2:
            cell.detailTextLabel.text = [self.data stringHideStyle:row];
            cell.textLabel.text = [self.data abbreviatedStringHideStyle:row];
            break;
        case 3:
            cell.detailTextLabel.text = [self.data stringResultStyle:row];
            cell.textLabel.text = [self.data abbreviatedStringResultStyle:row];
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int row = indexPath.row;
    switch (self.type) {
        case 1:
            [self.showViewController updateShowStyle:row];
            break;
        case 2:
            [self.showViewController updateHideStyle:row];
            break;
        case 3:
            [self.showViewController updateResultStyle:row];
            break;
        default:
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
