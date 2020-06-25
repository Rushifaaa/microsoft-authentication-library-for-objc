//------------------------------------------------------------------------------
//
// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//------------------------------------------------------------------------------

#import "MSALADFSOauth2Provider.h"
#import "MSALResult+Internal.h"
#import "MSIDAuthority.h"
#import "MSALADFSAuthority.h"
#import "MSIDTokenResult.h"
#import "MSIDADFSAuthority.h"
#import "MSALAccount+Internal.h"

@implementation MSALADFSOauth2Provider

#pragma mark - Public

- (MSALResult *)resultWithTokenResult:(MSIDTokenResult *)tokenResult
                           authScheme:(id<MSALAuthenticationSchemeProtocol>)authScheme
                           popManager:(MSIDDevicePopManager *)popManager
                                error:(NSError **)error
{
    NSError *authorityError = nil;
    
    MSALADFSAuthority *adfsAuthority = [[MSALADFSAuthority alloc] initWithURL:tokenResult.authority.url error:&authorityError];
    
    if (!adfsAuthority)
    {
        MSID_LOG_WITH_CTX_PII(MSIDLogLevelWarning, nil, @"Invalid authority, error %@", MSID_PII_LOG_MASKABLE(authorityError));
        
        if (error) *error = authorityError;
        
        return nil;
    }
    
    return [MSALResult resultWithMSIDTokenResult:tokenResult authority:adfsAuthority authScheme:authScheme popManager:popManager error:error];
}

- (BOOL)isSupportedAuthority:(MSIDAuthority *)authority
{
    return [authority isKindOfClass:[MSIDADFSAuthority class]];
}

#pragma mark - Protected

- (void)initOauth2Factory
{
    NSAssert(NO, @"ADFS still unimplemented! Implement me.");
}

@end
