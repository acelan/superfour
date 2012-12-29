//
//  SuperFourStone.h
//  SuperFour
//
//  Created by acelan on 2011/5/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SuperFourStone : UIView {
	UIColor* stoneColor;
}

@property (retain) UIColor* stoneColor;
- (void) moveTo:(CGPoint)pt;
- (void) setColor:(UIColor*)color;

@end
