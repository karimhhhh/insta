//
//  ITLoginWebViewController.m
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import "ITLoginWebViewController.h"
#import <WebKit/WebKit.h>

@interface ITLoginWebViewController () <UINavigationBarDelegate, WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UINavigationBar *navigationBar;
@property (strong, nonatomic) UINavigationItem *navigationItem;
@property (strong, nonatomic) UIBarButtonItem *doneButton;

@property (strong, nonatomic) NSURL *url;

@end

@implementation ITLoginWebViewController

- (instancetype)initWithURL:(NSURL *)URL {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _url = URL;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, 0, 0) configuration:config];
    _webView.navigationDelegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
    
    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _navigationBar.delegate = self;
    
    _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonAction)];
    
    _navigationItem = [[UINavigationItem alloc] initWithTitle:@""];
    _navigationItem.rightBarButtonItem = _doneButton;
    
    _navigationBar.items = @[_navigationItem];
    
    [self.view addSubview:_webView];
    [self.view addSubview:_navigationBar];
}

#pragma mark - UIBarPositioningDelegate

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

- (void)doneButtonAction {
    _doneBlock();
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%@",_webView.URL);
    if ([_webView.URL.host isEqualToString:@"localhost"]) {
        _completionBlock(_webView.URL);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    if ([_webView.URL.host isEqualToString:@"localhost"]) {
        _completionBlock(_webView.URL);
    }
    NSLog(@"%@",_webView.URL);
 }

@end
