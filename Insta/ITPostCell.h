//
//  ITPostCell.h
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITVideoView.h"
#import <InstagramKit.h>

@interface ITPostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet ITVideoView *playerView;

@property (strong, nonatomic) InstagramMedia *media;

@end
