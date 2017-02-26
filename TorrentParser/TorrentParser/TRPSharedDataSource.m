//
//  TRPSharedDataSource.m
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-25.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import "TRPSharedDataSource.h"
#import "TRPTorrent.h"

@interface TRPSharedDataSource ()
@end

@implementation TRPSharedDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        self.torrents = [NSMutableArray array];
        
        NSURL *fileURL = [NSURL fileURLWithPath:@"/Users/haohuali/Downloads/edubuntu-12.04.5-dvd-amd64.iso.torrent"];
        TRPTorrent *torrent = [[TRPTorrent alloc] initWithFileURL:fileURL];
        [self.torrents addObject:torrent];
        
        NSURL *fileURL2 = [NSURL fileURLWithPath:@"/Users/haohuali/Downloads/debian-8.7.1-arm64-CD-1.iso.torrent"];
        TRPTorrent *torrent2 = [[TRPTorrent alloc] initWithFileURL:fileURL2];
        [self.torrents addObject:torrent2];
    }
    return self;
}

@end
