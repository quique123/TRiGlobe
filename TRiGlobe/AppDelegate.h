//
//  AppDelegate.h
//  TRiGlobe
//
//  Created by Marcio Valenzuela on 4/24/13.
//  Copyright (c) 2013 Marcio Valenzuela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalViewController.h"

//Add bump-p2p
#import <MultipeerConnectivity/MultipeerConnectivity.h>
extern NSString *const kServiceType;

@class ModalViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,MCSessionDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

//Add bump-p2p
@property (strong, nonatomic) MCSession *session; @property (strong, nonatomic) MCPeerID *peerId;
extern NSString *const DataReceivedNotification;
- (void)sendDataToPeer;
@property (strong, nonatomic) MCAdvertiserAssistant *advertiserAssistant;

@end
