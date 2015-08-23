//
//  InAppPurchaseManager.h
//  iGlobe
//
//  Created by Marcio Valenzuela on 6/18/11.
//  Copyright 2011 Personal. All rights reserved.
//
// HowToPlay Class
// MapViewController Class


#import <StoreKit/StoreKit.h>
#import "IAPHelper.h"

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"

@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>{
	SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
}

// public methods
- (void)loadStore;
- (BOOL)canMakePurchases;
- (void)purchaseProUpgrade;

@end
