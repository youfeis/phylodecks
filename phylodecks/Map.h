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


@interface Map : NSObject{
    NSMutableArray *mapInventory;
    NSMutableArray *tiles;
    Card *selected;
    Card *home;
    Card *target;
}
@property (retain,readwrite) NSMutableArray *mapInventory;
@property (retain,readwrite) NSMutableArray *tiles;
@property (retain,readwrite) Card *selected;
@property (retain,readwrite) Card *home;
@property (retain,readwrite) Card *target;

+(Map *)currentMap;
-(void)generateNewMap:(int)level;
-(void)setMapSize:(int)level;
-(Tile*)getTileAtPosX:(int)x posY:(int)y;
@end
