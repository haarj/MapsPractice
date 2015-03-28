//
//  BusStop.h
//  MapsPractice
//
//  Created by Justin Haar on 3/26/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BusStop : NSObject

  @property NSString *title;
  @property CLLocationCoordinate2D coord;
  @property NSString *routes;

// plus whatever you want

@end


//mapview addannotation:busStop 