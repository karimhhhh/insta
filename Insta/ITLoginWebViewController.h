//
//  ITLoginWebViewController.h
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ITLoginWebViewControllerCompletionBlock)(NSURL *url);
typedef void (^ITLoginWebViewControllerDoneBlock)();

@interface ITLoginWebViewController : UIViewController

- (instancetype)initWithURL:(NSURL *)URL;

@property (nonatomic) ITLoginWebViewControllerCompletionBlock completionBlock;
@property (nonatomic) ITLoginWebViewControllerDoneBlock doneBlock;


@end
