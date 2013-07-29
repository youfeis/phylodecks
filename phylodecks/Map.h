//
//  Map.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-05.
//
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Tile.h"
#import "Player.h"

@class Tile;

@interface Map : NSObject{
    NSMutableArray *mapInventory;
    NSMutableArray *tiles;
    Card *selected;
    Card *home;
    Card *target;
    int targetIndex;
    int maxInventory;
    int stepCounter;
    int gameMode;
    NSArray *terrainSet;
}
@property (retain,readwrite) NSMutableArray *mapInventory;
@property (retain,readwrite) NSMutableArray *tiles;
@property (retain,readwrite) Card *selected;
@property (retain,readwrite) Card *home;
@property (retain,readwrite) Card *target;
@property (assign,readwrite) int maxInventory;
@property (assign,readwrite) int stepCounter;
@property (assign,readwrite) int gameMode;
@property (retain,readwrite) NSArray *terrainSet;
@property (assign,readwrite) int targetIndex;


+(Map *)currentMap;
-(void)generateNewMap:(int)level;
-(Tile *)getTileAtPosX:(int)x posY:(int)y;

@end
