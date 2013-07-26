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
@synthesize _xmlDoc;

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
    [self set_xmlDoc:[[GDataXMLDocument alloc] initWithData:xmlData
                                                    options:0 error:&error]];
}

-(void) loadRecentPlayer{
    NSArray *playerInfo = [_xmlDoc.rootElement elementsForName:@"Player"];
    GDataXMLElement *currentName = (GDataXMLElement *)[playerInfo objectAtIndex:0];
    playerName = currentName.stringValue;
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
    [self setLastLogin: [dateFormat dateFromString:dateStr]];
    
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

-(void)reloadPlayer{
    
}

-(NSArray *)loadAllPlayerName{
    NSArray *playerList;
    NSString *xPath;
    xPath = [NSString stringWithFormat:@"//Users/Player/Name"];
    playerList = [_xmlDoc.rootElement nodesForXPath:xPath error: nil];
    NSMutableArray *rtn = [[NSMutableArray alloc] init];
    for (GDataXMLElement* obj in playerList){
        [rtn addObject:obj.stringValue];
    }
    
    return rtn;
    
}

-(void)saveData{
    
    GDataXMLElement * usersElement =
    [GDataXMLNode elementWithName:@"Users"];
    
    GDataXMLElement * recentPlayer =
    [GDataXMLNode elementWithName:@"Player"];
    
    NSArray *attr = [[NSArray alloc]
                     initWithObjects:[GDataXMLNode namespaceWithName:@"recent"
                                                         stringValue:@"YES"], nil];
    
    [recentPlayer setNamespaces:attr];
    
    GDataXMLElement * playerElement =
    [GDataXMLNode elementWithName:@"Player"];
    
    GDataXMLElement * nameElement =
    [GDataXMLNode elementWithName:@"Name" stringValue:playerName];
    
    GDataXMLElement * levelElement =
    [GDataXMLNode elementWithName:@"Level" stringValue:[NSString stringWithFormat:@"%i",playerLevel]];
    
    GDataXMLElement * expElement =
    [GDataXMLNode elementWithName:@"Experience" stringValue:[NSString stringWithFormat:@"%i",playerExp]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSString *dateString =[dateFormat stringFromDate:lastLogin];
    
    GDataXMLElement * lastLoginElement =
    [GDataXMLNode elementWithName:@"LastLogin" stringValue: dateString];
    
    GDataXMLElement * battleLeftElement =
    [GDataXMLNode elementWithName:@"GPSBattleLeft" stringValue:[NSString stringWithFormat:@"%i",GPSBattleLeft]];
    
    GDataXMLElement * inventoryElement =
    [GDataXMLNode elementWithName:@"Inventory"];
    
    
    for(NSNumber *card in _playerInventory){
        GDataXMLElement * cardElement =
        [GDataXMLNode elementWithName:@"CardID" stringValue:[NSString stringWithFormat:@"%i",card.intValue]];
        [inventoryElement addChild:cardElement];
    }
    
    [recentPlayer addChild:nameElement];
    [usersElement addChild:recentPlayer];
    [playerElement addChild:nameElement];
    [playerElement addChild:levelElement];
    [playerElement addChild:expElement];
    [playerElement addChild:lastLoginElement];
    [playerElement addChild:battleLeftElement];
    [playerElement addChild:inventoryElement];
    [usersElement addChild:playerElement];
    

    
    GDataXMLDocument *document = [[[GDataXMLDocument alloc]
                                   initWithRootElement:usersElement] autorelease];
    
    NSData *data = document.XMLData;
    

    
    NSString *filePath = [self dataFilePath:YES];
    NSLog(@"Saving xml data to %@...", filePath);
    [data writeToFile:filePath atomically:YES];

    
}

@end
