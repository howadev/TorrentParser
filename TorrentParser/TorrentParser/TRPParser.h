//
//  TRPTorrentParser.h
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-24.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TRPElement;

@interface TRPParser : NSObject
+ (TRPElement *)decodeWithData:(NSString *)data atIndex:(NSUInteger)index;
+ (TRPElement *)decodeListWithData:(NSString *)data atIndex:(NSUInteger)index;
+ (TRPElement *)decodeDictionaryWithData:(NSString *)data atIndex:(NSUInteger)index;
+ (TRPElement *)decodeIntegerWithData:(NSString *)data atIndex:(NSUInteger)index;
+ (TRPElement *)decodeStringWithData:(NSString *)data atIndex:(NSUInteger)index;
@end
