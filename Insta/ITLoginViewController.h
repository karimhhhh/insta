//
//  ITLoginViewController.h
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>

@protocol ITLoginViewControllerDelegate <NSObject>

- (void)showPosts;

@end

@interface ITLoginViewController : UIViewController

@property (weak , nonatomic) id<ITLoginViewControllerDelegate>delegate;

@end
