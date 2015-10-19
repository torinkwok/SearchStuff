//
//  __SSMacro.h
//  Playground
//
//  Created by Tong G. on 10/19/15.
//  Copyright © 2015 Tong Kuo. All rights reserved.
//

#define __Throw_exception_because_of_invocation_of_pure_virtual_method \
    @throw [ NSException exceptionWithName: NSGenericException \
                         reason: [ NSString stringWithFormat: @"Unimplemented pure virtual method `%@` in `%@` " \
                                                               "from instance: %p" \
                                                            , NSStringFromSelector( _cmd ) \
                                                            , NSStringFromClass( [ self class ] ) \
                                                            , self ] \
                       userInfo: nil ]