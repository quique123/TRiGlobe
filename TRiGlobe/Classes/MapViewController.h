//
//  MapViewController.h
//  iGlobe
//
//  Created by Marcio Valenzuela on 2/16/10.
//  Copyright 2010 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SantiappsHelper.h"
//#import "JSON.h"
//#import "GameBumpConnector.h"
//#import "FBConnect.h"
//#import "HowToPlay.h"
#import "Tag.h"
#import <iAd/iAD.h>
//#import "BumpClient.h"

//Add bump-p2p
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "AppDelegate.h"

@class CLGeocoder;
@class ModalViewController;

@interface MapViewController : UIViewController <MKMapViewDelegate,ADBannerViewDelegate, CLLocationManagerDelegate,MCBrowserViewControllerDelegate>{
	//MKMapView *mapView;
    //CLGeocoder *reverseGeocoder;
    //CLLocationManager *locationManager;
    //UIBarButtonItem *getAddressButton;
	//NSNumber *rglat;
	//NSNumber *rglong;
	//NSString *postUDID;
	//NSDate *postDate;
	//NSString *country;
	//NSString *post1;
	//NSString *post2;
	//BOOL ceroIsSingle;
	//Tag *newlyTag;
	
	//NSArray *allUserTags;
	
    // Bump API
	//GameBumpConnector *bumpConn;
	//UIImageView *bumpFourLogo;
	//UIBarButtonItem *bumpToConnectButton;
	NSMutableData *received_data;
	UIButton *bumpButton;
	
	//HowToPlay *howToPlayView;
    
    //iAds
	//ADBannerView *adView;
	//BOOL bannerIsVisible;

}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLGeocoder *reverseGeocoder;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *getAddressButton;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *plotMeButton;
@property (nonatomic,retain) IBOutlet UIButton *buyMoreButton;
@property (nonatomic,retain) NSArray *allUserTags;


@property (nonatomic, retain) NSNumber *rglat;
@property (nonatomic, retain) NSNumber *rglong;
@property (nonatomic, retain) NSString *postUDID;
@property (nonatomic, retain) NSDate *postDate;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *post1;
@property (nonatomic, retain) NSString *post2;
@property (readwrite) BOOL ceroIsSingle;
@property (nonatomic, retain) Tag *newlyTag;

//@property (nonatomic, retain) HowToPlay *howToPlayView;

//iAds
@property (nonatomic,retain) ADBannerView *adView;
@property BOOL bannerIsVisible;


// BUMP API
@property (nonatomic, retain) IBOutlet  UIImageView *bumpFourLogo;
@property (nonatomic, retain) IBOutlet  UIBarButtonItem *bumpToConnectButton;
//@property (nonatomic, retain) GameBumpConnector *bumpConn;
//BUMP CALL
-(IBAction) startBumpButtonPress; 
-(void)postToFacebook;
-(IBAction)reverseGeocodeCurrentLocation;
-(IBAction)plotMeMethod;
-(IBAction)buyMoreSelector;
@end
