//
//  ITVideoView.m
//  Insta
//
//  Copyright © 2017 Karim. All rights reserved.
//

#import "ITVideoView.h"

@implementation ITVideoView {
    AVPlayerLayer *playerLayer;
    AVPlayer *player;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        playerLayer = [AVPlayerLayer playerLayerWithPlayer:nil];
        playerLayer.bounds = self.layer.bounds;
        [self.layer addSublayer:playerLayer];
    }
    return self;
}

- (void)play:(NSURL *)url {
    player = [AVPlayer playerWithURL:url];
    playerLayer.player = player;
    [player play];
}

- (void)dealloc {
    [playerLayer removeFromSuperlayer];
    playerLayer.player = nil;
    player = nil;
}

@end
