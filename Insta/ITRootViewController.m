//
//  ITRootViewController.m
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import "ITRootViewController.h"
#import "ITAppServices.h"

@implementation ITRootViewController

- (instancetype)init {
    
    BOOL isLogedIn = [ITAppServices isLogedIn];
    __kindof UIViewController *controller = isLogedIn ?
    [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PostsViewController"] :
    [[ITLoginViewController alloc] init];
    
    if (self = [super initWithRootViewController:controller]) {
        self.navigationBarHidden = true;
        self.interactivePopGestureRecognizer.enabled = false;
        
        if (isLogedIn)
            _postsViewController = controller;
        else
            _loginViewController = controller;
            _loginViewController.delegate = self;
    }
    
    return self;
}

- (void)showPosts {
    if (!_postsViewController) {
        _postsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PostsViewController"];
    }
    [self showViewController:_postsViewController sender:self];
}

- (void)dealloc {
    _loginViewController = nil;
    _postsViewController = nil;
}

@end
