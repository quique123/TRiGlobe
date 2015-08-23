//
//  MapViewAnnotation.m
//  iGlobe
//
//  Created by Marcio Valenzuela on 3/3/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import "MapViewAnnotation.h"


@implementation MapViewAnnotation
@synthesize title, coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
	[super init];
	title = ttl;
	coordinate = c2d;
	return self;
}

- (void)dealloc {
	[title release];
	[super dealloc];
}
@end
