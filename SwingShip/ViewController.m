//
//  ViewController.m
//  SwingShip
//
//  Created by admin on 8/28/15.
//  Copyright (c) 2015 hoangdangtrung. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController {
    UIImageView *imgShack;
    UIImageView *sea1, *sea2, *sea3;
    AVAudioPlayer* audioPlayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawShackandSea];
    [self animateSea];
    [self playSong];
    
}
- (void) drawShackandSea {
    sea3 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    sea3.image = [UIImage imageNamed:@"sea3"];
    [self.view addSubview:sea3];
    
    sea2 = [[UIImageView alloc] initWithFrame:CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    sea2.image = [UIImage imageNamed:@"sea2"];
    [self.view addSubview:sea2];
    
    sea1 = [[UIImageView alloc] initWithFrame:CGRectMake(-2*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    sea1.image = [UIImage imageNamed:@"sea1"];
    [self.view addSubview:sea1];

    imgShack = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, 400, 200, 120)];
    imgShack.center = CGPointMake(self.view.bounds.size.width/2, 400);
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:9];
    for (int i=0; i<8; i++) {
        NSString *fileName;
        fileName = [NSString stringWithFormat:@"shack%d.png",i];
        imgShack.alpha = 0.7;
        [images addObject:[UIImage imageNamed:fileName]];
    }
    imgShack.animationImages = images;
    imgShack.animationDuration = 1;
    imgShack.animationRepeatCount = 0; //default = 0 Repeat All
    [self.view addSubview:imgShack];
    [imgShack startAnimating];
    
    
}

//-(void) animateShip {
//    [UIView animateWithDuration:1 animations:^{
//        imgShack.transform = CGAffineTransformMakeRotation(-0.08);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:1
//                         animations:^{
//                             imgShack.transform = CGAffineTransformMakeRotation(0.08);
//                         } completion:^(BOOL finished) {
//                             [self animateShip];
//                         }];
//    }];
//}

- (void) animateSea {
    [UIView animateWithDuration:10
                     animations:^{
                         sea3.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         sea2.frame = self.view.bounds;
                         sea1.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                     } completion:^(BOOL finished) {
                         sea3.frame = CGRectMake(-2*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         
                         [UIView animateWithDuration:10 animations:^{
                             sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                             sea1.frame = self.view.bounds;
                             sea3.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         } completion:^(BOOL finished) {
                             sea2.frame = CGRectMake(-2*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                             
                             [UIView animateWithDuration:10 animations:^{
                                 sea1.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                                 sea3.frame = self.view.bounds;
                                 sea2.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                                 
                             } completion:^(BOOL finished) {
                                 sea1.frame = CGRectMake(-2*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                                 sea2.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                                 
                                 [self animateSea];
                             }];
                         }];
                     }];
}

- (void) playSong {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"tiengsongbien" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                         error:&error];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}
- (void) viewWillDisappear:(BOOL)animated {
    [audioPlayer stop];
}
@end