//
//  GoogleMapUIViewController.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-30.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <CoreLocation/CoreLocation.h>

@interface GoogleMapUIViewController : UIViewController <CLLocationManagerDelegate>  {
    IBOutlet CLLocationManager *locationManager;
    IBOutlet UILabel *latLabel;
    IBOutlet UILabel *longLabel;
}


-(void)loadView;
-(void)relocate;
-(float)latitude;
-(float)longitude;


@end
