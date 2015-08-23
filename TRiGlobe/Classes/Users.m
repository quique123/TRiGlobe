//
//  Users.m
//  iGlobe
//
//  Created by Marcio Valenzuela on 2/12/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "Users.h"


@implementation Users


-(id)initWithUserName:(NSString*)nameOfUser userPoints:(NSString*)userPoints;
{
	if ( (self = [super init]) == nil )
        return nil;
	self.userName = nameOfUser;
	self.userPoints = userPoints;
	return self;
}

@end
