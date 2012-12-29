//
//  SuperFourBrain.h
//  SuperFour
//
//  Created by acelan on 2011/5/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SuperFourBrain : NSObject {
	int board[7][6];
	int backupBoard[7][6];
	int scoreMap[7][6];
	BOOL gameOver;
}

- (void) userAddStoneAt:(NSInteger)column;
- (NSInteger) computerAddStone;
- (BOOL) isGameOver;
- (void) initBoard;
- (void) initScoreMap;
- (void) restart;

@property BOOL gameOver;

@end
