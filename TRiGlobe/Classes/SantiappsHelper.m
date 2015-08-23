//
//  SantiappsHelper.m
//  iGlobe
//
//  Created by Marcio Valenzuela on 2/19/10.
//  Copyright 2010 Personal. All rights reserved.
//

#import "SantiappsHelper.h"

@implementation SantiappsHelper

+(void)fetchUndiscoveredTags:(Handler4)handler{
    NSURL *url = [NSURL URLWithString:@"http://www.yourserver.com/getundiscoveredtags.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        //dispatch_async(dispatch_get_main_queue(), ^{
        // Peform the request
        NSURLResponse *response;
        NSError *error = nil;
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request
                                                     returningResponse:&response
                                                                 error:&error];
        if (error) {
            // Deal with your error
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                NSLog(@"HTTP Error: %d %@", httpResponse.statusCode, error);
                return;
            }
            NSLog(@"Error %@", error);
            return;
        }
        
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
        //NSLog(@"responseString fetchUsers %@", responseString);
        
        NSArray *tagsArray = [[NSArray alloc] init];
        tagsArray = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSASCIIStringEncoding] options:0 error:nil];
        
        if (handler){
            //dispatch_sync WAITS for the block to complete before returning the value
            //otherwise, the array is returned but gets zeroed out
            dispatch_sync(dispatch_get_main_queue(), ^{
                handler(tagsArray);
            });
        }
    });

}

// THIS METHOD FETCHES USER ARRAY
+(void)fetchUsersWithCompletionHandler:(Handler)handler {
	
    //NSString *urlString = [NSString stringWithFormat:@"http://www.yourserver.com/getusers.php"];
    NSURL *url = [NSURL URLWithString:@"http://www.yourserver.com/getusers.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];

    //__block - where NSArray usersArray used to be declared but caused handler(usersArray) to return a nil array
    

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    //dispatch_async(dispatch_get_main_queue(), ^{
        // Peform the request
        NSURLResponse *response;
        NSError *error = nil;
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request
                                                     returningResponse:&response
                                                                 error:&error];
        if (error) {
            // Deal with your error
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                NSLog(@"HTTP Error: %d %@", httpResponse.statusCode, error);
                return;
            }
            NSLog(@"Error %@", error);
            return;
        }
        
        NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
        //NSLog(@"responseString fetchUsers %@", responseString);
        
        NSArray *usersArray = [[NSArray alloc] init];
        usersArray = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSASCIIStringEncoding] options:0 error:nil];

        if (handler){
            //dispatch_sync WAITS for the block to complete before returning the value
            //otherwise, the array is returned but gets zeroed out
            dispatch_sync(dispatch_get_main_queue(), ^{
            handler(usersArray);
            });
        }
    });
    //SO:http://stackoverflow.com/questions/17416683/how-do-i-return-a-value-from-a-helper-class-to-a-view-controller/17416915?noredirect=1#17416915
}
/* WORKED WITH OLD +(void)fetchPointsForUser:(NSString*)usuario WithCompletionHandler:(Handler2)handler;
//ENCODE DICTIONARY
+(NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}
*/

//Fetches points for users array
+(void)fetchPointForUsersArray:(NSArray*)usersArray WithCompletionHandler:(Handler3)handler{
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:usersArray options:0 error:&error];
    
    if (error)
        NSLog(@"%s: JSON encode error: %@", __FUNCTION__, error);
    
    // create the request
    NSURL *url = [NSURL URLWithString:@"http://www.yourserver.com/readpointsforarray.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    __block NSArray *pointsArray = [[NSArray alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    //dispatch_async(dispatch_get_main_queue(), ^{        // Peform the request
        NSURLResponse *response;
        NSError *error = nil;
        
        // issue the request
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if (error) {
            // Deal with your error
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                NSLog(@"HTTP Error: %d %@", httpResponse.statusCode, error);
                //return;
            }
            NSLog(@"Error %@", error);
            //return;
        }
        
        NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        //NSLog(@"asyncrhonous: %@",responseString);
        
        pointsArray = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSASCIIStringEncoding] options:0 error:nil];
        //NSLog(@"pointsArray %@", pointsArray);
        
        if (handler){
            //dispatch_async(dispatch_get_main_queue(), ^{
                handler(pointsArray);
            //});
        }
    });
}

#warning PENDING
+ (BOOL)postNewTag:(Tag*)passingObject{

    //1. Create the tag
	Tag *tagReceived = [[Tag alloc] initWithCreator:nil rglatitude:nil rglongitude:nil description:nil photoURL:nil];
                        
	NSLog(@"passingObject:%@,%@,%@,%@,%@",tagReceived.creator, tagReceived.rglatitude, tagReceived.rglongitude, tagReceived.description, tagReceived.photoURL);
	
	//2. REBUILD status string from passingObject
	NSString *s1 = [[NSString alloc] initWithFormat:@"creator=%@&latitude=%@&longitude=%@&description=%@&photoURL=%@&status=0",tagReceived.creator, tagReceived.rglatitude, tagReceived.rglongitude, tagReceived.description, tagReceived.photoURL];
	
    //3.  Post tag to cloud
    NSData *postData = [s1 dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.yourserver.com/createnewtag.php"]];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
	// We should probably be parsing the data returned by this call, for now just check the error.
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"success!");
	[s1 release];
    return (error == nil);
    
    //#PENDING
    //1. Add createnewtag.php file to write to database
    //2. manage upload of image to return url...
}

#warning PENDING
-(void)updateTagDiscoveredByUser:(NSString*)discoverer withTagID:(NSString*)tagID withStatus:(NSString*)found{
    
    //1. Create update string
    NSString *status = [NSString stringWithFormat:@"user=%@&tagID=%@&status=%@", discoverer,tagID, found];

    //2. Create URL
    NSData *postData = [status dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.yourserver.com/updatediscoveredtag.php"]];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
	// We should probably be parsing the data returned by this call, for now just check the error.
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"success!");
    
    //#PENDING
    //1. Create updatediscoveredtag.php
}




/* OLD METHOD WHICH ONLY FETCHED POINTS FOR SINGLE USERS AT A TIME
 +(void)fetchPointsForUser:(NSString*)usuario WithCompletionHandler:(Handler2)handler{
 //not using it because I made the form out to be POST$ ...
 NSURL *url = [NSURL URLWithString:@"http://www.yourserver.com/readpoints.php"];
 NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:usuario, @"userNa", nil];
 
 NSData *postData = [self encodeDictionary:postDict];
 
 // Create the request
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
 [request setHTTPMethod:@"POST"];
 [request setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
 [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
 [request setHTTPBody:postData];
 
 //__block NSDictionary *pointsDictionary = [[NSDictionary alloc] init];
 __block NSArray *pointsArray = [[NSArray alloc] init];
 
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
 // Peform the request
 NSURLResponse *response;
 NSError *error = nil;
 NSData *receivedData = [NSURLConnection sendSynchronousRequest:request
 returningResponse:&response
 error:&error];
 if (error) {
 // Deal with your error
 if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
 NSLog(@"HTTP Error: %d %@", httpResponse.statusCode, error);
 return;
 }
 NSLog(@"Error %@", error);
 return;
 }
 
 NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
 NSLog(@"responseString fetchPoints for %@ %@", usuario, responseString);
 
 pointsArray = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSASCIIStringEncoding] options:0 error:nil];
 
 if (handler){
 dispatch_async(dispatch_get_main_queue(), ^{
 handler(pointsArray);
 });
 }
 });
 
 }
 
 //GETS TAGS BASED ON USERNAME
 + (NSArray *)fetchTimelineForUser:(NSString *)user{
 
 NSString *post = [NSString stringWithFormat:@"userudid=%@", [user stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
 NSLog(@">1>%@",post);
 NSData *postData = [NSData dataWithBytes:[post UTF8String] length:[post length]];
 //[udid dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
 NSLog(@">2>%@",postData);
 //NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
 
 NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
 NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.yourserver.com/readtags2.php"]];
 [request setURL:url];
 [request setHTTPMethod:@"POST"];
 //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
 [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
 [request setHTTPBody:postData];
 NSURLResponse *response;
 NSError *error;
 NSData *urlData = [NSURLConnection sendSynchronousRequest:request
 returningResponse:&response
 error:&error];
 
 NSString *content = [NSString stringWithUTF8String:[urlData bytes]];
 //NSLog(@"responseData: %@", content);
 
 NSData *jsonData = [NSData dataWithContentsOfURL:url];
 NSArray *pointsForUser = nil;
 
 if(jsonData != nil) {
 NSError *error = nil;
 id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
 pointsForUser = result;
 if (error == nil)
 NSLog(@"%@", result);
 }
 return pointsForUser;
 
 }
 
 // Called from MKVC-IBAction reverseGeocoder, Lonely Tag=1
 + (BOOL)updateTags:(NSString *)status forUDID:(NSString *)udid{
 //if (!username || !password) {
 //    return NO;
 //}
 // how does this get the newTag info??????????????????????????????????????????????
 //NSString *post = [NSString stringWithFormat:@"geotag=%@", [status stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
 //NSLog(@"status:%@",status);
 //NSLog(@"%@",post);
 NSData *postData = [status dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
 NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
 NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
 NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.yourserver.com/writephp.php"]];
 [request setURL:url];
 [request setHTTPMethod:@"POST"];
 [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
 [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
 [request setHTTPBody:postData];
 
 NSURLResponse *response;
 NSError *error;
 // We should probably be parsing the data returned by this call, for now just check the error.
 [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
 NSLog(@"success!");
 
 return (error == nil);
 }
 
 */
@end
