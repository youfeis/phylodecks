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
    return self;
}

@end
