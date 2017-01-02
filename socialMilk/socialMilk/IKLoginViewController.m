//
//  IKLoginViewController.m
//  socialMilk
//
//  Created by Kirill Averyanov on 01/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IKLoginViewController.h"
#import "InstagramKit.h"

@interface IKLoginViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation IKLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.scrollView.bounces = NO;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    NSURL *authURL = [[InstagramEngine sharedEngine] authorizationURL];
    [self.webView loadRequest:[NSURLRequest requestWithURL:authURL]];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSError *error;
    if ([[InstagramEngine sharedEngine] receivedValidAccessTokenFromURL:request.URL error:&error])
    {
        [self authenticationSuccess];
    }
    return YES;
}

- (void)authenticationSuccess
{
    [self.navigationItem setLeftBarButtonItem:nil];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
}

@end
