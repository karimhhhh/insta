//
//  ITLoginViewController.m
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import "ITLoginViewController.h"
#import "ITLoginWebViewController.h"
#import "ITLoginTextField.h"
#import "ITLoginButton.h"
#import "ITAppServices.h"
#import <InstagramKit.h>

@interface ITLoginViewController () <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) UIImageView *backgroundImage;
@property (strong, nonatomic) ITLoginTextField *usernameTextField;
@property (strong, nonatomic) ITLoginTextField *passwordTextField;
@property (strong, nonatomic) ITLoginButton *loginButton;

@property (nonatomic) CGFloat controlsY;

@end

@implementation ITLoginViewController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _controlsY = 175;
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    _tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:_tapGestureRecognizer];
    
    /*_backgroundImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    _backgroundImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _backgroundImage.image = [UIImage imageNamed:@"LoginBackgroundImage"];*/
    
    _usernameTextField = [[ITLoginTextField alloc] initWithFrame:CGRectZero];
    _usernameTextField.delegate = self;
    _usernameTextField.placeholder = NSLocalizedString(@"LOGIN_USERNAME_TEXTFIELD_PLACEHOLDER", @"Username");
    _usernameTextField.returnKeyType = UIReturnKeyNext;
    _usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    
    if ([_usernameTextField respondsToSelector:@selector(setAutocapitalizationType:)]) {
        _usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    
    _usernameTextField.textContentType = UITextContentTypeEmailAddress;
    
    _passwordTextField = [[ITLoginTextField alloc] initWithFrame:CGRectZero];
    _passwordTextField.delegate = self;
    _passwordTextField.placeholder = NSLocalizedString(@"LOGIN_PASSWORD_TEXTFIELD_PLACEHOLDER", @"Password");
    _passwordTextField.returnKeyType = UIReturnKeyGo;
    _passwordTextField.secureTextEntry = true;
    
    _loginButton = [ITLoginButton buttonWithType:UIButtonTypeCustom];
    //_loginButton.enabled = false;
    [_loginButton addTarget:self action:@selector(loginButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_usernameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_passwordTextField];
    // Keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    //[self.view addSubview:_backgroundImage];
    /*[self.view addSubview:_usernameTextField];
    [self.view addSubview:_passwordTextField];*/
    [self.view addSubview:_loginButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupControlsFrame];
}

- (void)setupControlsFrame {
    _usernameTextField.frame = CGRectMake(30, _controlsY, self.view.frame.size.width-60, 45);
    _passwordTextField.frame = CGRectMake(30, _controlsY + 65, self.view.frame.size.width-60, 45);
    _loginButton.frame = CGRectMake(30, _controlsY + 130, self.view.frame.size.width-60, 45);
}


- (void)setControlsEnabled:(BOOL)enabled {
    if (enabled) {
        [_loginButton stopAnimating];
        _usernameTextField.enabled = true;
        _passwordTextField.enabled = true;
    }else{
        [_loginButton startAnimating];
        _usernameTextField.enabled = false;
        _passwordTextField.enabled = false;
    }
}

- (void)loginButtonTapped {
    [self loginAction];
}

- (void)loginAction {
    
    [self setControlsEnabled:false];
    
    InstagramKitLoginScope scope = InstagramKitLoginScopeBasic | InstagramKitLoginScopePublicContent;
    NSURL *authURL = [[InstagramEngine sharedEngine] authorizationURLForScope:scope];

    [ITAppServices authenthicateWithUsername:_usernameTextField.text
                                    password:_passwordTextField.text complection:^(BOOL success, NSError *error)
    {
        if (success) {
            
        }else{
            [self setControlsEnabled:true];
        }
    }];
    
    __block ITLoginWebViewController *controller = [[ITLoginWebViewController alloc] initWithURL:authURL];
    
    controller.completionBlock = ^(NSURL *url){
        
        [controller dismissViewControllerAnimated:true completion:^{
            if ([ITAppServices validateAccessTokenFromURL:url]) {
                [_delegate showPosts];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Authenthication Failed" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:true completion:nil];
            };
            controller = nil;
        }];
    };
    
    controller.doneBlock = ^{
        [controller dismissViewControllerAnimated:true completion:^{
            controller = nil;
        }];
        [self setControlsEnabled:true];
    };
    
    [self presentViewController:controller animated:true completion:nil];
    
}

#pragma mark - Tap Gesture Recognizer

- (void)tapGestureAction {
    [self.view endEditing:true];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view == self.view
        && ![_loginButton pointInside:[touch locationInView:_loginButton] withEvent:nil])
        return true;
    
    return false;
}

#pragma mark - UITextFieldTextDidChangeNotification

- (void)textFieldTextDidChange:(NSNotification *)notification {
    if (_usernameTextField.text.length >0 && _passwordTextField.text.length >0) {
        _loginButton.enabled = true;
    }else{
        _loginButton.enabled = false;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _usernameTextField) {
        [_passwordTextField becomeFirstResponder];
        return false;
    } else if (!_passwordTextField.text.length || !_usernameTextField.text.length ) {
        return false;
    }
    [self loginAction];
    return true;
}

#pragma mark - UIKeyboardNotification

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _controlsY = ([UIScreen mainScreen].bounds.size.height - keyboardEndFrame.size.height)/2-98;
    
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue]
                     animations:^
    {
        [self setupControlsFrame];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    _controlsY = 175;
    [self setupControlsFrame];
}

#pragma mark -


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.view removeGestureRecognizer:_tapGestureRecognizer];
    [_tapGestureRecognizer removeTarget:self action:nil];
    _tapGestureRecognizer.delegate = nil;
    _tapGestureRecognizer = nil;
    
    [_loginButton removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    //_usernameTextField.delegate = nil;
    //_passwordTextField.delegate = nil;
    
    //[_backgroundImage removeFromSuperview];
    //[_usernameTextField removeFromSuperview];
    //[_passwordTextField removeFromSuperview];
    [_loginButton removeFromSuperview];
    
    _backgroundImage = nil;
    _usernameTextField = nil;
    _passwordTextField = nil;
    _loginButton = nil;
}

@end
