//
//  SantiappsHelper.h
//  iGlobe
//
//  Created by Marcio Valenzuela on 2/19/10.
//  Copyright 2010 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tag.h"

//SO: http://stackoverflow.com/questions/17416683/how-do-i-return-a-value-from-a-helper-class-to-a-view-controller/17416915?noredirect=1#17416915
typedef void (^Handler)(NSArray *users);
typedef void (^Handler2)(NSArray *points);
typedef void (^Handler3)(NSArray *usersPointsArray);
typedef void (^Handler4)(NSArray *undiscoveredTagsArray);

@interface SantiappsHelper : NSObject {
}

+(void)fetchUsersWithCompletionHandler:(Handler)handler;

//+(NSData*)encodeDictionary:(NSDictionary*)dictionary;

+(void)fetchPointForUsersArray:(NSArray*)usersArray WithCompletionHandler:(Handler3)handler;

+ (BOOL)postNewTag:(Tag*)passingObject;

/*
//OLD PERHAHPS UN-NEEDED
+(void)fetchPointsForUser:(NSString*)usuario WithCompletionHandler:(Handler2)handler ;

+ (NSArray *)fetchTimelineForUser:(NSString *)user;

+ (BOOL)updateTags:(NSString *)status forUDID:(NSString *)udid;// withPassword:(NSString *)password;

+(NSArray*)fetchPointForUsersArray:(NSArray*)usersArray;
*/
+(void)fetchUndiscoveredTags:(Handler4)handler;

-(void)updateTagDiscoveredByUser:(NSString*)discoverer withTagID:(NSString*)tagID withStatus:(NSString*)found;

@end
