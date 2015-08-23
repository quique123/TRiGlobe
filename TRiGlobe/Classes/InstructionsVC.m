//
//  InstructionsVC.m
//  iGlobe
//
//  Created by Marcio Valenzuela on 5/6/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "InstructionsVC.h"

@implementation InstructionsVC



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.webView.delegate = self;
	NSString *urlAddress = @"http://www.yourserver.com/iGlobeRulesWebVersion.html";
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *request = [NSURLRequest requestWithURL:url]; 
	[self.webView setScalesPageToFit:YES];
	[self.webView loadRequest:request];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	//NSLog("Error : %@",error);
}

#pragma mark -
#pragma mark Web View Delegate Methods
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"webViewDidFinishLoad: isMainThread=%d", [NSThread isMainThread]);
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
