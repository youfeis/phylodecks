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
@synthesize tiles = _tiles;

-(id) init{
    self = [super init];
    if (self != nil){
        _mapInventory = [[NSMutableArray alloc] init];
        _tiles = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+(Map *)currentMap{
    if (sharedInstance == nil){
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

-(void)generateNewMap:(int)level{
    _tiles = [[NSMutableArray alloc] init];
    [self setMapSize: level];
}

-(void)setMapSize:(int)level{
    if(level <= 3){
        for(int i = 0;i<25;i++){
            [_tiles addObject:[[Tile alloc] init]];
        }
    }else if(level <= 6){
        
    }else if(level <= 10){
        
    }
    
}


-(Tile*)getTileAtPosX:(int)x posY:(int)y{
    int total = [_tiles count];
    int width = sqrt(total);
    return [_tiles objectAtIndex: (y-1)*width+(x-1)];
}

@end
