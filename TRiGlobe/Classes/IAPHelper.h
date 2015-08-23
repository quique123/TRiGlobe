//
//  IAPHelper.h
//  iGlobe
//
//  Created by Marcio Valenzuela on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface IAPHelper : NSObject <SKRequestDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver>{
    NSDictionary *productInfo;
    NSMutableArray *products; //Stores the products to display
    NSMutableSet *purchasedProducts; //
}
@property (nonatomic, retain) NSDictionary *productInfo;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableSet *purchasedProducts;

-(void)registerAndGetIdentifiers;
-(void)fetchProductInfo;
@end
