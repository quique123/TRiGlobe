
//
//  iGlobe
//
//  Created by Marcio Valenzuela on 9/15/10.
//  Copyright 2010 Personal. All rights reserved.
//

// The form that lets you add new maps and edit existing ones.
//
@interface NewMapViewController : UITableViewController 

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *instructions;
@property (nonatomic, copy) NSString *awardType;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, strong) UIImage *photo;

@end
