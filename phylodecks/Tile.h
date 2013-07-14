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

@interface Tile : CCSprite {
    Card *card;
    int posX;
    int posY;
}

@property (retain,readwrite) Card* card;
@property (assign,readonly) int posX;
@property (assign,readonly) int posY;
-(id)initWithPosX: (int)x posY: (int)y;

@end
