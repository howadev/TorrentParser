//
//  TRPWindowController.m
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-25.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import "TRPWindowController.h"
#import "TRPSharedDataSource.h"
#import "TRPTorrent.h"

@interface TRPWindowController ()
@property (nonatomic, retain) TRPSharedDataSource *sharedDataStore;
@end

@implementation TRPWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.sharedDataStore = [[TRPSharedDataSource alloc] init];
    [self.contentViewController setRepresentedObject:self.sharedDataStore];
}

#pragma mark - Actions

- (void)openDocument:(id)sender {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:YES];
    
    __weak TRPWindowController *weakSelf = self;
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            __strong TRPWindowController *strongSelf = weakSelf;
            for (NSURL *localURL in [panel URLs]) {
                TRPTorrent *torrent = [[TRPTorrent alloc] initWithFileURL:localURL];
                [[strongSelf.sharedDataStore torrents] addObject:torrent];
                [strongSelf.contentViewController setRepresentedObject:strongSelf.sharedDataStore];
            }
        }
        
    }];
}

- (void)showHelp:(nullable id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://github.com/lihowadev/TorrentParser/issues"]];
}

@end
