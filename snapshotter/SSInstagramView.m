//
//  SSInstagramView.m
//  snapshotter
//
//  Created by Adam Bell on 1/13/2014.
//  Copyright (c) 2014 Adam Bell. All rights reserved.
//

#import "SSInstagramView.h"

@implementation SSInstagramView {
    UIImageView *_instagramUI;
    UIImageView *_instagramPhotoView;
    UIImageView *_instagramLogo;
    
    UIToolbar *_blurView;
    
    NSUInteger _currentPhotoIndex;
    BOOL _showsSlideshow;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        _instagramUI = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"InstagramUI@2x.png"]];
        _instagramUI.contentMode = UIViewContentModeScaleAspectFit;
        _instagramUI.backgroundColor = [UIColor blackColor];
        [self addSubview:_instagramUI];
        
        _instagramPhotoView = [[UIImageView alloc] initWithFrame:self.bounds];
        _instagramPhotoView.contentMode = UIViewContentModeScaleAspectFill;
        _instagramPhotoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"InstagramPhoto%lu.jpg", (unsigned long)_currentPhotoIndex]];
        _instagramPhotoView.alpha = 0.0;
        [self addSubview:_instagramPhotoView];
        
        _blurView = [[UIToolbar alloc] initWithFrame:_instagramPhotoView.frame];
        _blurView.barStyle = UIBarStyleBlack;
        _blurView.alpha = 0.8;
        _blurView.alpha = 0.0;
        [self addSubview:_blurView];
        
        _instagramLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"InstagramLogo.png"]];
        _instagramLogo.backgroundColor = [UIColor clearColor];
        _instagramLogo.alpha = 0.0;
        [self addSubview:_instagramLogo];
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _instagramUI.center = self.center;
    _instagramUI.frame = self.bounds;
    
    CGRect bounds = CGRectInset(self.bounds, -80, -80);
    
    _instagramPhotoView.bounds = bounds;
    _blurView.bounds = bounds;
    
    _instagramPhotoView.center = self.center;
    _blurView.center = self.center;
    
    _instagramLogo.center = self.center;
}

#pragma mark -
#pragma mark Slideshow Handling

- (void)setShowsSlideshow:(BOOL)showsSlideshow animated:(BOOL)animated {
    if (showsSlideshow == _showsSlideshow)
        return;
    
    _showsSlideshow = showsSlideshow;
    
    CGFloat alpha = (showsSlideshow ? 1.0 : 0.0);
    
    if (animated) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             _instagramPhotoView.alpha = alpha;
                             _blurView.alpha = (alpha - 0.4 < 0.0 ? 0.0 : alpha - 0.4);
                             _instagramLogo.alpha = alpha;
                         }];
    }
    else {
        _instagramPhotoView.alpha = alpha;
        _blurView.alpha = (alpha - 0.4 < 0.0 ? 0.0 : alpha - 0.4);
        _instagramLogo.alpha = alpha;
    }
}

- (void)cyclePhoto {
    _currentPhotoIndex = (_currentPhotoIndex + 1) % 3;
    _instagramPhotoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"InstagramPhoto%lu.jpg", (unsigned long)_currentPhotoIndex]];
}

@end
