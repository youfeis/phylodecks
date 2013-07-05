//
//  Card.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "FMDatabase.h"

@interface Card : CCSprite {
    int point;
    int move;
    int foodChain;
    int cardID;
    int scale;
    NSString *image;
    NSString *thumbnail;
    NSString *diet;
    NSString *type;
    NSArray *terrains;
    NSArray *climates;
    NSArray *keyWords;
}
@property (assign,readonly) int point;
@property (assign,readonly) int move;
@property (assign,readonly) int foodChain;
@property (assign,readonly) int cardID;
@property (assign,readonly) int scale;
@property (retain,readonly) NSString *image;
@property (retain,readonly) NSString *thumbnail;
@property (retain,readonly) NSString *diet;
@property (retain,readonly) NSString *type;
@property (retain,readonly) NSArray *terrains;
@property (retain,readonly) NSArray *climates;
@property (retain,readonly) NSArray *keywords;

-(id)initWithData:(FMResultSet*)rs card:(int)card;
//-(void)eventCardEvent: (Map*) map;

@end
