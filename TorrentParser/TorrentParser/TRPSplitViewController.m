//
//  TRPSplitViewController.m
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-25.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import "TRPSplitViewController.h"

@interface TRPSplitViewController ()

@end

@implementation TRPSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.splitView.delegate = self;
}

- (void)viewWillAppear {
    [super viewWillAppear];
    [self.splitView setPosition:self.view.bounds.size.height / 2.0 ofDividerAtIndex:0];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    for (NSViewController *vc in [self childViewControllers]) {
        [vc setRepresentedObject:representedObject];
    }
}

#pragma delegate - NSSplitViewDelegate

- (CGFloat)splitView:(NSSplitView *)splitView constrainSplitPosition:(CGFloat)proposedPosition ofSubviewAt:(NSInteger)dividerIndex {
    return self.view.bounds.size.height / 2.0;
}

@end
