//
//  SuperFourView.m
//  SuperFour
//
//  Created by acelan on 2011/5/16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SuperFourView.h"
#import "SuperFourBoard.h"

@implementation SuperFourView

#define STONE_START_X	730
#define STONE_START_Y	130
#define CHEESE_RADIUS	32		// a little bigger than real stone

- (SuperFourBrain *)brain
{
	if (!brain) {
		brain = [[SuperFourBrain alloc] init];
	}
	return brain;
}

- (SuperFourBoard *)initBoard:(CGRect)rect
{
	if (!board) {
		board = [[SuperFourBoard alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        _rect= rect;
	}
	return board;
}

- (void)gameOverAlert:(NSString*)winner
{
	NSString *msg= [NSString stringWithFormat:@"%@ wins", winner];
	UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Game Over!"
													  message:msg
													 delegate:self
											cancelButtonTitle:@"Again"
											otherButtonTitles:nil];
	[message show];
	[message release];
}

- (void)alertView:(UIAlertView*) alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self restart];
            break;
    }
}

- (void)gameLoop:(int)player
{
	if (player == 0) {
		// a stone for user
		stone = [[SuperFourStone alloc] initWithFrame:CGRectMake(STONE_START_X-CHEESE_RADIUS, STONE_START_Y-CHEESE_RADIUS, CHEESE_RADIUS*2, CHEESE_RADIUS*2)];
		[stone setColor:[UIColor redColor]];
		
		[self addSubview:stone];
        [stone release];
	} else {
		// a new stone for computer
		stone = [[SuperFourStone alloc] initWithFrame:CGRectMake(STONE_START_X-30, STONE_START_Y-30, 60, 60)];
		[stone setColor:[UIColor blueColor]];
		
		stone.userInteractionEnabled = NO;
		[self addSubview:stone];
        [stone release];
		
		NSInteger column = [[self brain] computerAddStone];
//		NSLog(@"computer column: %d", column);
		if (column < 0) {
			// computer lose
		}
		[board addStone:column];
		[stone moveTo:CGPointMake([board lastStonePosition].x, 100)];
		[stone moveTo:[board lastStonePosition]];
		stone = nil;
		[stone release];
		
		if ([brain isGameOver])
			[self gameOverAlert:@"Computer"];
		else
			[self gameLoop:0];
	}
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		// Initialization code.
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
	NSLog(@"drawRect");
	board = [self initBoard:rect];
	[self addSubview:board];
	[board release];
	
	[self gameLoop:0];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (![stone isUserInteractionEnabled]) { return; }

	UITouch *touch = [touches anyObject];
	CGPoint pt = [touch locationInView:self];
//	NSLog(@"touchended: (%f,%f)", pt.x , pt.y);

	// It's a random touch, not moving the stone
	if ( ( [stone frame].origin.x == STONE_START_X-CHEESE_RADIUS) && ([stone frame].origin.y == STONE_START_Y-CHEESE_RADIUS))
		return;
	
	if ( [board isAValidPosition:pt]) {
		stone.userInteractionEnabled = NO;
		NSInteger column = [board addStone:[board convertPositionToInteger:pt]];
//		NSLog(@"user column: %d", column);
		[[self brain] userAddStoneAt:column];
		[stone	moveTo:[board lastStonePosition]];
		stone = nil;
		[stone release];
		
		if ([brain isGameOver])
			[self gameOverAlert:@"User"];
		else
			[self gameLoop:1];
		
	} else {
		[stone moveTo:CGPointMake(STONE_START_X, STONE_START_Y)];
	}
}

- (void)restart {
//    [[self subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];

    int i= 0;
    for (UIView *view in self.subviews) {
        i++;
        if (i == 1)         // don't release board
            continue;
        [view removeFromSuperview];
    }

    [board restart];
    [brain restart];
    [self gameLoop:0];
}

- (void)dealloc {
    [[self subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [super dealloc];
}


@end
