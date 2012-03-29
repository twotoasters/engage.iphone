/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 Copyright (c) 2012, Janrain, Inc.

 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation and/or
   other materials provided with the distribution.
 * Neither the name of the Janrain, Inc. nor the names of its
   contributors may be used to endorse or promote products derived from this
   software without specific prior written permission.


 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


#import "JRQuotes.h"

@implementation JRQuotes
{
    NSInteger _quotesId;
    NSString *_quote;
}
@dynamic quotesId;
@dynamic quote;

- (NSInteger)quotesId
{
    return _quotesId;
}

- (void)setQuotesId:(NSInteger)newQuotesId
{
    [self.dirtyPropertySet addObject:@"quotesId"];

    _quotesId = newQuotesId;
}

- (NSString *)quote
{
    return _quote;
}

- (void)setQuote:(NSString *)newQuote
{
    [self.dirtyPropertySet addObject:@"quote"];

    if (!newQuote)
        _quote = [NSNull null];
    else
        _quote = [newQuote copy];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/profiles/profile/quotes";
    }
    return self;
}

+ (id)quotes
{
    return [[[JRQuotes alloc] init] autorelease];
}

- (id)copyWithZone:(NSZone*)zone
{
    JRQuotes *quotesCopy =
                [[JRQuotes allocWithZone:zone] init];

    quotesCopy.quotesId = self.quotesId;
    quotesCopy.quote = self.quote;

    return quotesCopy;
}

+ (id)quotesObjectFromDictionary:(NSDictionary*)dictionary
{
    JRQuotes *quotes =
        [JRQuotes quotes];

    quotes.quotesId = [(NSNumber*)[dictionary objectForKey:@"id"] intValue];
    quotes.quote = [dictionary objectForKey:@"quote"];

    return quotes;
}

- (NSDictionary*)dictionaryFromQuotesObject
{
    NSMutableDictionary *dict = 
        [NSMutableDictionary dictionaryWithCapacity:10];

    if (self.quotesId)
        [dict setObject:[NSNumber numberWithInt:self.quotesId] forKey:@"id"];

    if (self.quote && self.quote != [NSNull null])
        [dict setObject:self.quote forKey:@"quote"];
    else
        [dict setObject:[NSNull null] forKey:@"quote"];

    return dict;
}

- (void)updateLocallyFromNewDictionary:(NSDictionary*)dictionary
{
    if ([dictionary objectForKey:@"id"])
        _quotesId = [(NSNumber*)[dictionary objectForKey:@"id"] intValue];

    if ([dictionary objectForKey:@"quote"])
        _quote = [dictionary objectForKey:@"quote"];
}

- (void)replaceLocallyFromNewDictionary:(NSDictionary*)dictionary
{
    _quotesId = [(NSNumber*)[dictionary objectForKey:@"id"] intValue];
    _quote = [dictionary objectForKey:@"quote"];
}

- (void)updateObjectOnCaptureForDelegate:(id<JRCaptureObjectDelegate>)delegate withContext:(NSObject *)context
{
    NSMutableDictionary *dict =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"quotesId"])
        [dict setObject:[NSNumber numberWithInt:self.quotesId] forKey:@"id"];

    if ([self.dirtyPropertySet containsObject:@"quote"])
        [dict setObject:self.quote forKey:@"quote"];

    NSDictionary *newContext = [NSDictionary dictionaryWithObjectsAndKeys:
                                                     self, @"captureObject",
                                                     delegate, @"delegate",
                                                     context, @"callerContext", nil];

    [JRCaptureInterface updateCaptureObject:dict
                                     withId:0
                                     atPath:self.captureObjectPath
                                  withToken:[JRCaptureData accessToken]
                                forDelegate:self
                                withContext:newContext];
}

- (void)replaceObjectOnCaptureForDelegate:(id<JRCaptureObjectDelegate>)delegate withContext:(NSObject *)context
{
    NSMutableDictionary *dict =
         [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:[NSNumber numberWithInt:self.quotesId] forKey:@"id"];
    [dict setObject:self.quote forKey:@"quote"];

    NSDictionary *newContext = [NSDictionary dictionaryWithObjectsAndKeys:
                                                     self, @"captureObject",
                                                     delegate, @"delegate",
                                                     context, @"callerContext", nil];

    [JRCaptureInterface replaceCaptureObject:dict
                                      withId:0
                                      atPath:self.captureObjectPath
                                   withToken:[JRCaptureData accessToken]
                                 forDelegate:self
                                 withContext:newContext];
}

- (void)dealloc
{
    [_quote release];

    [super dealloc];
}
@end
