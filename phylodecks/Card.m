//
//  Card.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-04.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Card.h"


@implementation Card

@synthesize point;
@synthesize move;
@synthesize foodChain;
@synthesize cardID;
@synthesize scale;
@synthesize image;
@synthesize thumbnail;
@synthesize diet;
@synthesize type;
@synthesize climates;
@synthesize terrains;
@synthesize keywords;

-(id)initWithData:(FMResultSet*)rs card:(int)card{
    while ([rs next]) {
		point = [rs intForColumn:@"point"];
        move = [rs intForColumn:@"move"];
        foodChain = [rs intForColumn:@"foodChain"];
        cardID = card;
        image = [rs stringForColumn:@"image"];
        thumbnail = [rs stringForColumn:@"thumbnail"];
        diet =  [rs stringForColumn:@"diet"];
        type = [rs stringForColumn:@"type"];
        climates = [[rs stringForColumn:@"climates"] componentsSeparatedByString:@","];
        terrains = [[rs stringForColumn:@"terrains"] componentsSeparatedByString:@","];
        keywords = [[rs stringForColumn:@"keywords"] componentsSeparatedByString:@","];
        [self setTexture:[[CCSprite spriteWithFile:image] texture]];
		
	}
    
    return self;
}

@end
