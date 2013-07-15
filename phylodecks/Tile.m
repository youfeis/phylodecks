//
//  Tile.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-06.
//
//

#import "Tile.h"

@implementation Tile

@synthesize card;
@synthesize posX;
@synthesize posY;

-(id)initWithPosX: (int)x posY: (int)y{
    self  = [super init];
    posX = x;
    posY = y;
    card = 0;
    return self;
}

-(BOOL)isCompatible: (Card*) card{
    BOOL hasNeighbour = NO;
    for(id obj in [self getNeighbours]){
        if([obj card]!=0){
            hasNeighbour = YES;
        }
    }
    return hasNeighbour;
}

-(NSMutableArray *)getArrayWithRadius: (int)distance{
    NSMutableArray *tileArray = [[NSMutableArray alloc] init];
    
    [tileArray addObject:[[Map currentMap] getTileAtPosX:posX+1 posY:+1]];
    return tileArray;
}

-(NSMutableArray *)getNeighbours{
    NSMutableArray *tileArray = [[NSMutableArray alloc] init];
    [tileArray addObject:[[Map currentMap] getTileAtPosX:posX+0 posY:+1]];
    [tileArray addObject:[[Map currentMap] getTileAtPosX:posX+1 posY:+0]];
    [tileArray addObject:[[Map currentMap] getTileAtPosX:posX-1 posY:+0]];
    [tileArray addObject:[[Map currentMap] getTileAtPosX:posX+0 posY:-1]];
    return tileArray;
}

@end
