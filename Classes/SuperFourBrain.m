//
//  SuperFourBrain.m
//  SuperFour
//
//  Created by acelan on 2011/5/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SuperFourBrain.h"


@implementation SuperFourBrain

@synthesize gameOver;

#define USER		1
#define COMPUTER	2

- (BOOL) isAValidPositionAt:(NSInteger)x
{
	if (board[x][5] == 0) {
		return YES;
	}
	return NO;
}

- (BOOL) isAValidPositionAt:(NSInteger)x andY:(NSInteger)y
{
	if ( board[x][y] == 0) {
		if ( y == 0) {
			return YES;
		} else if (board[x][y-1] != 0) {
			return YES;
		}
	}
	return NO;
}

- (void) addStone:(NSInteger)stone at:(NSInteger)column
{
	for (int i = 0; i < 6; i++) {
		if (board[column][i] == 0) {
			board[column][i] = stone;
			break;
		}
	}
}

- (NSInteger) getScore:(NSInteger)who atX:(NSInteger)x andY:(NSInteger)y
{
	int i= x, j= y, steps= 0, enemy= USER+ COMPUTER- who;
	int score= 0;
	int line= 5, pp= 8;					// one line can get 5 score, one stone can get 8 score
	
	// to right
	i= x;
	while( ( board[ i][ j] != enemy)	// no enemy stone
		  && ( i < 6))					// within the board
	{
		i++;							// move one step to right
		if( board[ i][ j] != enemy)		// right location doesn't have enemy's stone
		{
			steps++;					// it's empty or might be our stone
			if( board[ i][ j] == who)	// it's our stone on the right
				score+= pp;				// add the score because of the connection
		}
        else
            break;
	}
	if( steps >= 3)						// There are 3 more space can move forward
	{
		score+= line;					// This location can earn the score of line
		steps= 0;						// recount the steps while walking to left
										// we don't have to reset the value if the steps is not 3
	}
	
	// to left
	i= x;
	while( ( board[ i][ j] != enemy) && ( i > 0))
	{
		i--;							// move one step to left
		if( board[ i][ j] != enemy)
		{
			steps++;
			if( board[ i][ j] == who)
				score+= pp;
		}
        else
            break;
	}
	if( steps >= 3)
		score+= line;
	
	// to down
    steps= 0;
	i= x, j= y;
	while( ( board[ i][ j] != enemy) && ( j > 0))
	{
		j--;
		if( board[ i][ j] != enemy)
		{
			steps++;
			if( board[ i][ j] == who)
				score+= pp;
		}
        else
            break;
	}
	if( steps+ ( 6- y) >= 3)			// the space can move down and plus the space above
		score+= line;
	
	//算斜的..
	//往左下走
	steps= 0;
	i= x, j= y;
	while( ( board[ i][ j] != enemy) && ( i > 0) && ( j > 0))
	{
		i--;
		j--;
		if( board[ i][ i] != enemy)
		{
			steps++;
			if( board[ i][ j] == who)
				score+= pp;
		}
        else
            break;

        if( steps == 3)
            break;
	}
	if( steps == 3)
	{
		score+= line;
		steps= 0;                       // we don't have to reset the value if the steps is not 3
	}
	//往右上走
	i= x, j= y;
	while( ( board[ i][ j] != enemy) && ( i < 6) && ( j < 5))
	{
		i++;
		j++;
		if( board[ i][ j] != enemy)
		{
			steps++;
			if( board[ i][ j] == who)
				score+= pp;
		}
        else
            break;

        if( steps == 3)
            break;
	}
	if( steps == 3)
		score+= line;
    
	//往右下走
    steps= 0;
	i= x, j= y;
	while( ( board[ i][ j] != enemy) && ( i < 6) && ( j > 0))
	{
		i++;
		j--;
		if( board[ i][ j] != enemy)
		{
			steps++;
			if( board[ i][ j] == who)
				score+= pp;
		}
        else
            break;
        
        if( steps == 3)
            break;
	}
	if( steps == 3)
    {
		score+= line;
        steps= 0;
    }
	//往左上走
	i= x, j= y;
	while( ( board[ i][ j] != enemy)  && ( i > 0) && ( j < 5))
	{
		i--;
		j++;
		if( board[ i][ j] != enemy)
		{
			steps++;
			if( board[ i][ j] == who)
				score+= pp;
		}
        else
            break;
        
        if( steps == 3)
            break;
	}
	if( steps == 3)
		score+= line;
	
	return score;
}

- (void) printScoreMap
{
	int j= 5;
	NSLog(@"%4d %4d %4d %4d %4d %4d %4d", scoreMap[0][j], scoreMap[1][j], scoreMap[2][j], scoreMap[3][j], scoreMap[4][j], scoreMap[5][j], scoreMap[6][j]);
	j--;
	NSLog(@"%4d %4d %4d %4d %4d %4d %4d", scoreMap[0][j], scoreMap[1][j], scoreMap[2][j], scoreMap[3][j], scoreMap[4][j], scoreMap[5][j], scoreMap[6][j]);
	j--;
	NSLog(@"%4d %4d %4d %4d %4d %4d %4d", scoreMap[0][j], scoreMap[1][j], scoreMap[2][j], scoreMap[3][j], scoreMap[4][j], scoreMap[5][j], scoreMap[6][j]);
	j--;
	NSLog(@"%4d %4d %4d %4d %4d %4d %4d", scoreMap[0][j], scoreMap[1][j], scoreMap[2][j], scoreMap[3][j], scoreMap[4][j], scoreMap[5][j], scoreMap[6][j]);
	j--;
	NSLog(@"%4d %4d %4d %4d %4d %4d %4d", scoreMap[0][j], scoreMap[1][j], scoreMap[2][j], scoreMap[3][j], scoreMap[4][j], scoreMap[5][j], scoreMap[6][j]);
	j--;
	NSLog(@"%4d %4d %4d %4d %4d %4d %4d", scoreMap[0][j], scoreMap[1][j], scoreMap[2][j], scoreMap[3][j], scoreMap[4][j], scoreMap[5][j], scoreMap[6][j]);
	NSLog(@"------------------------------------");
}

- (void) pushBoard
{
	for( int i= 0; i < 7; i++)
		for( int j= 0; j < 6; j++)
			backupBoard[ i][ j]= board[ i][ j];
}

- (void) popBoard
{
	for( int i= 0; i < 7; i++)
		for( int j= 0; j < 6; j++)
			board[ i][ j]= backupBoard[ i][ j];
}

- (int) getRowFromColumn:(int)column
{
	int j= 0;
	for (j= 5; j>= 0; j--) {
		if (board[column][j] != 0) {
			break;
		}
	}

	return j;			// j will become -1 if can't find the row number
}

- (BOOL) willWin:(NSInteger)who at:(int)column
{
	int x= column, y= [self getRowFromColumn:column];
	int i= x, j= y;
	int steps= 0, counter= 0;
	
	// 往下
	if( j >= 3) {			// there are enough space to have 4 stones
		if( board[i][j] == board[i][j-1] && board[i][j-1] == board[i][j-2] && board[i][j-2] == board[i][j-3] && board[i][j] == who) {
			return YES;
		}
	}
	
	// 水平
    int counter1= 1, counter2= 1;
	i= x, j= y;
    // 右邊空間
	while( i < 6 && counter1 < 4) {
		i++, counter1++;
	}
	i= x, j= y;
    // 左邊空間
    while( i > 0 && counter2 < 4) {
		i--, counter2++;
	}
    // not enough space?
    counter= counter1+ counter2- 1;
	if( counter < 4)
        return NO;
    
	for( steps= 0; counter > 0; counter--, i++) {
		if( board[i][j] == who) steps++;
        else steps= 0;
        
		if( steps == 4)
            return YES;
	}
    
	// 右上左下
	counter1= 1, counter2= 1;
	i= x, j= y;
    // 右上空間
	while( i < 6 && j < 5 && counter1 < 4) {
		i++, j++, counter1++;
	}
	i= x, j= y;
    // 左下空間
    while( i > 0 && j > 0 && counter2 < 4) {
		i--, j--, counter2++;
	}
    // not enough space?
    counter= counter1+ counter2- 1;
	if( counter < 4)
        return NO;
    
	for( steps= 0; counter > 0; counter--, i++, j++) {
		if( board[i][j] == who) steps++;
        else steps= 0;
        
		if( steps == 4)
            return YES;
	}
	
	// 左上右下
	counter1= 1, counter2= 1;
	i= x, j= y;
    // 左上空間
	while( i > 0 && j < 5 && counter1 < 4) {
		i--, j++, counter1++;
	}
    i= x, j= y;
    // 右下空間
	while( i < 6 && j > 0 && counter2 < 4) {
		i++, j--, counter2++;
	}
    // not enough space?
    counter= counter1+ counter2- 1;
	if( counter < 4)
        return NO;
    
	for ( steps= 0; counter > 0; counter--, i--,j++) {
		if( board[i][j] == who) steps++;
        else steps= 0;
        
		if( steps == 4)
            return YES;
	}
	
	return NO;
}

- (void) updateScoreMap
{
	// clear score map
	for (int i = 0; i < 7; i++) {
		for (int j = 0; j < 6; j++) {
			scoreMap[ i][ j] = 0;
		}
	}
	
	// calculate score by stones
	for( int i= 0; i < 7; i++)
		for( int j= 0; j < 6; j++)
			if( [self isAValidPositionAt:i andY:j])
			{
				scoreMap[ i][ j]= [self getScore:COMPUTER atX:i andY:j];
				scoreMap[ i][ j]+= [self getScore:USER atX:i andY:j];
			}
	
	// find if there exist a 2 stones pattern that do not be blocked by computer's stones
	for (int i=0; i<4; i++) {
		for (int j=i+1; j<=i+3; j++) {
			[self pushBoard];
			[self addStone:USER at:i];
			[self addStone:USER at:j];
			do {
				if ([self willWin:USER at:i]) {
					int m= [self getRowFromColumn:i], n= [self getRowFromColumn:j];
					int ratio= (n-m)/(j-i);
					
					// special live patterns
					if ( ( i == 0) && ( j == i + 3) && (board[j+1][n+ratio] == 0)) { scoreMap[j][n]= 800; break; }
					if ( ( j == 6) && ( i == j - 3) && (board[i-1][m+ratio] == 0)) { scoreMap[i][m]= 800; break; }
					
					// a hole in between the 2 stones
					if ( ( j- i) == 2) {
						if ( (board[i-1][m+ratio] == 0) && (board[j+2][n+ratio] == 0)) { scoreMap[j][n]= 800; break; }
					} else {	// two connected stones
						if ((i>=2) && (board[i-2][m+ratio] == 0)) { scoreMap[i][m]= 800; break; }
						if ((j<=4) && (board[j+2][n+ratio] == 0)) { scoreMap[j][n]= 800; break; }
					}
				}		
			} while (0);

			[self popBoard];
		}
	}

	// find if there exist a 2 stones pattern that do not be blocked by user's stones
	for (int i=0; i<4; i++) {
		for (int j=i+1; j<=3; j++) {
			[self pushBoard];
			[self addStone:COMPUTER at:i];
			[self addStone:COMPUTER at:j];
			do {
				if ([self willWin:COMPUTER at:i]) {
					int m= [self getRowFromColumn:i], n= [self getRowFromColumn:j];
					int ratio= (n-m)/(j-i);
					
					// special live patterns
					if ( ( i == 0) && ( j == i + 3) && (board[j+1][n+ratio] == 0)) { scoreMap[j][n]= 850; break; }
					if ( ( j == 6) && ( i == j - 3) && (board[i-1][m+ratio] == 0)) { scoreMap[i][m]= 850; break; }
					
					// a hole in between the 2 stones
					if ( ( j- i) == 2) {
						if ( (board[i-1][m+ratio] == 0) && (board[j+2][n+ratio] == 0)) { scoreMap[j][n]= 850; break; }
					} else {	// two connected stones
						if ((i>=2) && (board[i-2][m+ratio] == 0)) { scoreMap[i][m]= 850; break; }
						if ((j<=4) && (board[j+2][n+ratio] == 0)) { scoreMap[j][n]= 850; break; }
					}
				}		
			} while (0);
			
			[self popBoard];
		}
	}
	
	// decrease the score if the location will kill ourself
	for (int i= 0; i < 7; i++) {
		[self pushBoard];
		[self addStone:USER at:i];
		[self addStone:COMPUTER at:i];		// if we can win at this location, then we shouldn't put stone at this location before user
		if ([self willWin:COMPUTER at:i]) {
			scoreMap[ i][[self getRowFromColumn:i]-1] = -1;
		}
		[self popBoard];
	}
	
	// decrease the score if the location will help user
	for (int i= 0; i < 7; i++) {
		[self pushBoard];
		[self addStone:COMPUTER at:i];
		[self addStone:USER at:i];			// if user can win at this location, then we shouldn't put stone at this location
		if ([self willWin:USER at:i]) {
			scoreMap[ i][[self getRowFromColumn:i]-1] = -2;
		}
		[self popBoard];
	}
		
	// recalculate score by adding one more stone for user
	for (int i= 0; i < 7; i++) {
		if (![self isAValidPositionAt:i]) continue;
		
		[self pushBoard];
		[self addStone:USER at:i];
		if ([self willWin:USER at:i]) {
			scoreMap[ i][[self getRowFromColumn:i]] = 900;
		}
		[self popBoard];
	}
	
	// recalculate score by adding one more stone for computer
	for (int i= 0; i < 7; i++) {
		if (![self isAValidPositionAt:i]) continue;
		
		[self pushBoard];
		[self addStone:COMPUTER at:i];
		if ([self willWin:COMPUTER at:i]) {
			scoreMap[ i][[self getRowFromColumn:i]] = 999;
		}
		[self popBoard];
	}
	
//	[self printScoreMap];
}

- (int) getHighestScoreLocation
{
	int score= -2;								//最低分
	int posi= -1;
	
	int i, j;
	for( i= 0; i< 7; i++)
		for( j= 0; j< 6; j++)
			if( scoreMap[ i][ j] >= score)		//分數地圖中有比目前最高分還高的分數
				if( [self isAValidPositionAt:i andY:j])	//是可以下子的位置嗎...
				{
					score= scoreMap[ i][ j];		//那就取出此分數
					posi= i;						//並記錄下這個位置
				}
	return posi;
}

- (void) userAddStoneAt:(NSInteger)column
{
	[self addStone:USER at:column];
	gameOver= [self willWin:USER at:column];
	// It's impossible that user add the stone in the wrong column
}

- (NSInteger) computerAddStone
{
	int column;
	[self updateScoreMap];
	
	column= [self getHighestScoreLocation];
	[self addStone:COMPUTER at:column];
	gameOver= [self willWin:COMPUTER at:column];
	return column;
}

- (BOOL) isGameOver
{
//	NSLog(@"Game over= %d", gameOver);
	return gameOver;
}

- (void) initBoard
{
    for( int i= 0; i< 7; i++)
		for( int j= 0; j< 6; j++)
            board[ i][ j]= 0;
					
}

- (void) initScoreMap
{
    for( int i= 0; i< 7; i++)
		for( int j= 0; j< 6; j++)
            scoreMap[ i][ j]= 0;
}

- (void) restart
{
    gameOver= false;
    [self initBoard];
    [self initScoreMap];
}

@end
