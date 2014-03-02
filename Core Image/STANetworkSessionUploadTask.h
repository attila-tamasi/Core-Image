//
//  STANetworkSessionUploadTask.h
//  Core Image
//
//  Created by Attila Tamasi on 02/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

@import Foundation;

#import "STANetworkRequest.h"

typedef void (^STANetworkCallback)(id response, NSError *error, NSUInteger stutsCode);

typedef void (^STANetworkDownloaderProgressBlock)(float progress);

@protocol STANetworkSession <NSObject>

/**
 *  Designated initialiser for downloader
 *
 *  @param request         request object
 *  @param completionBlock completion block with three param
 *  @param aProgressBlock  prrogress block with the float value of the current download process
 *
 *  @return returning with a cancelable object
 */
- (id)initWithRequest:(STANetworkRequest *)request completionBlock:(STANetworkCallback)completionBlock progressBlock:(STANetworkDownloaderProgressBlock)aProgressBlock;

- (void)execute;

@end

@interface STANetworkSessionUploadTask : NSObject <STANetworkSession>

@end
