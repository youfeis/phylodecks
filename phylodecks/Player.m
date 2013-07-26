//
//  Player.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-07-01.
//
//

#import "Player.h"


@implementation Player
static Player *sharedInstance = nil;

@synthesize playerLevel;
@synthesize playerName;
@synthesize isLastPlayerExist;
@synthesize GPSBattleLeft;
@synthesize playerInventory = _playerInventory;
@synthesize lastLogin = _lastLogin;

-(id) init{
    self = [super init];
    if (self != nil){
        _playerInventory = [[NSMutableArray alloc] init];
        [self loadXMLFile];
        [self loadRecentPlayer];
        [self loadPlayerStats];
        [self releaseXMLFile];
        if([playerName isEqualToString:@""]){
            isLastPlayerExist = NO;
        }else{
            isLastPlayerExist = YES;
        }
    }
    
    return self;
}

-(void) loadXMLFile{
    NSString *filePath = [self dataFilePath: NO];
    xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    _xmlDoc = [[GDataXMLDocument alloc] initWithData:xmlData
                                   options:0 error:&error];
}

-(void) loadRecentPlayer{
    NSArray *playerInfo = [_xmlDoc.rootElement elementsForName:@"Player"];
    GDataXMLElement *currentName = (GDataXMLElement *)[playerInfo objectAtIndex:0];
    playerName = currentName.stringValue;
    NSLog(@"%@",playerName);
}

-(void) loadPlayerStats{
    NSString *xPath;
    NSArray *playerInfo;
    
    xPath = [NSString stringWithFormat:@"//Users/Player[Name = \"%@\"]/Level",playerName];
    playerInfo = [_xmlDoc.rootElement nodesForXPath:xPath error: nil];
    GDataXMLElement *level = (GDataXMLElement *)[playerInfo objectAtIndex:0];
    playerLevel = level.stringValue.intValue;
    
    xPath = [NSString stringWithFormat:@"//Users/Player[Name = \"%@\"]/Experience",playerName];
    playerInfo = [_xmlDoc.rootElement nodesForXPath:xPath error: nil];
    GDataXMLElement *exp = (GDataXMLElement *)[playerInfo objectAtIndex:0];
    playerExp = exp.stringValue.intValue;
    
    xPath = [NSString stringWithFormat:@"//Users/Player[Name = \"%@\"]/GPSBattleLeft",playerName];
    playerInfo = [_xmlDoc.rootElement nodesForXPath:xPath error: nil];
    GDataXMLElement *count = (GDataXMLElement *)[playerInfo objectAtIndex:0];
    GPSBattleLeft = count.stringValue.intValue;
    
    xPath = [NSString stringWithFormat:@"//Users/Player[Name = \"%@\"]/Inventory/CardID",playerName];
    playerInfo = [_xmlDoc.rootElement nodesForXPath:xPath error: nil];
    for(id obj in playerInfo){
        GDataXMLElement *card = (GDataXMLElement *)obj;
        [_playerInventory  addObject: [NSNumber numberWithInt:card.stringValue.intValue]];
        
    }
    
    xPath = [NSString stringWithFormat:@"//Users/Player[Name = \"%@\"]/LastLogin",playerName];
    playerInfo = [_xmlDoc.rootElement nodesForXPath:xPath error: nil];
    GDataXMLElement *date = (GDataXMLElement *)[playerInfo objectAtIndex:0];
    NSString *dateStr = date.stringValue;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    lastLogin = [dateFormat dateFromString:dateStr];
    
}

-(void) releaseXMLFile{
    [xmlData release];
    [_xmlDoc release];
}

+(Player *)currentPlayer{
    if (sharedInstance == nil){
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (NSString *)dataFilePath:(BOOL)forSave {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory
                               stringByAppendingPathComponent:@"userData.xml"];
    if (forSave ||
        [[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
        return documentsPath;
    } else {
        return [[NSBundle mainBundle] pathForResource:@"userData" ofType:@"xml"];
    }

}


- (oneway void)release{
    
}

@end
