//
//  TRPFile.h
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-24.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPFile : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *length;
@property (nonatomic, retain) NSString *checksum;
@end
