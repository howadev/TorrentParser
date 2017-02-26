//
//  TRPWindowController.m
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-25.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import "TRPWindowController.h"
#import "TRPSharedDataSource.h"

@interface TRPWindowController ()
@property (nonatomic, retain) TRPSharedDataSource *sharedDataStore;
@end

@implementation TRPWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.sharedDataStore = [[TRPSharedDataSource alloc] init];
    [self.contentViewController setRepresentedObject:self.sharedDataStore];
}

@end
