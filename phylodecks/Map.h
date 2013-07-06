//
//  Map.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-05.
//
//

#import <Foundation/Foundation.h>

@interface Map : NSObject{
    NSMutableArray *mapInventory;
}
@property (retain,readwrite) NSMutableArray *mapInventory;

+(Map *)currentMap;
@end
