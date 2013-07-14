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
@synthesize selected = _selected;
@synthesize home = _home;
@synthesize target = _target;

-(id) init{
    self = [super init];
    if (self != nil){
        _mapInventory = [[NSMutableArray alloc] init];
        [self generateNewMap:[[Player currentPlayer] playerLevel]];
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
    

    for(int x = 1; x < 23; x++){
        for (int y = 1; y < 10; y++){
            Tile *aTile = [[Tile alloc]init];
            [aTile initWithPosX:x posY:y];
            [_tiles addObject: aTile];
        }
    }
}

-(void)setMapSize:(int)level{
    if(level <= 3){
       
    }else if(level <= 6){
        
    }else if(level <= 10){
        
    }
    
}


-(Tile*)getTileAtPosX:(int)x posY:(int)y{

    return [_tiles objectAtIndex: (y-1)*22+(x-1)];
}

@end
