//
//  GameOverScene.h
//  phylodecks
//
//  Created by Youfei Sun on 7/28/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameOverLayer.h"
#import "GameWinLayer.h"
#import "Player.h"
#import "Map.h"

@interface GameOverScene : CCScene{
    int mode;
}
-(id)initWithMode:(int)modeCode;
@end
