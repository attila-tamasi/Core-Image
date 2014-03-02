//
//  STAFilterManager.h
//  Core Image
//
//  Created by Attila Tamasi on 01/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

@import Foundation;

/**
 *  Core Image Filter manager
 *
 *  Filters: sepia, black and white, lighten, dotted image, blur, invert color, viggnete
 */
@interface STAFilterManager : NSObject

/**
 *  Available core image filters
 */
@property (nonatomic, strong) NSArray *availableCoreImageFilters;

/**
 *  Shared instance
 *
 *  @return filterManager singleton instance
 */
+ (instancetype)sharedInstance;

/**
 *  Reset all the filter objects in the available filters collection
 */
- (void)resetFilters;

@end
