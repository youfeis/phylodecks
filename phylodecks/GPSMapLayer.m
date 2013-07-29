//
//  GPSMapLayer.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-30.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GPSMapLayer.h"
#import "AppDelegate.h"
#import "MainMenuLayer.h"

@implementation GPSMapLayer
-(id)init{
    self =[super init];
    if(self != nil){
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *back1 = [CCSprite spriteWithFile:@"Back.png"];
        CCSprite *back2 = [CCSprite spriteWithFile:@"Back.png"];
        back2.color = ccGRAY;
        CCMenuItemSprite * itemBack = [CCMenuItemSprite itemWithNormalSprite:back1 selectedSprite:back2 block:^(id sender){
            [[self parent] removeAllChildrenWithCleanup:YES];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init] withColor:ccWHITE]];
            
        }];
        [itemBack setScale:0.5f];
        CCMenu *backMenu = [CCMenu menuWithItems:itemBack, nil];
        backMenu.position = ccp(40.0f,size.height - 20.0f);
        [self addChild:backMenu];

        
        mapView = [[GoogleMapUIViewController alloc] init];
        [mapView loadView];
        
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.anchorPoint = ccp(0,0);
        [background setScaleY: 480/background.contentSize.height];
        [background setScaleX: 320/background.contentSize.width];
        [self addChild:background z:-2];
        
        CCSprite *box = [CCSprite spriteWithFile:@"Coordinate.png"];
        [box setPosition:ccp(size.width/2,size.height*0.7)];
        [box setScale:0.5f];
        [self addChild:box z:-1];
        
       
        NSMutableArray *terrains = [[NSMutableArray alloc] init];
        // Create menu items
        [CCMenuItemFont setFontSize:18];
        CCSprite *battle1 = [CCSprite spriteWithFile:@"Battle1.png"];
        CCSprite *battle2 = [CCSprite spriteWithFile:@"Battle2.png"];
        
        CCMenuItemSprite *item = [CCMenuItemSprite itemWithNormalSprite:battle1 selectedSprite:battle2 block:^(id sender) {
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
            [[Map currentMap] setTerrainSet:array];
            
            [self transitToInventorySelectionLayer];
            
        }];
        
        CCSprite *rellocate1 = [CCSprite spriteWithFile:@"Rellocate1.png"];
        CCSprite *rellocate2 = [CCSprite spriteWithFile:@"Rellocate2.png"];
        
        CCMenuItemSprite *item2 = [CCMenuItemSprite itemWithNormalSprite:rellocate1 selectedSprite:rellocate2 block:^(id sender) {
            [[self getChildByTag:10] removeFromParentAndCleanup:YES];
            [[self getChildByTag:11] removeFromParentAndCleanup:YES];
            NSString *latitude = [NSString stringWithFormat:@"%f",mapView.latitude];
            
            NSString *longitude = [NSString stringWithFormat:@"%f",mapView.longitude];
            CCLabelTTF *line1 = [CCLabelTTF labelWithString:latitude fontName:@"Marker Felt" fontSize:24];
            CCLabelTTF *line2 = [CCLabelTTF labelWithString:longitude fontName:@"Marker Felt" fontSize:24];
            line1.position = ccp(size.width/2,size.height*0.75);
            line2.position = ccp(size.width/2,size.height*0.55);
            line1.color = ccBLACK;
            line2.color = ccBLACK;
            [self addChild:line1 z:0 tag: 10];
            [self addChild:line2 z:0 tag: 11];
            
        }];
        
        [item setScale:0.5f];
        [item2 setScale:0.5f];
        
        
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
        CCMenu *menu2 = [CCMenu menuWithItems:item2,nil];
		[menu setPosition:ccp( size.width/2, size.height * 0.15)];
        [menu2 setPosition:ccp( size.width/2, size.height * 0.35)];
        [self addChild: menu];
        [self addChild: menu2];
        
        
        NSString *latitude = [NSString stringWithFormat:@"%f",locationManager.location.coordinate.latitude];
        
        NSString *longitude = [NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude];
        CCLabelTTF *line1 = [CCLabelTTF labelWithString:latitude fontName:@"Marker Felt" fontSize:24];
        CCLabelTTF *line2 = [CCLabelTTF labelWithString:longitude fontName:@"Marker Felt" fontSize:24];
        line1.position = ccp(size.width/2,size.height*0.75);
        line2.position = ccp(size.width/2,size.height*0.55);
        line1.color = ccBLACK;
        line2.color = ccBLACK;
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
