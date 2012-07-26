//
//  main.m
//  plistToJSON
//
//  Created by Craig Spitzkoff on 1/11/12.
//  Copyright (c) 2012 Raizlabs Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Converter.h"

int main (int argc, const char * argv[])
{

    @autoreleasepool {
        
        if(argc < 2)
        {
            printf("Not enough arguments\n");
            return 1;
        }
        
        
        // convert the arguments to something we can use more easily.
        // Drop the first argument since it is the name of the executable.
        NSMutableArray* arguments = [NSMutableArray arrayWithCapacity:argc];
        for (int idx = 1; idx < argc; idx++) {
            NSString* arg = [NSString stringWithCString:argv[idx] encoding:NSUTF8StringEncoding];
            [arguments addObject:arg];
        }
        
        BOOL reverse = NO;
        NSUInteger reverseIndex = [arguments indexOfObject:@"-r"];
        if(NSNotFound != reverseIndex)
        {
            reverse = YES;
            [arguments removeObjectAtIndex:reverseIndex];
        }

        NSString* sourceFile = nil;
        if (arguments.count > 0) {
            sourceFile = [arguments objectAtIndex:0];
        }
        
        NSString* targetFile = nil;
        if (arguments.count > 1) {
            targetFile = [arguments objectAtIndex:1];
        }
        
        NSFileManager *filemgr;
        NSString *currentpath;
        
        filemgr = [[NSFileManager alloc] init];
        
        currentpath = [filemgr currentDirectoryPath];
        
        // try to find the full path to the spcified file.
        NSString* sourcePath = [sourceFile copy];
        if(![filemgr fileExistsAtPath:sourceFile])
        {
            // path was not absolute or did not exist. Try looking in the current path. 
            sourcePath = [currentpath stringByAppendingPathComponent:sourcePath];
            
            if(![filemgr fileExistsAtPath:sourcePath])
            {
                printf("Could not find file %s\n", [targetFile cStringUsingEncoding:NSUTF8StringEncoding]);
                return 1;
            }
            

        }
        
        // if there is a target file, determine its full path, otherwise just
        // tack on the correct extension.
        NSString* targetPath = [targetFile copy];
        if(targetFile.length > 0)
        {            
            if (![[targetPath substringToIndex:1] isEqualToString:@"/"] ) {
                targetPath = [currentpath stringByAppendingPathComponent:targetPath];
            }
            
            // if the path ends in a / we need to add a filename
            if([[targetPath substringFromIndex:(targetPath.length - 1)] isEqualToString:@"/"])
            {
                targetPath = [targetPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
                targetPath = [targetPath stringByAppendingPathExtension:reverse ? @"plist" : @"json"];
            }
        }
        else
        {
            targetPath = [sourcePath stringByAppendingPathExtension:reverse ? @"plist" : @"json"];
        }
        
        

        Converter* converter = [[Converter alloc] init];
    
        if(reverse)
        {
            [converter convertJSON:sourcePath toPList:targetPath];
 
        }
        else
        {
            [converter convertPList:sourcePath toJSON:targetPath];
        }
        
    }
    return 0;
}

