//
//  TRPTorrent.h
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-24.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TRPFile;

@interface TRPTorrent : NSObject
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *creator;
@property (nonatomic, retain) NSURL *trackerURL;
@property (nonatomic, retain) NSArray<TRPFile *> *files;
@end
