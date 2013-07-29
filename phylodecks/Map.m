//
//  Map.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-05.
//
//  A major class stores all the tiles and other map information in the game
//  Singleton class used as global variables

#import "Map.h"

@implementation Map
static Map *sharedInstance = nil;

@synthesize mapInventory = _mapInventory;
@synthesize tiles = _tiles;
@synthesize selected = _selected;
@synthesize home = _home;
@synthesize target = _target;
@synthesize maxInventory;
@synthesize stepCounter;
@synthesize gameMode;
@synthesize terrainSet;
@synthesize targetIndex;

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

// refreshes map clear all the occupied cards
-(void)generateNewMap:(int)level{
    maxInventory = 9+[[Player currentPlayer] playerLevel] * 3;
    stepCounter = [[Player currentPlayer] playerLevel] + 3;
    _tiles = [[NSMutableArray alloc] init];
    
    
    for(int y = 1; y < 10; y++){
        for (int x = 1; x < 23; x++){
            Tile *aTile = [[Tile alloc]init];
            [aTile initWithPosX:x posY:y];
            [_tiles addObject: aTile];
        }
    }
}


-(Tile *)getTileAtPosX:(int)x posY:(int)y{

    return [_tiles objectAtIndex: (y-1)*22+(x-1)];
}

@end
