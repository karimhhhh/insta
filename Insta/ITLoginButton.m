//
//  ITLoginButton.m
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import "ITLoginButton.h"
#import "ITAppServices.h"

@implementation ITLoginButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 6;
        self.clipsToBounds = true;
        [self setTitle:NSLocalizedString(@"LOGIN_BUTTON_TITLE", @"Login") forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[ITAppServices imageFromColor:[UIColor colorWithRed:0.2862 green:0.72549 blue:0.33725 alpha:1]] forState:UIControlStateNormal];
        
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _spinner.center = self.center;
        
        _spinner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
                                  | UIViewAutoresizingFlexibleRightMargin
                                  | UIViewAutoresizingFlexibleBottomMargin
                                  | UIViewAutoresizingFlexibleLeftMargin;
        
        _spinner.hidden = true;
        [self addSubview:_spinner];
    }
    return self;
}

- (void)startAnimating {
    self.enabled = false;
    _spinner.hidden = false;
    [_spinner startAnimating];
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setBackgroundImage:[ITAppServices imageFromColor:[UIColor colorWithRed:0.4980 green:0.8078 blue:0.5333 alpha:1]] forState:UIControlStateDisabled];
}

- (void)stopAnimating {
    self.enabled = true;
    _spinner.hidden = true;
    [_spinner stopAnimating];
    [self setTitle:NSLocalizedString(@"LOGIN_BUTTON_TITLE", @"Login") forState:UIControlStateNormal];
    [self setBackgroundImage:[ITAppServices imageFromColor:[UIColor colorWithRed:0.2862 green:0.72549 blue:0.33725 alpha:1]] forState:UIControlStateNormal];
}

- (void)dealloc {
    [_spinner removeFromSuperview];
    _spinner = nil;
}

@end
