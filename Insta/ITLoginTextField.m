//
//  ITLoginTextField.m
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import "ITLoginTextField.h"

@implementation ITLoginTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = true;
        self.layer.cornerRadius = 6;
        self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
        self.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        self.layer.borderWidth = 1;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    }else{
        self.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    }
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 7, 7);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 7, 7);
}

@end
