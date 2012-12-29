//
//  SuperFourBoard.m
//  SuperFour
//
//  Created by acelan on 2011/5/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SuperFourBoard.h"


@implementation SuperFourBoard

@synthesize width, height, lastMove;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    return self;
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
	CGContextBeginPath(context);
	CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
	CGContextStrokePath(context);
}

- (void)drawBoard:(CGRect)rect inContext:(CGContextRef)context
{
#define UPPER_MARGIN	200
#define LEFT_MARGIN		50
#define RIGHT_MARGIN	50
#define BOTTOM_MARGIN	100
#define CHEESE_RADIUS_ON_BOARD	25
	
//	NSLog(@"drawBoard");
	CGContextSetLineWidth(context, 5.0);
	[[UIColor whiteColor] setStroke];
	float x = 0; //rect.origin.x;
	float y = 0; //rect.origin.y;
	float startX = x + LEFT_MARGIN;
	float startY = y + UPPER_MARGIN;
	self.width = rect.size.width - RIGHT_MARGIN - LEFT_MARGIN;
	self.height = rect.size.height - BOTTOM_MARGIN - UPPER_MARGIN;
	
	CGFloat components[]= { 0.4, 0.2, 0.3, 0.3};
	CGContextSetFillColor(context, components);
	CGContextFillRect(context, rect);
	
	CGContextBeginPath(context);
	CGContextAddRect(context, CGRectMake(startX, startY, width, height));
	CGContextStrokePath(context);
	
	CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
	CGContextFillRect(context, CGRectMake(startX, startY, width, height));
	
	CGContextSetShadow(context, CGSizeMake(7, 7), 5.0);
	
/*	
	for (float i = startX + 2 * CHEESE_RADIUS_ON_BOARD; i < startX + width - CHEESE_RADIUS_ON_BOARD; i+=(startX + width - 3*CHEESE_RADIUS_ON_BOARD)/7) {
		for (float j= startY + 2 * CHEESE_RADIUS_ON_BOARD; j < startY + height - CHEESE_RADIUS_ON_BOARD; j+=(startY + height - 3*CHEESE_RADIUS_ON_BOARD)/7) {	
*/
	for (int i = 0; i < 7; i++) {
		for (int j = 0; j < 6; j++) {
			CGPoint pt = CGPointMake( startX + 2 * CHEESE_RADIUS_ON_BOARD + i * (startX + width - 3*CHEESE_RADIUS_ON_BOARD)/7
									, startY + 2 * CHEESE_RADIUS_ON_BOARD + j * (startY + height - 3*CHEESE_RADIUS_ON_BOARD)/7);
			positionBoard[ i][ 5 - j] = pt;
			[self drawCircleAtPoint:pt withRadius:CHEESE_RADIUS_ON_BOARD inContext:context];
		}
	}
}

- (NSInteger) convertPositionToInteger:(CGPoint)pt
{
	int i;
	for ( i = 0; i < 7; i++) {
		if (positionBoard[i][0].x - ( positionBoard[1][0].x - positionBoard[0][0].x)/2 > pt.x) {
			break;
		}
	}
	return i - 1;
}

- (NSInteger) addStone:(NSInteger)column
{
	int i;
	for ( i = 0; i < 6; i++)
		if( board[ column][ i] == 0)
		{
			board[ column][ i] = 1;
			lastMove = column;
			break;
		}

	if ( i == 6) {
		lastMove = -1;
	}
	lastMove = column;
	return lastMove;
}

- (CGPoint) lastStonePosition
{
	int i;
	for (i = 0; i < 6; i++) {
		if (board[lastMove][i] == 0) {
			break;
		}
	}
	return positionBoard[ lastMove][ i- 1];
}

- (BOOL) isAValidPosition:(CGPoint)pt
{
//	NSLog(@"(%f,%f)", pt.x,pt.y);
	if (pt.y > UPPER_MARGIN) { return NO; }
	if (pt.x < LEFT_MARGIN || pt.x > RIGHT_MARGIN + [self width]) { return NO; }
	
	// the column is not full yet
	int i, column = [self convertPositionToInteger:pt];
	for ( i = 0; i < 6; i++)
		if( board[ column][ i] == 0)
			return YES;
	if ( i == 6) { return NO; }
	
	return YES;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext(context);
	[self drawBoard:rect inContext:context];
	UIGraphicsPopContext();	
}

- (void) initBoard
{
    for( int i= 0; i< 7; i++)
		for( int j= 0; j< 6; j++)
            board[ i][ j]= 0;
    
}

- (void)restart {
    // dealloc all stones
    // redraw board
    lastMove= -1;
    [self initBoard];
}

- (void)dealloc {
    [super dealloc];
}


@end
