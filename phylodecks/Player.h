//
//  Player.h
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-01.
//
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface Player : NSObject
{
    NSDate *lastLogin;
    int GPSBattleLeft;
    int playerLevel;
    int playerExp;
    NSMutableArray *playerInventory;
    NSString *playerName;
    BOOL isLastPlayerExist;
    NSData *xmlData;
    GDataXMLDocument *_xmlDoc;
}
@property (assign,readwrite) int playerLevel;
@property (retain,readwrite) NSString *playerName;
@property (assign,readonly) BOOL isLastPlayerExist;
@property (retain,readwrite) NSMutableArray *playerInventory;
@property (retain,readwrite) NSDate *lastLogin;
@property (assign,readwrite) int GPSBattleLeft;

+(Player *)currentPlayer;
-(void)loadXMLFile;
-(void)loadRecentPlayer;
-(void)loadPlayerStats;
-(void)releaseXMLFile;

@end
