/*=============================================================================┐
|  _______           _     _              ______               ___    ___      |  
| (_______)         | |   (_)            / _____) _           / __)  / __)     |██
|  _____ _   _  ____| |  _ _ ____   ____( (____ _| |_ _   _ _| |__ _| |__ ___  |██
| |  ___) | | |/ ___) |_/ ) |  _ \ / _  |\____ (_   _) | | (_   __|_   __)___) |██
| | |   | |_| ( (___|  _ (| | | | ( (_| |_____) )| |_| |_| | | |    | | |___ | |██
| |_|   |____/ \____)_| \_)_|_| |_|\___ (______/  \__)____/  |_|    |_| (___/  |██
|                                 (_____|                                      |██
|                                                                              |██
|      _ ______                        _      ______               ___    ___  |██
|     | / _____)                      | |    / _____) _           / __)  / __) |██
|    / ( (____  _____ _____  ____ ____| |__ ( (____ _| |_ _   _ _| |__ _| |__  |██
|   / / \____ \| ___ (____ |/ ___) ___)  _ \ \____ (_   _) | | (_   __|_   __) |██
|  / /  _____) ) ____/ ___ | |  ( (___| | | |_____) )| |_| |_| | | |    | |    |██
| |_|  (______/|_____)_____|_|   \____)_| |_(______/  \__)____/  |_|    |_|    |██
|                                                                              |██
|                                                                              |██
|                         Copyright (c) 2015 Tong Kuo                          |██
|                                                                              |██
|                             ALL RIGHTS RESERVED.                             |██
|                                                                              |██
└==============================================================================┘██
  ████████████████████████████████████████████████████████████████████████████████
  ██████████████████████████████████████████████████████████████████████████████*/

#define __Throw_Exception_Due_to_Invocation_of_PureVirual_Method \
@throw [ NSException exceptionWithName: NSGenericException \
                     reason: [ NSString stringWithFormat: @"Unimplemented pure virtual method `%@` in `%@` " \
                                                           "from instance: %p" \
                                                        , NSStringFromSelector( _cmd ) \
                                                        , NSStringFromClass( [ self class ] ) \
                                                        , self ] \
                   userInfo: nil ]

// __SSWidgetBackingButton class
#define SS_WIDGETS_FIXED_REGULAR_WIDTH  ( 15.f )
#define SS_WIDGETS_FIXED_SMALL_WIDTH    ( 12.5f )
#define SS_WIDGETS_FIXED_MINI_WIDTH     ( 10.f )

#define SS_WIDGETS_FIXED_GAP            ( 3.f )

#define __CA_TRANSACTION_BEGIN__ [ CATransaction begin ];
#define __CA_TRANSACTION_COMMIT__ [ CATransaction commit ];

/*===============================================================================┐
|                                                                                |
|                           The MIT License (MIT)                                |
|                                                                                |
|                        Copyright (c) 2015 Tong Kuo                             |
|                                                                                |
| Permission is hereby granted, free of charge, to any person obtaining a copy   |
| of this software and associated documentation files (the "Software"), to deal  |
| in the Software without restriction, including without limitation the rights   |
| to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      |
|   copies of the Software, and to permit persons to whom the Software is        |
|         furnished to do so, subject to the following conditions:               |
|                                                                                |
| The above copyright notice and this permission notice shall be included in all |
|              copies or substantial portions of the Software.                   |
|                                                                                |
| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     |
| IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       |
| FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    |
|  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        |
| LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  |
| OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  |
|                                 SOFTWARE.                                      |
|                                                                                |
└===============================================================================*/