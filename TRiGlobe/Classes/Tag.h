//
//  Tag.h
//  iGlobe
//
//  Created by Marcio Valenzuela on 9/15/10.
//  Copyright 2010 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tag : NSObject {

    
}

@property(nonatomic,copy)NSString *creator;         // BEHIND THE SCENES -- NAME
@property(nonatomic,copy)NSString *discoverer;      // BEHIND THE SCENES -- AWARD
@property(nonatomic,copy)NSString *rglongitude;     // BEHIND THE SCENES
@property(nonatomic,copy)NSString *rglatitude;      // BEHIND THE SCENES
@property(nonatomic,copy)NSString *photoURL;        // NEEDS FIELD       -- PHOTO
@property(nonatomic,copy)NSString *description;     // NEEDS FIELD       -- INSTRUCTIONS
@property(nonatomic,copy)NSString *tagID;     // NEEDS FIELD       -- INSTRUCTIONS
@property(nonatomic,copy)NSString *status;     // NEEDS FIELD       -- INSTRUCTIONS

-(id)initWithCreator:(NSString*)creator
          rglatitude:(NSNumber*)lati
         rglongitude:(NSNumber*)longi
         description:(NSString*)description
            photoURL:(NSString*)photoURL;



@end
