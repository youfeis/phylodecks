//
//  GPSMapLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-30.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GPSMapLayer.h"
#import "AppDelegate.h"


@implementation GPSMapLayer
-(id)init{
    self =[super init];
    if(self != nil){
        mapView = [[GoogleMapUIViewController alloc] init];
        [mapView loadView];
        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        NSMutableArray *terrains = [[NSMutableArray alloc] init];
        // Create menu items
        [CCMenuItemFont setFontSize:18];
        CCMenuItem *item = [CCMenuItemFont itemWithString:@"Hunt for a card!" block:^(id sender) {
            NSString *apiKey = @"AIzaSyD6OH4YfybdlJQJZgZPVRRA51MwTDsIiV4";
            
            NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/xml?location=%1f,%2f&radius=1000&sensor=true&key=%@&types=park|natural_feature|point_of_interest&name=park",locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude,apiKey];
            
            NSString *finalURL = [urlString  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:finalURL];
            
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue]
                                   completionHandler: ^(NSURLResponse * response, NSData * data, NSError * error) {
                                       NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)response;
                                       if(httpResponse.statusCode == 200) {
                                           
                                           NSError *error;
                                           GDataXMLDocument *xml = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
                                           if(![[xml.rootElement stringValue] isEqual:@"ZERO_RESULTS"]){
                                               //select target card from grassland/forest/urban
                                               [terrains addObject:@"FOREST"];
                                               [terrains addObject:@"GRASSLAND"];
                                               [terrains addObject:@"URBAN"];
                                               
                                           }
                                           
                                       }
                                   }
             
             ];
            
            
            NSString *urlString2 = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/xml?location=%1f,%2f&radius=1000&sensor=true&key=%@&types=park|natural_feature|point_of_interest&name=lake",locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude,apiKey];
            
            NSString *finalURL2 = [urlString2  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url2 = [NSURL URLWithString:finalURL2];
            
            NSURLRequest *request2 = [[NSURLRequest alloc]initWithURL:url2];
            
            [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue currentQueue]
                                   completionHandler: ^(NSURLResponse * response, NSData * data, NSError * error) {
                                       NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)response;
                                       if(httpResponse.statusCode == 200) {
                                           
                                           NSError *error;
                                           GDataXMLDocument *xml = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
                                           if(![[xml.rootElement stringValue] isEqual:@"ZERO_RESULTS"]){
                                               //select target card from freshwater/urban
                                               [terrains addObject:@"URBAN"];
                                               [terrains addObject:@"FRESHWATER"];
                                           }
                                           
                                       }
                                   }
             
             ];
            
            NSString *urlString3 = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/xml?location=%1f,%2f&radius=1000&sensor=true&key=%@&types=park|natural_feature|point_of_interest&name=mountain",locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude,apiKey];
            
            NSString *finalURL3 = [urlString3  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url3 = [NSURL URLWithString:finalURL3];
            
            NSURLRequest *request3 = [[NSURLRequest alloc]initWithURL:url3];
            
            [NSURLConnection sendAsynchronousRequest:request3 queue:[NSOperationQueue currentQueue]
                                   completionHandler: ^(NSURLResponse * response, NSData * data, NSError * error) {
                                       NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)response;
                                       if(httpResponse.statusCode == 200) {
                                           
                                           NSError *error;
                                           GDataXMLDocument *xml = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
                                           if(![[xml.rootElement stringValue] isEqual:@"ZERO_RESULTS"]){
                                               //select target card from forest/tundra/urban
                                               [terrains addObject:@"URBAN"];
                                               [terrains addObject:@"FOREST"];
                                               [terrains addObject:@"TUNDRA"];
                                           }
                                           
                                       }
                                   }
             
             ];
            
            NSString *urlString4 = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/xml?location=%1f,%2f&radius=1000&sensor=true&key=%@&types=park|natural_feature|point_of_interest&name=sea",locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude,apiKey];
            
            NSString *finalURL4 = [urlString4  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url4 = [NSURL URLWithString:finalURL4];
            
            NSURLRequest *request4 = [[NSURLRequest alloc]initWithURL:url4];
            
            [NSURLConnection sendAsynchronousRequest:request4 queue:[NSOperationQueue currentQueue]
                                   completionHandler: ^(NSURLResponse * response, NSData * data, NSError * error) {
                                       NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)response;
                                       if(httpResponse.statusCode == 200) {
                                           
                                           NSError *error;
                                           GDataXMLDocument *xml = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
                                           if(![[xml.rootElement stringValue] isEqual:@"ZERO_RESULTS"]){
                                               //select target card from ocean/urban
                                               [terrains addObject:@"URBAN"];
                                               [terrains addObject:@"OCEAN"];
                                           }
                                           
                                       }
                                   }
             
             ];
            [terrains addObject:@"URBAN"];
            NSArray *array = [[NSSet setWithArray:terrains] allObjects];
            NSLog(@"%@",terrains);
            [[Map currentMap] setTerrainSet:array];
            
            [self transitToInventorySelectionLayer];
            
        }];
        
        CCMenuItem *item2 = [CCMenuItemFont itemWithString:@"relocate yourself!" block:^(id sender) {
            [[self getChildByTag:10] removeFromParentAndCleanup:YES];
            [[self getChildByTag:11] removeFromParentAndCleanup:YES];
            NSString *latitude = [NSString stringWithFormat:@"latitude: %f",[mapView latitude]];
            
            NSString *longitude = [NSString stringWithFormat:@"longitude: %f",[mapView longitude]];
            CCLabelTTF *line1 = [CCLabelTTF labelWithString:latitude fontName:@"Marker Felt" fontSize:24];
            CCLabelTTF *line2 = [CCLabelTTF labelWithString:longitude fontName:@"Marker Felt" fontSize:24];
            line1.position = ccp(size.width/2,size.height*0.6);
            line2.position = ccp(size.width/2,size.height*0.4);
            [self addChild:line1 z:0 tag: 10];
            [self addChild:line2 z:0 tag: 11];
            
        }];
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
        CCMenu *menu2 = [CCMenu menuWithItems:item2,nil];
		[menu setPosition:ccp( size.width/2, size.height * 0.15)];
        [menu2 setPosition:ccp( size.width/2, size.height * 0.25)];
        [self addChild: menu];
        [self addChild: menu2];
        
        
        NSString *latitude = [NSString stringWithFormat:@"latitude: %f",locationManager.location.coordinate.latitude];
        
        NSString *longitude = [NSString stringWithFormat:@"longitude: %f",locationManager.location.coordinate.longitude];
        CCLabelTTF *line1 = [CCLabelTTF labelWithString:latitude fontName:@"Marker Felt" fontSize:24];
        CCLabelTTF *line2 = [CCLabelTTF labelWithString:longitude fontName:@"Marker Felt" fontSize:24];
        line1.position = ccp(size.width/2,size.height*0.6);
        line2.position = ccp(size.width/2,size.height*0.4);
        [self addChild:line1 z:0 tag: 10];
        [self addChild:line2 z:0 tag: 11];
    }
    return self;

    
}


-(void) transitToInventorySelectionLayer{
    [[Map currentMap] setGameMode:1];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[ChallengeModePrepareScene alloc] init] withColor:ccWHITE]];
}

@end
