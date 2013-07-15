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
    NSString *imageName;
    NSString *thumbnail;
    NSString *diet;
    NSString *type;
    NSMutableArray *terrains;
    NSMutableArray *climates;
    NSMutableArray *keyWords;
}
@property (assign,readonly) int point;
@property (assign,readonly) int move;
@property (assign,readonly) int foodChain;
@property (assign,readonly) int cardID;
@property (assign,readonly) int scale;
@property (retain,readwrite) NSString *imageName;
@property (retain,readwrite) NSString *thumbnail;
@property (retain,readwrite) NSString *diet;
@property (retain,readwrite) NSString *type;
@property (retain,readwrite) NSMutableArray *terrains;
@property (retain,readwrite) NSMutableArray *climates;
@property (retain,readwrite) NSMutableArray *keywords;

-(id)initWithData:(FMResultSet*)rs card:(int)card;
//-(void)eventCardEvent: (Map*) map;

@end
