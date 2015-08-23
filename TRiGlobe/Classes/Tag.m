//
//  Tag.m
//  iGlobe
//
//  Created by Marcio Valenzuela on 9/15/10.
//  Copyright 2010 Personal. All rights reserved.
//

#import "Tag.h"

@implementation Tag


-(id)initWithCreator:(NSString*)creator
          rglatitude:(NSString*)lati
         rglongitude:(NSString*)longi
         description:(NSString*)description
            photoURL:(NSString*)photoURL{
    
    NSLog(@"TAG INIT");
	if ( (self = [super init]) == nil )
        return nil;
	
	self.creator = creator;
	self.rglatitude = lati;
	self.rglongitude = longi;
	self.description = description;
	self.photoURL = photoURL;
	return self;
    
}

@end
