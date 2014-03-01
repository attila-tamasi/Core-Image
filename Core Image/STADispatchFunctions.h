//
//  STADispatchFunctions.h
//  Core Image
//
//  Created by Attila Tamasi on 01/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

@import Foundation;

@interface STADispatchFunctions : NSObject

dispatch_time_t dispatchTimeFromNow(float seconds);

void dispatchOnMainQueue(dispatch_block_t block);

void dispatchOnBackgroundQueue(dispatch_block_t block);

void dispatchOnMainQueueAfterDelayInSeconds(float delay, dispatch_block_t block);

void dispatchAfterDelayInSeconds(float delay, dispatch_queue_t queue, dispatch_block_t block);

@end
