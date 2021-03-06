;*****************************************************************************
;*
;*                            Open Watcom Project
;*
;*    Portions Copyright (c) 1983-2002 Sybase, Inc. All Rights Reserved.
;*
;*  ========================================================================
;*
;*    This file contains Original Code and/or Modifications of Original
;*    Code as defined in and that are subject to the Sybase Open Watcom
;*    Public License version 1.0 (the 'License'). You may not use this file
;*    except in compliance with the License. BY USING THIS FILE YOU AGREE TO
;*    ALL TERMS AND CONDITIONS OF THE LICENSE. A copy of the License is
;*    provided with the Original Code and Modifications, and is also
;*    available at www.sybase.com/developer/opensource.
;*
;*    The Original Code and all software distributed under the License are
;*    distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;*    EXPRESS OR IMPLIED, AND SYBASE AND ALL CONTRIBUTORS HEREBY DISCLAIM
;*    ALL SUCH WARRANTIES, INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF
;*    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR
;*    NON-INFRINGEMENT. Please see the License for the specific language
;*    governing rights and limitations under the License.
;*
;*  ========================================================================
;*
;* Description:  Stack checking for NetWare with LibC.
;*
;*****************************************************************************


include mdef.inc
include struct.inc
include exitwmsg.inc

        modstart        stk_libc

datasegment

msg     db      "OpenWatcom RTL : Stack Overflow", 0

enddata

    ;
    ;   From OpenWatcom Library
    ;

    ;
    ;   From LIBC.NLM
    ;
        extrn   "C",    stackavail                      :near
        extrn   "C",    NXThreadGetId                   :near

        xdefp   __STK

        defp    __STK
    ;
    ;   Argument passed in eax. Value is size of stack required.
    ;
        push    ebx
        push    esi
        mov     esi, eax
        call    stackavail
        cmp     eax, esi
        jl      $overflow_cond
    $Leave:
        pop     esi
        pop     ebx
        xor     eax, eax
        ret

    $overflow_cond:
        call    NXThreadGetId
        push    eax
        push    offset msg
        jmp     __fatal_runtime_error   ; display msg and exit
        ; never return        
        endproc __STK

        endmod
        end
