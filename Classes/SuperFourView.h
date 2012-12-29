//
//  SuperFourView.h
//  SuperFour
//
//  Created by acelan on 2011/5/16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperFourBoard.h"
#import "SuperFourBrain.h"
#import "SuperFourStone.h"

@interface SuperFourView : UIView {
	SuperFourBoard *board;
	SuperFourStone *stone;
	SuperFourBrain *brain;
    CGRect _rect;
}
- (void) restart;

@end
