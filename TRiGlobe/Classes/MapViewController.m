//
//  MapViewController.m
//  iGlobe
//
//  Created by Marcio Valenzuela on 2/16/10.
//  Copyright 2010 Personal. All rights reserved.
//

#import "MapViewController.h"
#import "PlaceMarkViewController.h"
#import "MapViewAnnotation.h"
//#import "FBConnect.h"
#import "ModalViewController.h"
#import "InAppPurchaseManager.h"



@implementation MapViewController


//In App Purchase method call
-(IBAction) buyMoreSelector{
	//howToPlayView = [[HowToPlay alloc] initWithNibName:@"HowToPlay" bundle:nil];
	//[self presentModalViewController:howToPlayView animated:YES];
	InAppPurchaseManager *purchase = [[InAppPurchaseManager alloc] init];
	[purchase loadStore];
}

# pragma CREATE SINGLE OR EXCHANGED TAGS
//Creates an empty tag with value 1---
- (IBAction)reverseGeocodeCurrentLocation{
	//THIS METHOD READS THE CURRENT LOCATION AND PLOTS IT ON THE MAPVIEW
    //ceroIsSingle = 0;    
    //ELIMINATE SUPERFLOUS CODE
    //self.reverseGeocoder = [[[MKReverseGeocoder alloc] initWithCoordinate:mapView.userLocation.location.coordinate] autorelease];
    //reverseGeocoder.delegate = self;
    //[reverseGeocoder start];
	
	// added to see if i can print the location & then set the properties
	//NSLog(@"%g, %g",reverseGeocoder.coordinate.latitude, reverseGeocoder.coordinate.longitude);
	//self.rglat = [NSNumber numberWithDouble:reverseGeocoder.coordinate.latitude];
	//self.rglong = [NSNumber numberWithDouble:reverseGeocoder.coordinate.longitude];
	//NSLog(@"country is: %@",country);
	//UIDevice *device = [UIDevice currentDevice];
	//NSString *uniqueIdentifier = [device uniqueIdentifier];
	//self.postUDID = uniqueIdentifier;
	//REPLACE UDID WITH STORED USERPREFS EMAIL
    
    // DONT POST SINGLE TAG, ITS USELESS ANYWAY
	// Convert to NSString and hold on til callback fills in country...
	//post1 = [[NSString alloc] initWithFormat:@"originudid=%@&latitude=%@&longitude=%@&points=1&country=",self.postUDID,self.rglat,self.rglong];
	NSLog(@"I just sorta-tagged a place to fb");
	[self postToFacebook];
	
}

#warning PENDING
-(IBAction)startBumpButtonPress{
	
	
    ////////////////////////////
	// added to see if i can print the location & then set the properties
    //CLLocation *userLoc = self.mapView.userLocation.location;
    //CLLocationCoordinate2D userCoordinate = userLoc.coordinate;
    self.rglat = [NSNumber numberWithDouble:self.mapView.userLocation.location.coordinate.longitude];
    self.rglong = [NSNumber numberWithDouble:self.mapView.userLocation.location.coordinate.longitude];
    
    //NSLog(@"user latitude = %f",self.userCoordinate.latitude);
    NSLog(@"user longitude = %@",self.mapView.userLocation);
	//NSLog(@"%g, %g",reverseGeocoder.coordinate.latitude, reverseGeocoder.coordinate.longitude);
	//self.rglat = [NSNumber numberWithDouble:reverseGeocoder.coordinate.latitude];
	//self.rglong = [NSNumber numberWithDouble:reverseGeocoder.coordinate.longitude];
	
	//FIRST UDID
	//UIDevice *device = [UIDevice currentDevice];
	//NSString *uniqueIdentifier = [device uniqueId;entifier];
	//self.postUDID = uniqueIdentifier;
	// get the stored NSUserPrefs email identifier...
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *storedUserName = [prefs objectForKey:@"storedUser"];
    
    //#PENDING
	//self.newlyTag = [[Tag alloc] initWithSender:storedUserName receiver:nil rglatitude:self.rglat rglongitude:self.rglong rgcountry:nil];
	//NSLog(@"newTag incomplete:%@,%@,%@,%@,%@",self.newlyTag.sender, self.newlyTag.rglatitude, self.newlyTag.rglongitude, self.newlyTag.receiver, self.newlyTag.rgcountry);
    
    self.ceroIsSingle = 1;
	//self.bumpConn = [[[GameBumpConnector alloc] init] autorelease];
	//[bumpConn setBumpMapVC:self];
    
    
    //Add bump-p2p
    //[self configureBump]; bump deprecated to replaced by p2p ios native connectivity
	[self addCardPressed:nil];
    
	[self postToFacebook];

}

# pragma SOCIAL NETWORKS OR PLOT
-(void)postToFacebook{
	// before releasing the data, call 2 fb
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"159730937419119", @"app_id",
								   @"http://developers.facebook.com/docs/reference/dialogs/", @"link",
								   @"http://www.yourserver.com/assets/SantiappsLogo-with-people-small.png", @"picture",
								   @"iGlobe:WWW version of Tag", @"name",
								   @"Play tag around the world with iGlobe.", @"caption",
								   @"Download iGlobe from the AppStore!", @"description",
								   @"I just tagged a place!",  @"message",
								   nil];
	//iGlobeAppDelegate *appDelegate = (iGlobeAppDelegate *)[[UIApplication sharedApplication] delegate];
	//[appDelegate.facebook dialog:@"feed" andParams:params andDelegate:self];
	
	// CALL TO TWITTER
	//[SantiappsHelper updateStatus:@"iGlobe:WWW version of Tag" forUsername:(NSString *)username withPassword:(NSString *)password
	// No because i need the twitterAPI authview...
	
}

//Plots your tags
-(IBAction)plotMeMethod{
	// When called loop thru array from vDL and plot...
	NSLog(@"Array allUserTags:%@", self.allUserTags);
	NSDictionary *anEntry;
	for (anEntry in self.allUserTags){
		//NSLog(@"# Entries in allUserTags %i", [allUserTags count]);
		//create a location variable
		CLLocationCoordinate2D location;
		location.latitude = [[anEntry objectForKey:@"latitude"] doubleValue];
		location.longitude = [[anEntry objectForKey:@"longitude"] doubleValue];
		// added to see if locations are printed
		NSLog(@"coordlocation:%f, %f",location.latitude, location.longitude);
		//Add the annotation to our map view
		MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:@"Tag" andCoordinate:location];
		[self.mapView addAnnotation:newAnnotation];
		[newAnnotation release];
	}
}

- (void)presentLogin{
    NSLog(@"login");
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	if (![prefs stringForKey:@"storedUser"] && ![prefs stringForKey:@"storedPass"]) {
		NSLog(@"No user prefs stored");
        
		// BUT WAIT, before all this, lets pop up a view controller for user registration
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
		ModalViewController *popupController = [sb instantiateViewControllerWithIdentifier:@"ModalViewController"];
		[self presentViewController:popupController animated:NO completion:nil];
		
	} else {
        NSString *storedUser = [NSString stringWithFormat:@"User:%@",[prefs stringForKey:@"storedUser"]];
        NSString *storedPass = [NSString stringWithFormat:@"User:%@",[prefs stringForKey:@"storedPass"]];
		UIAlertView *internetAlert = [[UIAlertView alloc] initWithTitle:storedUser
                                                                message:storedPass
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok", nil];
        [internetAlert show];
		
	}
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self performSelector:@selector(presentLogin) withObject:nil afterDelay:1.5];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	// hide buyMoreButton
	//[buyMoreButton setHidden:NO];
	
    //Start fetching location
    //1.  CREATE NEW LOCATION
	self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    // Set a movement threshold for new events.
    //locationManager.distanceFilter = 500;
    [self.locationManager startUpdatingLocation];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;

	
	//Then it calls Santiappshelper in order to get the users tags
    //MODIFY THE fetchTIMELINEFORUDID so I can get the new array....
    //must use the login ID stored in NSUserPrefs in order to fetch the unique array
    //GET STORED USER IN ORDER TO LOAD-FETCH DATA
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	/* COMMENTED OUT
    self.allUserTags = (NSArray*)[SantiappsHelper fetchTimelineForUser:[prefs stringForKey:@"storedUser"]];
	*/
    
    //Add bump-p2p
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:DataReceivedNotification object:nil];
    
	// check if location enabled
	BOOL locationAllowed = [CLLocationManager locationServicesEnabled];
	
    if (locationAllowed==NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Service Disabled" 
                                                        message:@"To re-enable, please go to Settings and turn on Location Service for this app." 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    // iAds
	//self.adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
	//self.adView.frame = CGRectOffset(self.adView.frame, 0, -50);
	//self.adView.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait,ADBannerContentSizeIdentifierLandscape,nil];
	//self.adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
	//[self.view addSubview:self.adView];
	//self.adView.delegate=self;
	//self.bannerIsVisible = NO;
}
/**
#pragma iAd Delegate Methods
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
	if (!self.bannerIsVisible)
	{
		[UIView beginAnimations:@"animateAdBannerOn" context:NULL];
		// banner is invisible now and moved out of the screen on 50 px
		banner.frame = CGRectOffset(banner.frame, 0, 50);
		[UIView commitAnimations];
		self.bannerIsVisible = YES;
	}
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
	if (self.bannerIsVisible)
	{
		[UIView beginAnimations:@"animateAdBannerOff" context:NULL];
		// banner is visible and we move it out of the screen, due to connection issue
		banner.frame = CGRectOffset(banner.frame, 0, -50);
		[UIView commitAnimations];
		self.bannerIsVisible = NO;
	}
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
	NSLog(@"Banner view is beginning an ad action");
	BOOL shouldExecuteAction = YES;
	if (!willLeave && shouldExecuteAction)
    {
		// stop all interactive processes in the app
    }
	return shouldExecuteAction;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner{
	// resume everything you've stopped
	
}
**/
- (void)viewDidUnload {
    [super viewDidUnload];
    self.mapView = nil;
    self.getAddressButton = nil;
	
    //Stop updating location
    [self.locationManager stopUpdatingLocation];
    
    //Add bump-p2p
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma MAPVIEW DELEGATE METHODS
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(NSArray *)locations {
    // We have location, do your logic of setting the map region here.
    CLLocationCoordinate2D zoomLocation;
    
    zoomLocation = self.mapView.userLocation.coordinate;
    CLLocationDistance visibleDistance = 5000; // 5 kilometers
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, visibleDistance, visibleDistance);
        
    [_mapView setRegion:adjustedRegion animated:YES];
   
    //Get ocuntry
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         NSLog(@"Finding address");
         if (error) {
             NSLog(@"Error %@", error.description);
         } else {
             CLPlacemark *placemark = [placemarks lastObject];
             self.country = [placemark.addressDictionary objectForKey:@"Country"];
             NSLog(@"self.country %@", self.country);
         }
     }];

}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    // we have received our current location, so enable the "Get Current Address" button
    [self.getAddressButton setEnabled:YES];
}

#pragma BUMP METHODS

-(void) quickAlert:(NSString *)titleText msgText:(NSString *)msgText{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleText message:msgText delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}
/**
- (void) configureBump {
    NSLog(@"configureBump>");
    [BumpClient configureWithAPIKey:@"9ed7d2fa665f462eb05d5f87d4c07124" andUserID:[[UIDevice currentDevice] name]];
    
    [[BumpClient sharedClient] setMatchBlock:^(BumpChannelID channel) {
        NSLog(@"Matched with user: %@", [[BumpClient sharedClient] userIDForChannel:channel]);
        [[BumpClient sharedClient] confirmMatch:YES onChannel:channel];
    }];
    NSLog(@"setMatchBlock>");

    [[BumpClient sharedClient] setChannelConfirmedBlock:^(BumpChannelID channel) {
        NSLog(@"Channel with %@ confirmed.", [[BumpClient sharedClient] userIDForChannel:channel]);
        
        //1.SEND USERNAME STORED as DATA>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSData *moveChunk = [NSKeyedArchiver archivedDataWithRootObject:[prefs stringForKey:@"storedUser"]];
        
        [[BumpClient sharedClient] sendData:moveChunk toChannel:channel];
        
    }];
    NSLog(@"setChannelConfirmedBlock>");

    [[BumpClient sharedClient] setDataReceivedBlock:^(BumpChannelID channel, NSData *data) {
        
        //2.RECEIVE DATA>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        NSString *dataReceived = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSLog(@"Data received from %@: %@", [[BumpClient sharedClient] userIDForChannel:channel], dataReceived);
        [SantiappsHelper postNewTag:self.newlyTag];

        [self quickAlert:@"Data Got :)" msgText:dataReceived];
    }];
    NSLog(@"setDataReceivedBlock>");

    [[BumpClient sharedClient] setConnectionStateChangedBlock:^(BOOL connected) {
        if (connected) {
            NSLog(@"Bump connected...");
        } else {
            NSLog(@"Bump disconnected...");
        }
    }];
    NSLog(@"setConnectionStateChangedBlock>");
    
    [[BumpClient sharedClient] setBumpEventBlock:^(bump_event event) {
        switch(event) {
            case BUMP_EVENT_BUMP:
                NSLog(@"Bump detected.");
                break;
            case BUMP_EVENT_NO_MATCH:
                NSLog(@"No match.");
                break;
        }
    }];
    NSLog(@"setBumpEventBlock>");

}
**/
#pragma bump-p2p
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self dataReceived:nil];
}

-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendData {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate sendDataToPeer];
}

-(void)showMessage:(NSString*)message{
        [[[UIAlertView alloc] initWithTitle:@"DEBUG" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

-(void)browserViewControllerDidFinish:(MCBrowserViewController*)browserViewController{
    [browserViewController dismissViewControllerAnimated:YES completion:^{
        [self sendData];
        [self showMessage:@"didFinish"];
        [TestFlight passCheckpoint:@"didFinish"];
    }];
}

#warning PENDING
-(IBAction)addCardPressed:(id)sender {
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    //if (nil == delegate.myCard) {
    //    [[[UIAlertView alloc] initWithTitle:@"" message:@"Please set up your business card first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    //} else {
        if ([[delegate.session connectedPeers] count] == 0) {
            MCBrowserViewController *browserViewController = [[MCBrowserViewController alloc] initWithServiceType:kServiceType session:delegate.session];
            [self updateUIBarDisplay:browserViewController.view];
            browserViewController.delegate = self;
            [self showMessage:@"No Peers"];
            [TestFlight passCheckpoint:@"No Peers"];
            [self presentViewController:browserViewController animated:YES completion:nil];
        } else {
            [self sendData];
            [self showMessage:@"Peers: Sending Data"];
            [TestFlight passCheckpoint:@"Peers: Sending Data"];
            
            //#########################################################################################################PENDING
            //1. Connect to internet ... in SantiappsHelper...
            //2. Upload image
            //3. Post to insert text data into mysql db (<name>, <descp>, creator, location, <photo_url if uploaded>, type(new)-->CREATOR
            //----->>>>>>>>> NSString* fileNameIPassed = basename($_FILES['userfile']['name'])
            //4. Refresh tablevc to reflect new points
            //5. Send notifications to all players ... via app or email?
            //6. Post to facebook???
            //7. If already exists...(how do we check for this)...update database found, type(found)
            //8. Need VC for clues...so people can tap a clue they might aspire to, and tap again if they found it-->DISCOVERER
        }
    //}
}

#pragma mark - Helper methods
- (void)updateUIBarDisplay:(UIView *)view
{
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return;
    
    // Look for UINavigationBar in first level
    for (UIView *subview in subviews) {
        if ([subview isKindOfClass:[UINavigationBar class]]) {
            UINavigationBar *navBar = (UINavigationBar *) subview;
            // Customize the appearance
            navBar.translucent = YES;
            navBar.tintColor = [UIColor whiteColor];
            break;
        }
    }
}

-(void)dataReceived:(NSNotification *)notification{
    //[self showHideNoDataView];
    //[self.tableView reloadData];
    [self showMessage:@"dataReceived called"];
}


@end
