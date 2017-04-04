//
//  ITAppServices.m
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import "ITAppServices.h"
#import <InstagramKit.h>

@implementation ITAppServices

+ (BOOL)isLogedIn {
    
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"Token"];
    if (token) {
        NSString *url = [NSString stringWithFormat:@"http://localhost/#access_token=%@",token];
        return [[InstagramEngine sharedEngine] receivedValidAccessTokenFromURL:[NSURL URLWithString:url] error:nil];
    }
    
    return false;
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 2, 2);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void)authenthicateWithUsername:(NSString *)username password:(NSString *)password complection:(ITAppServicesAuthenthicatCompletionBlock)complection {
    //complection(false, nil);
    //InstagramKitLoginScope scope = InstagramKitLoginScopeBasic | InstagramKitLoginScopePublicContent;
    
    //NSURL *authURL = [[InstagramEngine sharedEngine] authorizationURLForScope:scope];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:authURL]];
    
}

+ (BOOL)validateAccessTokenFromURL:(NSURL *)URL {
    return [[InstagramEngine sharedEngine] receivedValidAccessTokenFromURL:URL error:nil];
}

@end
