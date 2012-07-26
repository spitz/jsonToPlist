//
//  Converter.h
//  plistToJSON
//
//  Created by Craig Spitzkoff on 7/25/12.
//  Copyright (c) 2012 Raizlabs Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Converter : NSObject

-(int) convertPList:(NSString*)plistPath toJSON:(NSString*)jsonPath;
-(int) convertJSON:(NSString*)jsonPath toPList:(NSString*)plistPath;


@end
