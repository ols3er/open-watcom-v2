/****************************************************************************
*
*                            Open Watcom Project
*
*    Portions Copyright (c) 1983-2002 Sybase, Inc. All Rights Reserved.
*
*  ========================================================================
*
*    This file contains Original Code and/or Modifications of Original
*    Code as defined in and that are subject to the Sybase Open Watcom
*    Public License version 1.0 (the 'License'). You may not use this file
*    except in compliance with the License. BY USING THIS FILE YOU AGREE TO
*    ALL TERMS AND CONDITIONS OF THE LICENSE. A copy of the License is
*    provided with the Original Code and Modifications, and is also
*    available at www.sybase.com/developer/opensource.
*
*    The Original Code and all software distributed under the License are
*    distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
*    EXPRESS OR IMPLIED, AND SYBASE AND ALL CONTRIBUTORS HEREBY DISCLAIM
*    ALL SUCH WARRANTIES, INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF
*    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR
*    NON-INFRINGEMENT. Please see the License for the specific language
*    governing rights and limitations under the License.
*
*  ========================================================================
*
* Description:  String resource dumping routine.
*
****************************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include "wresall.h"
#include "types.h"
#include "dmpstr.h"
#include "rcrtns.h"

bool DumpString( uint_32 offset, uint_32 length, WResFileID handle )
/******************************************************************/
{
    long                prevpos;
    unsigned            len;
    unsigned            numread;
    unsigned            cursor;
    unsigned            stringlen;
    char                *stringbuff;

    prevpos = RCSEEK( handle, offset, SEEK_SET );
    if( prevpos == -1 )
        return( true );
    len = DMP_STR_BUF_LEN;
    stringbuff = (char *)RCALLOC( len );
    if( stringbuff == NULL )
        return( true );

    printf( "\t\t   Strings:\n" );
    printf( "\t\t   --------" );

    numread = 0;
    stringlen = 0;
    cursor = 0;
    do {
        if( numread == 0 ) {
            if( length > len ) {
                length -= len;
            } else {
                len = length;
                length = 0;
            }
            numread = RCREAD( handle, stringbuff, len );
            cursor = 0;
        }
        if( stringlen == 0 ) {
            stringlen = (unsigned char)stringbuff[cursor++];
            if( stringlen != 0 ) {
                printf( "\n\t\t   " );
            }
            ++stringlen;    // trailing '\0'
        }
        if( cursor < numread ) {
            for( ; stringlen > 0; --stringlen ) {
                if( cursor >= numread )
                    break;
                if( stringbuff[cursor] != '\0' && stringbuff[cursor] != '\n' ) {
                    putchar( stringbuff[cursor] );
                }
                cursor++;
            }
        } else {
            numread = 0;
        }
    } while( length != 0 || numread > 0 );
    putchar( '\n' );

    RCFREE( stringbuff );

    RCSEEK( handle, prevpos, SEEK_SET );

    return( false );
}
