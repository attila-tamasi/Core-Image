//
//  STAImageManager.m
//  Core Image
//
//  Created by Attila Tamasi on 02/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

#import "STAImageFactory.h"
#import "STACoreImageFilter.h"

@implementation STAImageFactory

- (UIImage *)imageWithImage:(UIImage *)targetImage filters:(NSArray *)filters
{
    UIImage *image;

    CIImage *rawImage = [[CIImage alloc] initWithImage:targetImage];

    if ([filters count] == 0)
    {
        return targetImage;
    }

    for (STACoreImageFilter *aFilter in filters)
    {
        if (aFilter.isActive)
        {
            [aFilter.filter setValue:rawImage forKey:kCIInputImageKey];
            rawImage = [aFilter.filter valueForKey:kCIOutputImageKey];
        }
    }

    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef resultImageRef = [context createCGImage:rawImage fromRect:rawImage.extent];
    image = [UIImage imageWithCGImage:resultImageRef];

    CGImageRelease(resultImageRef);

    return image;
}

@end
