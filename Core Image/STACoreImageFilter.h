//
//  STACoreImageFilter.h
//  Core Image
//
//  Created by Attila Tamasi on 01/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

@import Foundation;

/**
 *  Core image filter entity
 */
@interface STACoreImageFilter : NSObject

/**
 *  Name of the filter
 */
@property (nonatomic, copy) NSString *name;

/**
 *  Core image filter instance
 */
@property (nonatomic, strong) CIFilter *filter;

/**
 *  Activated filter
 */
@property (nonatomic, assign, getter = isActive) BOOL active;

/**
 *  Toggle active property of the filter
 */
- (void)toggleActive;

@end
