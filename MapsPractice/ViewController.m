//
//  ViewController.m
//  MapsPractice
//
//  Created by Justin Haar on 3/26/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//
#import "ViewController.h"
#import "BusStop.h"
#import "MapViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

    @property NSMutableArray *arrayOfBusStops;
    @property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getDataFromWebsite];
    self.arrayOfBusStops = [NSMutableArray new];

}


#pragma mark get data

-(void)getDataFromWebsite
{

    NSString *myURLString = @"https://s3.amazonaws.com/mobile-makers-lib/bus.json";

    NSURL *url = [NSURL URLWithString:myURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        [self downloadComplete:data];

    }];

}

-(void)downloadComplete:(NSData *)data
{

    // convert data into object
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    NSArray *arry = dict[@"row"];

    // we have an array of dictionaries want to convert into an array of bus stop objects

    // for each dictionary make object
    for (NSDictionary *dict2 in arry){

        [self unpackDictionaryAndCreateBusStop:dict2];

    }

    // reload table view
    [self.tableView reloadData];

}

-(void)unpackDictionaryAndCreateBusStop:(NSDictionary *)dict2
{
    // get lat and long
    NSString *lat = dict2[@"latitude"];
    double latAsDouble = lat.doubleValue;

    NSString *longitude = dict2[@"longitude"];
    double longAsDouble = longitude.doubleValue;

    // create new bus stop obj
    BusStop *busStop = [BusStop new];
    busStop.title = dict2[@"cta_stop_name"];
    busStop.coord = CLLocationCoordinate2DMake(latAsDouble, longAsDouble);
    busStop.routes = dict2[@"routes"];

    // save to array
    [self.arrayOfBusStops addObject:busStop];

}

#pragma mark display table

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    BusStop *busStop = [self.arrayOfBusStops objectAtIndex:indexPath.row];
    cell.textLabel.text = busStop.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%f %f", busStop.coord.latitude, busStop.coord.longitude];
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfBusStops.count;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{


    // apple will look to see if you implemented this method and if you did, it will give swipe delete automatically

    // your turn

    // delete your object from the array
    // reload data
}

#pragma mark map view

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MapViewController *mapVC = segue.destinationViewController;
    mapVC.busStops = self.arrayOfBusStops;
}









@end
