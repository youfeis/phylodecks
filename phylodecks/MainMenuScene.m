//
//  MainMenuScene.m
//  phylodecks
//
//  Created by Sun, You Fei on 13-06-29.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "MainMenuLayer.h"
#import "nodeTags.h"
#import "Player.h"

@implementation MainMenuScene

-(id)init {
    // always call super init
    self = [super init];
    if (self != nil) {
        // add the introlayer into introscene
        MainMenuLayer *mainMenuLayer = [MainMenuLayer node];
        [self addChild: mainMenuLayer z:-1 tag:mainMenuLayerTag];
        // when call player currentplayer side effect is that currentplayer will be initialized
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if([[Player currentPlayer] isLastPlayerExist]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:[NSString stringWithFormat:@"%@",[[Player currentPlayer] playerName]] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Not You?", nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Please enter your name to play" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
                alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                [alert show];
            }
            
        });
        
       
        
        
    }
    return self;
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0) {
        
        if (alert.alertViewStyle == UIAlertViewStylePlainTextInput){
            [[Player currentPlayer] setPlayerName: [[alert textFieldAtIndex:0] text]];
        }
    }
    if(buttonIndex==1) {
        //goto player selection scene
    }
}

@end
