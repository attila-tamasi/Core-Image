//
//  STANetworkSessionUploadTask.m
//  Core Image
//
//  Created by Attila Tamasi on 02/03/14.
//  Copyright (c) 2014 Attila Tamasi. All rights reserved.
//

#import "STANetworkSessionUploadTask.h"
#import "STANetworkRequest.h"

@interface STANetworkSessionUploadTask () <NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, strong) STANetworkRequest *requestObject;
@property (nonatomic, copy) STANetworkCallback completionBlock;
@property (nonatomic, copy) STANetworkDownloaderProgressBlock progressBlock;
@property (nonatomic, strong) NSURLSessionUploadTask *uploadTask;

@end

@implementation STANetworkSessionUploadTask {
    NSURLSession *session;
}

- (id)initWithRequest:(STANetworkRequest *)requestObject completionBlock:(STANetworkCallback)completionBlock progressBlock:(STANetworkDownloaderProgressBlock)aProgressBlock
{
    self = [super init];

    if (self)
    {
        self.completionBlock = completionBlock;
        self.progressBlock = aProgressBlock;
        self.requestObject = requestObject;
    }

    return self;
}

- (void)execute
{
    NSString *name = [[[[NSUUID UUID] UUIDString] substringToIndex:12] lowercaseString];

    NSURL *fullPath = [self saveDataToFileTemporary:self.requestObject.bodyObject name:name];

    uint64_t bytesTotalForThisFile = [self.requestObject.bodyObject length];

    NSURL *url = [NSURL URLWithString:self.requestObject.path];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%llu", bytesTotalForThisFile] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:self.requestObject.bodyObject];

    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    session = [NSURLSession sessionWithConfiguration:conf delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    self.uploadTask = [session uploadTaskWithRequest:request fromFile:fullPath];
    self.uploadTask.taskDescription = name;
    [self.uploadTask resume];
}

- (NSURL *)saveDataToFileTemporary:(NSData *)data name:(NSString *)uniqueFileName
{
    NSURL *fullPath = [NSURL fileURLWithPath:[[self tempPath] stringByAppendingPathComponent:uniqueFileName]];

    [data writeToFile:fullPath.path atomically:NO];

    return fullPath;
}

- (NSString *)tempPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

- (void)removeDataFileName:(NSString *)name
{
    NSURL *fullPath = [NSURL fileURLWithPath:[[self tempPath] stringByAppendingPathComponent:name]];

    [[NSFileManager defaultManager] removeItemAtURL:fullPath error:NULL];
}

#pragma mark - STACancelable delegate method

- (void)cancel
{
    [self.uploadTask cancel];
}

#pragma mark - NSURLSessionDelegate, NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    [self removeDataFileName:task.taskDescription];

    dispatchOnMainQueue (^{
        if (self.completionBlock)
        {
            self.completionBlock(nil, error, (long)[(id)task.response statusCode]);
        }
    });
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    float progress = (double)totalBytesSent / (double)totalBytesExpectedToSend;

    if (self.progressBlock)
    {
        dispatchOnMainQueue (^{
            self.progressBlock(progress);
        });
    }
}

@end
