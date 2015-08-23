//
//  PlaceMarkViewController.h
//  iGlobe
//
//  Created by Marcio Valenzuela on 2/16/10.
//  Copyright 2010 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface PlaceMarkViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	MKPlacemark *placemark;
    UITableView *tableView;
}
@property (nonatomic, retain) MKPlacemark *placemark;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction)done;

@end
