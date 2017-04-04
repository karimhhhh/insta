//
//  ITAppServices.h
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ITAppServicesAuthenthicatCompletionBlock)(BOOL success, NSError * error);

@interface ITAppServices : NSObject

+ (BOOL)isLogedIn;
+ (UIImage *)imageFromColor:(UIColor *)color;

+ (void)authenthicateWithUsername:(NSString *)username password:(NSString *)password complection:(ITAppServicesAuthenthicatCompletionBlock)complection;

+ (BOOL)validateAccessTokenFromURL:(NSURL *)URL;

@end
