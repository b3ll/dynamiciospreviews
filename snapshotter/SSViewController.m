//
//  SSViewController.m
//  snapshotter
//
//  Created by Adam Bell on 1/12/2014.
//  Copyright (c) 2014 Adam Bell. All rights reserved.
//

#import "SSViewController.h"
#import "SSInstagramView.h"
#import <QuartzCore/QuartzCore.h>

@interface UIApplication (hax)
- (void)_saveSnapshotWithName:(NSString *)name;
- (void)_replyToBackgroundFetchRequestWithResult:(unsigned int)arg1 remoteNotificationToken:(id)arg2 sequenceNumber:(id)arg3 updateApplicationSnapshot:(BOOL)arg4;
@end

@interface SSViewController ()

@end

@implementation SSViewController {
    NSTimer *_timer;
    
    SSInstagramView *_instagramView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _instagramView = [[SSInstagramView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_instagramView setShowsSlideshow:NO animated:NO];
    [self.view addSubview:_instagramView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Instagram Stuff

- (void)setInstagramUIHidden:(BOOL)hidden animated:(BOOL)animated {
    if (hidden) {
        _timer = [NSTimer timerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(updatePreview:)
                                       userInfo:nil
                                        repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
        [self updatePreview:nil];
    }
    else {
        if (_timer != nil) {
            [_timer invalidate];
            _timer = nil;
        }
    }
    
    [_instagramView setShowsSlideshow:hidden animated:animated];
}

- (void)updatePreview:(NSTimer *)timer {
    [_instagramView cyclePhoto];
    
    [[UIApplication sharedApplication] _replyToBackgroundFetchRequestWithResult:0
                                                        remoteNotificationToken:nil
                                                                 sequenceNumber:nil
                                                      updateApplicationSnapshot:YES];
    // [[UIApplication sharedApplication] _saveSnapshotWithName:@"UIApplicationAutomaticSnapshotDefault"];
}

@end
