//
//  Users.h
//  iGlobe
//
//  Created by Marcio Valenzuela on 2/12/11.
//  Copyright 2011 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Users : NSObject {
	
}
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userPoints;

-(id)initWithUserName:(NSString*)userName userPoints:(NSString*)userPoints;
@end
