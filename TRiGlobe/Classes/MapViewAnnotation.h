//
//  MapViewAnnotation.h
//  iGlobe
//
//  Created by Marcio Valenzuela on 3/3/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapViewAnnotation : NSObject <MKAnnotation>{
	NSString *title;
	CLLocationCoordinate2D coordinate;
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d;

@end
