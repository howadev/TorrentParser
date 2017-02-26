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
                if (torrent) {
                    [[strongSelf.sharedDataStore torrents] addObject:torrent];
                    [strongSelf.contentViewController setRepresentedObject:strongSelf.sharedDataStore];
                } else {
                    [strongSelf showInvalidAlertWithFile:localURL.lastPathComponent];
                }
            }
        }
        
    }];
}

- (void)showHelp:(nullable id)sender {
    [[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:@"https://github.com/lihowadev/TorrentParser/issues"]];
}

- (void)showInvalidAlertWithFile:(NSString *)fileName {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Invalid Torrent File"];
    [alert setInformativeText:[NSString stringWithFormat:@"Unable to load %@", fileName]];
    [alert addButtonWithTitle:@"OK"];
    [alert runModal];
}

@end
