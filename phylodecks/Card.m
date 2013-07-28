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
@synthesize imageName;
@synthesize thumbnail;
@synthesize diet;
@synthesize type;
@synthesize climates;
@synthesize terrains;
@synthesize keywords;



-(id)initWithData:(FMResultSet*)rs card:(int)card{
    //Initlize card information from a database resultset
    
    point = [rs intForColumn:@"point"];
    move = [rs intForColumn:@"move"];
    foodChain = [rs intForColumn:@"foodChain"];
    cardID = card;
    self.imageName = [rs stringForColumn:@"image"];
    self.thumbnail = [rs stringForColumn:@"thumbnail"];
    self.diet =  [rs stringForColumn:@"diet"];
    self.type = [rs stringForColumn:@"type"];
    self.climates = [NSMutableArray arrayWithArray:[[rs stringForColumn:@"climates"] componentsSeparatedByString:@","]];
    self.terrains = [NSMutableArray arrayWithArray:[[rs stringForColumn:@"terrains"] componentsSeparatedByString:@","]];
    self.keywords = [NSMutableArray arrayWithArray:[[rs stringForColumn:@"keywords"] componentsSeparatedByString:@","]];
    
    return self;
}



@end
