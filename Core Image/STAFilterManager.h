//
//  STAFilterManager.h
//  Core Image
//
//  Created by Attila Tamasi on 01/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

@import Foundation;

@interface STAFilterManager : NSObject

@property (nonatomic, strong) NSArray *availableCoreImageFilters;

+ (instancetype)sharedInstance;

- (void)resetFilters;

@end
