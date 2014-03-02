//
//  STANetworkRequest.h
//  Core Image
//
//  Created by Attila Tamasi on 02/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

@import Foundation;

/**
 *  Basic network request object, represent network parameters
 */
@interface STANetworkRequest : NSObject

/**
 *  Request path, url to API
 */
@property (nonatomic, copy) NSString *path;

/**
 *  HTTP Request type, shuld be REST types
 */
@property (nonatomic, copy) NSString *type;

/**
 *  Body object as NSData
 */
@property (nonatomic, strong) NSData *bodyObject;

@end
