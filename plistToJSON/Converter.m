//
//  Converter.m
//  plistToJSON
//
//  Created by Craig Spitzkoff on 7/25/12.
//  Copyright (c) 2012 Raizlabs Corporation. All rights reserved.
//

#import "Converter.h"

@implementation Converter

-(int) convertPList:(NSString*)plistPath toJSON:(NSString*)jsonPath
{
    int fail = 0;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    if (nil == dictionary) {
        printf("Could not parse plist file %s\n", [plistPath cStringUsingEncoding:NSUTF8StringEncoding]);
        fail = 1;
    }
    else
    {
    
        NSError* error = nil;
        
        NSData* data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        
        if(nil == data)
        {
            NSString* errorMessage = [NSString stringWithFormat:@"There was an error converting to JSON: %@", error];
            printf("%s", [errorMessage cStringUsingEncoding:NSUTF8StringEncoding]);
            fail = 1;
        }
        else
        {
            if (![data writeToFile:jsonPath atomically:YES]) {
                printf("Error writing to file: %s", [jsonPath cStringUsingEncoding:NSUTF8StringEncoding]);
                fail = 1;
            }
        }
    }
    
    return fail;
}

-(int) convertJSON:(NSString*)jsonPath toPList:(NSString*)plistPath
{
    int fail = 0;
    
    NSError* error = nil;
    
    NSData* data = [NSData dataWithContentsOfFile:jsonPath];
    id obj = [NSJSONSerialization JSONObjectWithData:data
                                             options:0
                                               error:&error];
    
    if(nil == obj)
    {
        printf("Could not parse JSON");
        fail = 1;
    }
    else if([obj respondsToSelector:@selector(writeToFile:atomically:)])
    {
        [obj writeToFile:plistPath atomically:YES];
    }
    
    return fail;
    
}

@end
