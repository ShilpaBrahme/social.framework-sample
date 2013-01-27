//
//  ViewController.m
//  SocialFrameworkSample
//
//  Created by Tomáš Hanáček on 27.01.13.
//  Copyright (c) 2013 Tomáš Hanáček. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // set up navigation bar
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonTapped:)];
    UIBarButtonItem *facebookButton = [[UIBarButtonItem alloc] initWithTitle:@"Facebook" style:UIBarButtonItemStylePlain target:self action:@selector(facebookButtonTapped:)];
    UIBarButtonItem *twitterButton = [[UIBarButtonItem alloc] initWithTitle:@"Twitter" style:UIBarButtonItemStylePlain target:self action:@selector(twitterButtonTapped:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:shareButton, facebookButton, twitterButton, nil];
}

- (void)shareButtonTapped:(id)sender
{
    NSString *text = @"social.framework sample";
    UIImage *image = [UIImage imageNamed:@"apple"];
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com"];
    NSArray *activityItems = [NSArray arrayWithObjects:text, image, url, nil];

    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)twitterButtonTapped:(id)sender
{
    [self shareWithServiceType:SLServiceTypeTwitter];
}

- (void)facebookButtonTapped:(id)sender
{
    [self shareWithServiceType:SLServiceTypeFacebook];
}

- (void)shareWithServiceType:(NSString *)serviceType
{
    if ([SLComposeViewController isAvailableForServiceType:serviceType]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"Result cancelled");
            } else {
                NSLog(@"Success");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler = myBlock;
        
        [controller setInitialText:@"social.framework sample"];
        [controller addURL:[NSURL URLWithString:@"http://www.apple.com"]];
        [controller addImage:[UIImage imageNamed:@"apple"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
    } else {
        NSLog(@"%@ is unavailable", serviceType);
    }
}

@end
