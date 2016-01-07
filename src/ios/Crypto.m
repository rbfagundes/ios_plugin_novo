//
//  Crypto.m
//  SitradMobileIOS
//
//  Created by eldorado on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Crypto.h"
#import "Base64.h"

@implementation Crypto

@synthesize callbackID;





-(void) crypt:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    self.callbackID = [arguments pop];
    
    NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];
    
    //NSLog(@"from javascript:[%@]",stringObtainedFromJavascript);
    
    // get ISO-8859-1 data from inpit string 
    NSData* dataIsoLatin = [stringObtainedFromJavascript dataUsingEncoding:NSISOLatin1StringEncoding];
    
    // do the crypto
    NSData* dataCrypted = [self criptografar:(char*)[dataIsoLatin bytes] length:[dataIsoLatin length]];
    
    // convert to base 64
    [Base64 initialize];
    
    NSString *stringBase64 = [Base64 encode: dataCrypted];
    
    [dataCrypted release];
    
    //NSLog(@"encoded:[%@]",stringBase64);
    
    NSMutableString *stringToReturn = [NSMutableString stringWithFormat:@"%@",stringBase64];
    
    
    // Commented because of the New gateway and new communication 
    
    // ×° must be appended at the begining
    //char x[] = {215,176,0};
    //NSString * pre = [[NSString alloc] initWithCString:x encoding:NSISOLatin1StringEncoding];
    //[stringToReturn insertString:pre atIndex:0];
    //[pre release];
    
    //NSLog(@"To Return:[%@]",stringToReturn);
    
    // build the plugin return object
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:[stringToReturn self]];
    
    [self writeJavascript:[pluginResult toSuccessCallbackString: self.callbackID]];
    
}



- (void) decrypt: (NSMutableArray*) arguments withDict:(NSMutableDictionary*) options
{
    self.callbackID = [arguments pop];
    
    NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];
    
    //NSLog(@"from javascript:[%@]",stringObtainedFromJavascript);
    
    // cut µ from the beginning and the ££ at the end
    NSString *encBase64;
    if ([stringObtainedFromJavascript characterAtIndex:0] == 0xFFFD) {
        encBase64 = [stringObtainedFromJavascript substringWithRange:NSMakeRange(1,[stringObtainedFromJavascript length]-3)];
    } else {
        encBase64 = stringObtainedFromJavascript;
    }
    
    //NSLog(@"encoded:[%@]",encBase64);
    
    // decode base64
    // convert to base 64
    [Base64 initialize];
    
    NSData *cryptedData = [Base64 decode: encBase64];
    
    NSData *decryptedData = [self decriptografar:(char*)[cryptedData bytes] length:[cryptedData length]];
    
    NSMutableString *stringToReturn = [[NSMutableString alloc] initWithData:decryptedData encoding: NSISOLatin1StringEncoding];
    
    //NSLog(@"stringToReturn:[%@]",stringToReturn);
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:[stringToReturn self]];
    
    
    [self writeJavascript:[pluginResult toSuccessCallbackString: self.callbackID]];
}

- (void) decryptBase64: (NSMutableArray*) arguments withDict:(NSMutableDictionary*) options
{
    self.callbackID = [arguments pop];
    
    NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];
    
    //NSLog(@"decryptBase64 from javascript:[%@]",stringObtainedFromJavascript);
    
    // cut µ from the beginning and the ££ at the end
    NSString *encBase64;
    if ([stringObtainedFromJavascript characterAtIndex:0] == 0xFFFD) {
        encBase64 = [stringObtainedFromJavascript substringWithRange:NSMakeRange(1,[stringObtainedFromJavascript length]-3)];
    } else {
        encBase64 = stringObtainedFromJavascript;
    }
    
    //NSLog(@"decryptBase64 encoded:[%@]",encBase64);
    
    // decode base64
    // convert to base 64
    [Base64 initialize];
    NSData *cryptedData = [Base64 decode: encBase64];
    
    NSData *decryptedData = [self decriptografar:(char*)[cryptedData bytes] length:[cryptedData length]];
    
    NSString *stringToReturn = [Base64 encode: decryptedData];
    
    NSMutableString *decryptedString = [[NSMutableString alloc] initWithData:decryptedData encoding: NSISOLatin1StringEncoding];
    CDVPluginResult* pluginResult;
    if ([decryptedString rangeOfString:@"TRANSAC"].location == NSNotFound) {
         pluginResult= [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:[stringToReturn self]];
    }
    else {
        pluginResult= [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:[decryptedString self]];
    }
    [self writeJavascript:[pluginResult toSuccessCallbackString: self.callbackID]];
}


-(void) encodeBase64:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    self.callbackID = [arguments pop];
    
    NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];
    
    //NSLog(@"from javascript:[%@]",stringObtainedFromJavascript);
    
    // get ISO-8859-1 data from inpit string 
    NSData* dataIsoLatin = [stringObtainedFromJavascript dataUsingEncoding:NSISOLatin1StringEncoding];
    
    // convert to base 64
    [Base64 initialize];
    
    NSString *stringBase64 = [Base64 encode: dataIsoLatin];
    
    //NSLog(@"encodeBase64 to return:[%@]",stringBase64);
    
    // build the plugin return object
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:[stringBase64 self]];
    
    [self writeJavascript:[pluginResult toSuccessCallbackString: self.callbackID]];
    
}


- (void) decodeBase64: (NSMutableArray*) arguments withDict:(NSMutableDictionary*) options
{
    self.callbackID = [arguments pop];
    
    NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];
    
    //NSLog(@"from javascript:[%@]",stringObtainedFromJavascript);
    
    // decode base64
    // convert to base 64
    [Base64 initialize];
    
    NSData *decodedData = [Base64 decode: stringObtainedFromJavascript];
    
    NSMutableString *stringToReturn = [[NSMutableString alloc] initWithData:decodedData encoding: NSISOLatin1StringEncoding];
    
    //NSLog(@"decodeBase64 to return:[%@]",stringToReturn);
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:[stringToReturn self]];
    
    
    [self writeJavascript:[pluginResult toSuccessCallbackString: self.callbackID]];
}


- (NSData*) criptografar: (char*) input length:(NSInteger) length
{
    NSInteger i;
    char caracter;
    NSInteger vchave;
    
    vchave = (length + chave);
    
    for (i = 0; i < length; i++ ) {
        caracter = (char) (input[i] ^ (vchave >> 8));
        
        input[i] = caracter;
        
        vchave = 65535 & ((caracter + vchave) * c1 + c2);
    }
    
    NSMutableData *cryptedData = [[NSMutableData alloc] initWithBytes:input length:length];

    return cryptedData; 
}


- (NSData*) decriptografar: (char*) input length:(NSInteger) length
{
    NSInteger i;
    char caracter;
    char caracterOld;
    NSInteger vchave;
    
    vchave = (length + chave);
    for (i = 0; i < length; i++ ) {
        caracterOld = input[i];
        
        caracter = (char) (caracterOld ^ (vchave >> 8));
        
        input[i] = caracter;
        
        vchave = 65535 & ((caracterOld + vchave) * c1 + c2);
    }
    
    NSMutableData *decryptedData = [[NSMutableData alloc] initWithBytes:input length:length];
    
    return decryptedData;
}

@end
