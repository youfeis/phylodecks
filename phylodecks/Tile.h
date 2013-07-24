//
//  Tile.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-06.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Card.h"
#import "Map.h"

@interface Tile : NSObject {
    Card *card;
    int posX;
    int posY;    
    BOOL isTarget;
}

@property (retain,readwrite) Card* card;
@property (assign,readonly) int posX;
@property (assign,readonly) int posY;
@property (assign,readwrite) BOOL isTarget;

-(id)initWithPosX: (int)x posY: (int)y;
-(BOOL)isCompatible: (Card*) card;
-(NSMutableArray *)getArrayWithRadius: (int)distance;
-(BOOL)hasCard;


@end
