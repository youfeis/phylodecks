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


@interface Map : NSObject{
    NSMutableArray *mapInventory;
    NSMutableArray *tiles;
}
@property (retain,readwrite) NSMutableArray *mapInventory;
@property (retain,readwrite) NSMutableArray *tiles;

+(Map *)currentMap;
-(void)generateNewMap:(int)level;
-(void)setMapSize:(int)level;
-(Tile*)getTileAtPosX:(int)x posY:(int)y;
@end
