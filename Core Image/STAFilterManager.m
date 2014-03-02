//
//  STAFilterManager.m
//  Core Image
//
//  Created by Attila Tamasi on 01/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

#import "STAFilterManager.h"
#import "STACoreImageFilter.h"

@implementation STAFilterManager

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (id)init
{
    self = [super init];

    if (self)
    {
        self.availableCoreImageFilters = @[[STAFilterManager sepiaFilter], [STAFilterManager blackAndWhiteFilter]];
    }

    return self;
}

+ (STACoreImageFilter *)sepiaFilter
{
    STACoreImageFilter *aFilter = [[STACoreImageFilter alloc] init];

    aFilter.name = @"Sepia";
    aFilter.filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputIntensityKey, @0.8, nil];

    return aFilter;
}

+ (STACoreImageFilter *)blackAndWhiteFilter
{
    STACoreImageFilter *aFilter = [[STACoreImageFilter alloc] init];

    aFilter.name = @"Black and White";
    aFilter.filter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:
                      kCIInputBrightnessKey, @0.0,
                      kCIInputContrastKey, @1.1,
                      kCIInputSaturationKey, @0.0,
                      nil];

    return aFilter;
}

- (void)resetFilters
{
    for (STACoreImageFilter *aFilter in [[STAFilterManager sharedInstance] availableCoreImageFilters])
    {
        aFilter.active = NO;
    }
}

@end
