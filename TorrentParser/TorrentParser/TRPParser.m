//
//  TRPTorrentParser.m
//  TorrentParser
//
//  Created by Haohua Li on 2017-02-24.
//  Copyright © 2017 Haohua Li. All rights reserved.
//

#import "TRPParser.h"
#import "TRPTorrent.h"
#import "TRPElement.h"

@implementation TRPParser

+ (TRPElement *)decodeWithData:(NSString *)data {
    return [self decodeWithData:data atIndex:0];
}

+ (TRPElement *)decodeWithData:(NSString *)data atIndex:(NSUInteger)index {
    NSString *s = [data substringWithRange:NSMakeRange(index, 1)];
    if ([s isEqualToString:@"l"]) {
        return [self decodeListWithData:data atIndex:index];
    } else if ([s isEqualToString:@"d"]) {
        return [self decodeDictionaryWithData:data atIndex:index];
    } else if ([s isEqualToString:@"i"]) {
        return [self decodeIntegerWithData:data atIndex:index];
    } else if ([s isEqualToString:@"0"] || [s isEqualToString:@"1"] || [s isEqualToString:@"2"] || [s isEqualToString:@"3"] || [s isEqualToString:@"4"] || [s isEqualToString:@"5"] || [s isEqualToString:@"6"] || [s isEqualToString:@"7"] || [s isEqualToString:@"8"] || [s isEqualToString:@"9"]) {
        return [self decodeStringWithData:data atIndex:index];
    }
    
    return nil;
}

+ (TRPElement *)decodeListWithData:(NSString *)data atIndex:(NSUInteger)index {
    index++;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    while (![[data substringWithRange:NSMakeRange(index, 1)] isEqualToString:@"e"]) {
        TRPElement *element = [self decodeWithData:data atIndex:index];
        [array addObject:element.value];
    }
    
    return [[TRPElement alloc] initWithValue:array toIndex:index + 1];
}

+ (TRPElement *)decodeDictionaryWithData:(NSString *)data atIndex:(NSUInteger)index {
    index++;
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    while (![[data substringWithRange:NSMakeRange(index, 1)] isEqualToString:@"e"]) {
        TRPElement *keyElement = [self decodeStringWithData:data atIndex:index];
        NSString *key = (NSString *)keyElement.value;
        
        TRPElement *valueElement = [self decodeWithData:data atIndex:keyElement.index];
        dictionary[key] = valueElement.value;
        
        index = valueElement.index;
    }
    
    return [[TRPElement alloc] initWithValue:dictionary toIndex:index + 1];
}

+ (TRPElement *)decodeIntegerWithData:(NSString *)data atIndex:(NSUInteger)index {
    index++;
    
    NSUInteger endIndex = [data rangeOfString:@"e" options:0 range:NSMakeRange(index, data.length - index)].location;
    NSInteger value = [[data substringWithRange:NSMakeRange(index, endIndex - index)] integerValue];
    
    if ([[data substringWithRange:NSMakeRange(index, 1)] isEqualToString:@"-"] && [[data substringWithRange:NSMakeRange(index + 1, 1)] isEqualToString:@"0"]) {
        @throw [NSException exceptionWithName:@"ValueError"
                                       reason:@"i-0e is invalid.."
                                     userInfo:nil];
    } else if ([[data substringWithRange:NSMakeRange(index, 1)] isEqualToString:@"0"] && endIndex != index + 1) {
        @throw [NSException exceptionWithName:@"ValueError"
                                       reason:@"All encodings with a leading zero are invalid, other than i0e."
                                     userInfo:nil];
    }

    return [[TRPElement alloc] initWithValue:@(value) toIndex:endIndex + 1];
}

+ (TRPElement *)decodeStringWithData:(NSString *)data atIndex:(NSUInteger)index {
    NSUInteger colonIndex = [data rangeOfString:@":" options:0 range:NSMakeRange(index, data.length - index)].location;
    NSInteger length = [[data substringWithRange:NSMakeRange(index, colonIndex - index)] integerValue];
    
    if ([[data substringWithRange:NSMakeRange(index, 1)] isEqualToString:@"0"] && colonIndex != index + 1) {
        @throw [NSException exceptionWithName:@"ValueError"
                                       reason:@"String length with a leading zero is invalid."
                                     userInfo:nil];
    }
    
    NSUInteger valueIndex = colonIndex + 1;
    NSString *value = [data substringWithRange:NSMakeRange(valueIndex, length)];
    
    return [[TRPElement alloc] initWithValue:value toIndex:valueIndex + length];
}


@end
