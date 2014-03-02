//
//  STACoreImageFilter.h
//  Core Image
//
//  Created by Attila Tamasi on 01/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

@import Foundation;

@interface STACoreImageFilter : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) CIFilter *filter;

@property (nonatomic, assign, getter = isActive) BOOL active;

- (void)toggleActive;

@end
