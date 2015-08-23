//
//  ImageUpload2PHP.m
//  TRiGlobe
//
//  Created by Marcio Valenzuela on 8/17/13.
//  Copyright (c) 2013 Marcio Valenzuela. All rights reserved.
//

#import "ImageUpload2PHP.h"

#define TIMEOUT_INTERVAL 60
#define CONTENT_TYPE @"Content-Type"
#define URL_ENCODED @"application/x-www-form-urlencoded"
#define GET @"GET"
#define POST @"POST"

@implementation ImageUpload2PHP

-(NSMutableURLRequest*)getNSMutableURLRequestUsingGetMethodWithUrl:(NSString*)url{
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:TIMEOUT_INTERVAL];
    [req setHTTPMethod:GET];
    return req;
}

-(NSMutableURLRequest*)getNSMutableURLRequestUsingPOSTMethodWithUrl:(NSString *)url postData:(NSString*)_postData{
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:TIMEOUT_INTERVAL];
    [req setHTTPMethod:POST];
    [req addValue:URL_ENCODED forHTTPHeaderField:CONTENT_TYPE];
    [req setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    return req;
}
/*
@try{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *_postData = [NSString stringWithFormat:@"user_name=%@&password=%@",@"user_name",@"password"];
    NSMutableURLRequest *req = [self getNSMutableURLRequestUsingPOSTMethodWithUrl:_url postData:_postData];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error) {
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             NSLog(@"error==%@==",[error localizedDescription]);
         } else {
             NSError *errorInJsonParsing;
             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorInJsonParsing];
             
             if(errorInJsonParsing) { //error parsing in json
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 NSLog(@"error in json==%@==",[error localizedDescription]);
             } else {
                 //do some operations
             }
         }
     }];
}
@catch(NSException *exception){
    NSLog(@"error in exception==%@==",[exception description]);
}
*/

//same way it works for the get method, just call the
//NSMutableURLRequest *req = [self getNSMutableURLRequestUsingGetMethodWithUrl:_url];
//instead of NSMutableURLRequest *req = [self getNSMutableURLRequestUsingPOSTMethodWithUrl:_url postData:_postData];

@end
