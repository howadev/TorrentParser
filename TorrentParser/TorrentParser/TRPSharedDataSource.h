//
//  TRPSharedDataSource.h
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-25.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TRPTorrent;

@interface TRPSharedDataSource : NSObject
@property (nonatomic, retain) NSMutableArray<TRPTorrent *> *torrents;
@end
