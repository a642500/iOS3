/**
 * @file AboutTableViewController.m
 * @brief View controller that show info about us
 *
 * (c) 2013-2015 by Mega Limited, Auckland, New Zealand
 *
 * This file is part of the MEGA SDK - Client Access Engine.
 *
 * Applications using the MEGA API must present a valid application key
 * and comply with the the rules set forth in the Terms of Service.
 *
 * The MEGA SDK is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * @copyright Simplified (2-clause) BSD License.
 *
 * You should have received a copy of the license along with this
 * program.
 */

#import "AboutTableViewController.h"
#import "TermsOfServiceViewController.h"
#import "MEGASdkManager.h"

@interface AboutTableViewController () {
    int megaSdkVersionCounter;
    int versionCounter;
}

@property (weak, nonatomic) IBOutlet UILabel *privacyPolicyLabel;
@property (weak, nonatomic) IBOutlet UILabel *termsOfServicesLabel;
@end

@implementation AboutTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.privacyPolicyLabel setText:NSLocalizedString(@"privacyPolicyLabel", nil)];
    [self.termsOfServicesLabel setText:NSLocalizedString(@"termsOfServicesLabel", nil)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    megaSdkVersionCounter = 0;
    versionCounter = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath row] == 0) {
        megaSdkVersionCounter = 0;
        versionCounter++;
        NSLog(@"%d", versionCounter);
        if (versionCounter == 5) {
            versionCounter = 0;
            UIAlertView *gApiAlertView = [[UIAlertView alloc] initWithTitle:@"Switching api server" message:@"Do you want switch to 'https://g.api.mega.co.nz/'?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            gApiAlertView.tag = 0;
            [gApiAlertView show];
        }
    }
    
    if ([indexPath row] == 1) {
        versionCounter = 0;
        megaSdkVersionCounter++;
        NSLog(@"%d", megaSdkVersionCounter);
        if (megaSdkVersionCounter == 5) {
            megaSdkVersionCounter = 0;
            
            UIAlertView *stagingApiAlertView = [[UIAlertView alloc] initWithTitle:@"Switching api server" message:@"Do you want switch to 'https://staging.api.mega.co.nz/'?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            stagingApiAlertView.tag = 1;
            [stagingApiAlertView show];
        }
    }
    
    if ([indexPath row] == 3) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TermsOfServiceViewController *termsOfServicesViewController = [storyboard instantiateViewControllerWithIdentifier:@"termsOfServiceID"];
        [self.navigationController pushViewController:termsOfServicesViewController animated:YES];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (alertView.tag == 0) {
            [[MEGASdkManager sharedMEGASdk] changeApiUrl:@"https://g.api.mega.co.nz/"];
        } else {
            [[MEGASdkManager sharedMEGASdk] changeApiUrl:@"https://staging.api.mega.co.nz/"];
        }
    }
    
    versionCounter = 0;
    megaSdkVersionCounter = 0;
}

@end