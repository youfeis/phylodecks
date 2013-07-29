//
//  Tile.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-06.
//
//  A major class to determine if a card is logically compatible in a certain tile
//
#import "Tile.h"

@implementation Tile

@synthesize card;
@synthesize posX;
@synthesize posY;
@synthesize isTarget;

-(id)initWithPosX: (int)x posY: (int)y{
    self  = [super init];
    posX = x;
    posY = y;
    card = 0;
    isTarget = NO;
    return self;
}

-(BOOL)isCompatible: (Card*) selectedCard{
    //todo: implement event card compatiblilities
    if (![self hasNeighbour]){
        return NO;
    }else if(![self climateOK:selectedCard]){
        return NO;
    }else if(![self terrainOK:selectedCard]){
        return NO;
    }else if(![self foodChainOK:selectedCard]){
        return NO;
    }
    return YES;
}

// return a circle of tiles has the same distance with itself
-(NSMutableArray *)getArrayWithRadius: (int)distance{
    NSMutableArray *tileArray = [[NSMutableArray alloc] init];
    
    int index;
    int maxIndex = [[[Map currentMap] tiles] count] - 1;
    for(int i = 0;i < distance; i++){
        index = [self toIndexPosX:posX+i posY:posY+distance-i];
        if(index<=maxIndex && index >= 0){
            [tileArray addObject:[[Map currentMap] getTileAtPosX:posX + i posY:posY + distance - i]];
        }
    }
    for(int i = 0;i < distance; i++){
        index = [self toIndexPosX:posX+i+1 posY:posY-distance+i+1];
        if(index<=maxIndex && index >= 0){
            [tileArray addObject:[[Map currentMap] getTileAtPosX:posX +  i + 1 posY:posY - distance + i + 1]];
        }
    }
    for(int i = 0;i < distance; i++){
        index = [self toIndexPosX:posX-i-1 posY:posY+distance-i-1];
        if(index<=maxIndex && index >= 0){
            [tileArray addObject:[[Map currentMap] getTileAtPosX:posX - i - 1 posY:posY + distance - i - 1]];
        }
    }
    for(int i = 0;i < distance; i++){
        index = [self toIndexPosX:posX-i posY:posY-distance+i];
        if(index<=maxIndex && index >= 0){
            [tileArray addObject:[[Map currentMap] getTileAtPosX:posX - i posY:posY - distance + i]];
        }
    }
    
    return tileArray;
}



-(BOOL)hasNeighbour{
    for(id obj in [self getArrayWithRadius:1]){
        if([obj card]!=0){
            return YES;
        }
    }
    return NO;
}

-(BOOL)climateOK:(Card *)selectedCard{
    NSMutableArray *toCompare = [self getOccupiedTiles:[self getArrayWithRadius:1]];
    
    for (Tile* neighbourTile in toCompare){
        if([[[[neighbourTile card]climates] objectAtIndex:0] isEqual:@"ANY"]||[[[selectedCard climates] objectAtIndex:0] isEqual:@"ANY"]){
            return YES;
        }
        for( NSString* neighbourClimate in [[neighbourTile card] climates]){
            for(NSString* selfClimate in [selectedCard climates]){
                if([selfClimate isEqual:neighbourClimate]){
                    return YES;
                }
            }
            
        }
       
    }
    return NO;
}

-(BOOL)terrainOK:(Card *)selectedCard{
    NSMutableArray *toCompare = [self getOccupiedTiles:[self getArrayWithRadius:1]];
    
    for (Tile* neighbourTile in toCompare){
        if([[[[neighbourTile card]terrains] objectAtIndex:0] isEqual:@"ANY"]||[[[selectedCard terrains] objectAtIndex:0] isEqual:@"ANY"]){
            return YES;
        }
        for( NSString* neighbourClimate in [[neighbourTile card] terrains]){
            for(NSString* selfClimate in [selectedCard terrains]){
                if([selfClimate isEqual:neighbourClimate]){
                    return YES;
                }
            }
            
        }
        
    }
    return NO;
}

-(BOOL)foodChainOK:(Card *)selectedCard{
    NSMutableArray *toCompare = [self getOccupiedTiles:[self getArrayWithRadius:1]];
    if([selectedCard foodChain] == 1){
        return YES;
    }else if([selectedCard foodChain] == 2){
        for (Tile* neighbourTile in toCompare){
            if([[neighbourTile card] foodChain] == 1){
                return YES;
            }
        }
    }else if([selectedCard foodChain] == 3){
        for (Tile* neighbourTile in toCompare){
            if([[neighbourTile card] foodChain] == 3){
                if([selectedCard scale]>=[[neighbourTile card] scale]){
                    return YES;
                }
            }
            if([[neighbourTile card] foodChain] == 2){
                return YES;
            }
            if([[neighbourTile card] foodChain] == 1){
                
                if([[selectedCard diet] isEqual:@"OMNIVORE"]){
                    return YES;
                }
            }
        }
    }
    return NO;
}

-(int)toIndexPosX: (int)x posY:(int)y{
    return (y-1)*22+(x-1);
}

-(NSMutableArray *)getOccupiedTiles: (NSMutableArray *)arr{
    NSMutableArray * rtn = [[NSMutableArray alloc]init];
    for (Tile* obj in arr){
        if([obj card] != 0 && ![obj isTarget]){
            [rtn addObject:obj];
        }
    }
    return rtn;
}

-(BOOL)hasCard{
    if(card == 0){
        return NO;
    }else{
        return YES;
    }

}
@end
