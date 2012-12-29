//
//  SuperFourAppDelegate.h
//  SuperFour
//
//  Created by acelan on 2011/5/16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SuperFourViewController;

@interface SuperFourAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SuperFourViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SuperFourViewController *viewController;

@end

