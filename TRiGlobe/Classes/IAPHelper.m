//
//  IAPHelper.m
//  iGlobe
//
//  Created by Marcio Valenzuela on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IAPHelper.h"

@implementation IAPHelper
@synthesize productInfo, products, purchasedProducts;

//1.  Method Called from applicationWillFinishLaunching---ONLY FOR OSX
/**
 -(void)getSandboxReceipt{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[[[NSBundle mainBundle] appStoreReceiptURL] path]]) {
        NSLog(@"To get a sandbox receipt, the app must be launched outside of xcode");
        exit(173);
    }
    //Other receipt validation code goes here...cant think of any except a popup saying he has no purchases
}
**/
//2.  Method Called from applicationDidFinishLaunching
-(void)registerAndGetIdentifiers{
    //Ensure IAP is enabled, otherwise dont display a store
    if (![SKPaymentQueue canMakePayments]) {
        //..all is ok
    }
    //Begin observing transaction queue updates
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    //Load productIdentifiers from appbundle
     productInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"products" ofType:@"plist"]];
    
    //Create array of products
    NSMutableArray *purchasedProducts = [[NSMutableArray alloc] init];
    
    NSLog(@"Product info (plist):%@",productInfo);
}

-(void)fetchProductInfo{
    //Request PID from appstore
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:[productInfo allKeys]]];
    request.delegate = self;
    [request start];
}

-(void)request:(SKRequest*)request didFailWithError:(NSError *)error{
    //Request failed
    NSLog(@"PID request failed with error:%@",error);
    [request release];
}

-(void)productsRequest:(SKProductsRequest*)request didReceiveResponse:(SKProductsResponse*)response{
    [products release];
    products = [response.products copy];
    
    //display products
    //[productsPopup removeAllItems];
    //for now lets just log them
    NSLog(@"Products received are (Apple Server):%@", products);
    
    /**
     [products enumerateObjectsUsingBlock:^(SKProduct *product, NSUInteger idx, BOOL *stop){
        //localize product list
        NSNumberFormatter *fmt = [[[NSNumberFormatter alloc] init] autorelease];
        [fmt setLocale:product.priceLocale];
        [fmt setNumberStyle:NSNumberFormatterCurrencyStyle];
        NSString *priceString = [fmt stringFromNumber:product.price];
        //display product title and price
        [productsPopup addItemWithTitle:[NSString stringWithFormat:@"%@, (%@)", product.localizedTitle, priceString]];
    }];
    
    [productsPopup setEnabled:([products count] > 0)];
    **/
    NSLog(@"Reponse was:%@", response);
    [request release];
}
/////////////////////////////////////
# pragma mark
# pragma mark
# pragma mark
# pragma mark
# pragma mark
# pragma END PRODUCT REQUEST/REPONSE
# pragma BEGIN PROUDCT PURCHASE
# pragma mark
# pragma mark
# pragma mark
# pragma mark
# pragma mark
# pragma mark
# pragma mark

-(IBAction)purchasedProduct:(id)sender{
    //User initiated a purchase, create a payment and add it to the queue
    
    //Not purchasing anything yet
    /**
    SKPayment *payment = [SKPayment paymentWithProduct:[products objectAtIndex:[productsPopup indexOfSelectedItem]]];
    NSlog(@"Payment is for:%@", payment);
    [[SKPaymentQueue defaultQueue] addPayment:payment];
     **/
}
-(void)provideContentForTransaction:(id)transaction{
    //Content successfully purchased
    NSLog(@"Content purchased successfully...thx");
}

-(IBAction)restorePurchases:(id)sender{
    //restore user purchases to this device (only non-consumables)
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    //Check state of each transaction
    /**
     for (SKPaymentTransaction *transaction in transactions) {
        NSLog(@"The transaction is: %@", transaction);
        
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                //display progress indicator...
                break;
            case SKPaymentTransactionStatePurchased:
                [self provideContentForTransaction:transaction];
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self provideContentForTransaction:transaction.originalTransaction];
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                if ([transaction.error code] != SKErrorPaymentCancelled) {
                    //message why it failed...
                }
                [queue finishTransaction:transaction];
                break;
            default:
                break;
        }
    }
     **/
}

-(void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    NSLog(@"There was a payment error");
}


@end
