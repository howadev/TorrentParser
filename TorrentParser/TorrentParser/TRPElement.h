//
//  TRPElement.h
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-25.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPElement : NSObject
@property (nonatomic, retain) NSObject *value;
@property (nonatomic, assign) NSUInteger index;

- (instancetype)initWithValue:(NSObject *)value;
- (instancetype)initWithValue:(NSObject *)value toIndex:(NSUInteger)index;
@end
