//
//  TRPElement.m
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-25.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import "TRPElement.h"

@implementation TRPElement

- (instancetype)initWithValue:(NSObject *)value {
    return [self initWithValue:value toIndex:0];
}

- (instancetype)initWithValue:(NSObject *)value toIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.value = value;
        self.index = index;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[TRPElement class]]) {
        return NO;
    }
    
    NSObject *objectValue = [(TRPElement *)object value];
    
    if ([self.value isKindOfClass:[NSNumber class]] && [objectValue isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self.value isEqualTo:(NSNumber *)objectValue];
    }
    
    if ([self.value isKindOfClass:[NSString class]] && [objectValue isKindOfClass:[NSString class]]) {
        return [(NSString *)self.value isEqualToString:(NSString *)objectValue];
    }
    
    if ([self.value isKindOfClass:[NSArray class]] && [objectValue isKindOfClass:[NSArray class]]) {
        NSArray *selfArray = (NSArray *)self.value;
        NSArray *objectArray = (NSArray *)objectValue;
        
        if ([selfArray count] != [objectArray count]) {
            return NO;
        }
        
        for (NSUInteger index = 0; index < [objectArray count]; index++) {
            if (![selfArray[index] isEqual:objectArray[index]]) {
                return NO;
            }
        }
        
        return YES;
    }
    
    if ([self.value isKindOfClass:[NSDictionary class]] && [objectValue isKindOfClass:[NSDictionary class]]) {
        NSDictionary *selfDictionary = (NSDictionary *)self.value;
        NSDictionary *objectDictionary = (NSDictionary *)objectValue;
        
        if ([selfDictionary count] != [objectDictionary count]) {
            return NO;
        }
        
        for (NSString *key in objectDictionary) {
            if (![selfDictionary[key] isEqual:objectDictionary[key]]) {
                return NO;
            }
        }
        
        return YES;
    }
    
    return NO;
}

@end
