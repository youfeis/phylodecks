//
//  Map.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-05.
//
//

#import "Map.h"

@implementation Map
static Map *sharedInstance = nil;

@synthesize mapInventory = _mapInventory;

-(id) init{
    self = [super init];
    if (self != nil){
        _mapInventory = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+(Map *)currentMap{
    if (sharedInstance == nil){
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

@end
