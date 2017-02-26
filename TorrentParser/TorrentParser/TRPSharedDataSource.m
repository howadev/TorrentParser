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
    }
    return self;
}

@end
