//
//  ITRootViewController.h
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITLoginViewController.h"
#import "ITPostsViewController.h"

@interface ITRootViewController : UINavigationController <ITLoginViewControllerDelegate>

@property (nullable, strong, nonatomic) ITLoginViewController *loginViewController;
@property (nullable, strong, nonatomic) ITPostsViewController *postsViewController;

@end

