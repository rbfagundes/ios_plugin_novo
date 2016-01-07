//
//  Crypto.h
//  SitradMobileIOS
//
//  Created by eldorado on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

NSInteger c1=33598;
NSInteger c2=24219;
NSInteger chave=5078;


@interface Crypto : CDVPlugin {

   NSString* callbackID;
}

@property (nonatomic, copy) NSString* callbackID;

- (void) crypt: (NSMutableArray*) arguments withDict:(NSMutableDictionary*) options;

- (void) decrypt: (NSMutableArray*) arguments withDict:(NSMutableDictionary*) options;

- (void) decryptBase64: (NSMutableArray*) arguments withDict:(NSMutableDictionary*) options;

- (void) decodeBase64: (NSMutableArray*) arguments withDict:(NSMutableDictionary*) options;

- (void) encodeBase64: (NSMutableArray*) arguments withDict:(NSMutableDictionary*) options;

@end


