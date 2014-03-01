//
//  STADispatchFunctions.m
//  Core Image
//
//  Created by Attila Tamasi on 01/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

#import "STADispatchFunctions.h"

@implementation STADispatchFunctions

dispatch_time_t dispatchTimeFromNow(float seconds)
{
    return dispatch_time(DISPATCH_TIME_NOW, (seconds * 1000000000));
}

void dispatchOnMainQueue(dispatch_block_t block)
{
    dispatch_async(dispatch_get_main_queue(), block);
}

void dispatchOnBackgroundQueue(dispatch_block_t block)
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
}

void dispatchOnMainQueueAfterDelayInSeconds(float delay, dispatch_block_t block)
{
    dispatchAfterDelayInSeconds(delay, dispatch_get_main_queue(), block);
}

void dispatchAfterDelayInSeconds(float delay, dispatch_queue_t queue, dispatch_block_t block)
{
    dispatch_after(dispatchTimeFromNow(delay), queue, block);
}

@end
