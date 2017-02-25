//
//  TRPElement.m
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-25.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import "TRPElement.h"

@implementation TRPElement

- (instancetype)initWithValue:(NSObject *)value toIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.value = value;
        self.index = index;
    }
    return self;
}

@end
