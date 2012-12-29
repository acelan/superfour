//
//  SuperFourStone.m
//  SuperFour
//
//  Created by acelan on 2011/5/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SuperFourStone.h"


@implementation SuperFourStone
@synthesize stoneColor;

#define CHEESE_RADIUS	30

- (id)initWithFrame:(CGRect)frame {
	
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        // Initialization code.
    }
    return self;
}

- (void) setColor:(UIColor*)color
{
	self.stoneColor = color;
}

- (void)drawCircleAtPoint:(CGPoint)pt withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
	CGContextBeginPath(context);
	CGContextAddArc(context, pt.x+radius, pt.y+radius, radius, 0, 2*M_PI, YES);
	CGContextStrokePath(context);
}

- (void)drawCheese:(CGContextRef)context
{
	CGContextSetLineWidth(context, 5.0);
	[stoneColor setStroke];
	[self drawCircleAtPoint:CGPointMake(5,5) withRadius:CHEESE_RADIUS-5 inContext:context];
	
	CGPoint points[]= {
		CGPointMake(0, arc4random()%60),
		CGPointMake(60, arc4random()%60),
		CGPointMake(0, arc4random()%60),
		CGPointMake(60, arc4random()%60),
		CGPointMake(0, arc4random()%60),
		CGPointMake(60, arc4random()%60)
	};
	CGContextBeginPath(context);
	CGContextAddLines(context, points, 6);
	CGContextStrokePath(context);
//	CGContextSetFillColorWithColor(context, [self stoneColor].CGColor);
//	CGContextFillEllipseInRect(context, CGRectMake(0, 0, CHEESE_RADIUS*2, CHEESE_RADIUS*2));

}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[UIView beginAnimations:@"moveStone" context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1.0f];
	
	UITouch *touch = [touches anyObject];
	CGPoint pt = [touch locationInView:self.superview];
	CGRect rect = [self frame];	
	
	rect.origin.x = pt.x - CHEESE_RADIUS;
	rect.origin.y = pt.y - CHEESE_RADIUS;
	// move to new location
	self.frame = rect;
	
//	NSLog(@"position= (%f,%f)",pt.x,pt.y);
	[UIView commitAnimations];
}

- (void) moveTo:(CGPoint)pt
{	[UIView beginAnimations:@"moveStone" context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDuration:1.0f];
	
	CGRect rect = [self frame];	
	
	rect.origin.x = pt.x - CHEESE_RADIUS;
	rect.origin.y = pt.y - CHEESE_RADIUS;
	// move to new location
	self.frame = rect;
	
	[UIView commitAnimations];
}

- (void)drawRect:(CGRect)rect {
//	NSLog(@"drawRect - Stone (%f,%f)", ptt.x, ptt.y); // (0,0)
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext(context);
	[self drawCheese:context];
	UIGraphicsPopContext();	
}

- (void)dealloc {
    [super dealloc];
}


@end
