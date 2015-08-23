//
//  AppDelegate.m
//  TRiGlobe
//
//  Created by Marcio Valenzuela on 4/24/13.
//  Copyright (c) 2013 Marcio Valenzuela. All rights reserved.
//

#import "AppDelegate.h"

NSString *const kServiceType = @"sa-servicetype";
NSString *const DataReceivedNotification = @"com.santiapps.TRiGlobe:DataReceivedNotification";


@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TestFlight takeOff:@"d68efe7e-b133-4f54-aae3-11daa7e99cee"];
    //self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    //[self.window makeKeyAndVisible];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle: nil];
    
    self.tabBarController = (UITabBarController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"uitab"];
    [self.window addSubview:self.tabBarController.view];
    
    //[self presentLogin];
    
    //Add bump-p2p
    //NSString *peerName = self.myCard.firstName ? self.myCard.firstName : [[UIDevice currentDevice] name];
    NSString *peerName = [[UIDevice currentDevice] name];
    self.peerId = [[MCPeerID alloc] initWithDisplayName:peerName];
    self.session = [[MCSession alloc] initWithPeer:self.peerId securityIdentity:nil encryptionPreference:MCEncryptionNone];
    self.session.delegate = self;
    
    // 3
    self.advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:kServiceType discoveryInfo:nil session:self.session];
    
    // 4
    [self.advertiserAssistant start];
    
    return YES;
}

# pragma mark - Add bump-p2p
-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    NSString *gotUser = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"gotUser: %@", gotUser);
    [TestFlight passCheckpoint:@"gotUser"];
    [[NSNotificationCenter defaultCenter] postNotificationName:DataReceivedNotification object:nil];
}

-(void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
}

-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
}

-(void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID
withProgress:(NSProgress *)progress{
}

-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
}

-(void)sendDataToPeer {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"storedUser"]) {
        NSData *myUser = [[defaults objectForKey:@"storedUser"] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        [TestFlight passCheckpoint:@"OK send-ingDataToPeer"];
        [self.session sendData:myUser toPeers:[self.session connectedPeers] withMode:MCSessionSendDataReliable error:&error];
    } else {
        NSLog(@"ERROR");
        [TestFlight passCheckpoint:@"ERROR send-ingDataToPeer"];
    }
}


-(void)presentLogin{
    //SAVED LOGIN USER INFO CHECK
	// if empty then modal, else, modal
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	//NSLog(@"user%@,pass%@",[prefs stringForKey:@"storedUser"],[prefs stringForKey:@"storedPass"]);
	if (![prefs stringForKey:@"storedUser"] && ![prefs stringForKey:@"storedPass"]) {
		NSLog(@"No user prefs stored");
        
		// BUT WAIT, before all this, lets pop up a view controller for user registration
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
		ModalViewController *popupController = [sb instantiateViewControllerWithIdentifier:@"ModalViewController"];
		[self.tabBarController presentViewController:popupController animated:YES completion:nil];
		
	} else {
        NSString *storedUser = [NSString stringWithFormat:@"User:%@",[prefs stringForKey:@"storedUser"]];
        NSString *storedPass = [NSString stringWithFormat:@"User:%@",[prefs stringForKey:@"storedPass"]];
		UIAlertView *internetAlert = [[UIAlertView alloc] initWithTitle:storedUser
                                                                message:storedPass
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok", nil];
        [internetAlert show];
		//NSLog(@"This is the user:%@, and this pass:%@",[prefs stringForKey:@"storedUser"],[prefs stringForKey:@"storedPass"]);
	}
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
