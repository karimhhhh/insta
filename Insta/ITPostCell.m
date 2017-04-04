//
//  ITPostCell.m
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import "ITPostCell.h"

@implementation ITPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.clipsToBounds = true;
}

- (void)setMedia:(InstagramMedia *)media {
    _media = media;
    
    if (media.isVideo) {
        _playerView.hidden = false;
        [_playerView play:media.lowResolutionVideoURL];
    }else{
        _postImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[media thumbnailURL]]];
    }
}

@end
