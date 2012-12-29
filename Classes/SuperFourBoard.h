//
//  SuperFourBoard.h
//  SuperFour
//
//  Created by acelan on 2011/5/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SuperFourBoard : UIView {
	int width, height, lastMove;
	int board[ 7][ 6];
	CGPoint positionBoard[ 7][ 6];
}

- (NSInteger) convertPositionToInteger:(CGPoint)pt;
- (NSInteger) addStone:(NSInteger)column;
- (BOOL) isAValidPosition:(CGPoint)pt;
- (CGPoint) lastStonePosition;
- (void) initBoard;
- (void) restart;

@property int width, height, lastMove;

@end
