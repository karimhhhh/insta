//
//  ITLoginButton.h
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITLoginButton : UIButton

@property (strong, nonatomic) UIActivityIndicatorView *spinner;

- (void)startAnimating;
- (void)stopAnimating;

@end
