# wpp386 Builder Control file
# ===========================

set PROJDIR=<CWD>
set PROJNAME=wpp386

[ INCLUDE <OWROOT>/build/master.ctl ]
[ LOG <LOGFNAME>.<LOGEXT> ]

[ INCLUDE <OWROOT>/build/defrule.ctl ]

[ BLOCK <1> rel ]
    cdsay <PROJDIR>

[ BLOCK <BINTOOL> build ]
#========================
    cdsay <PROJDIR>
    <CPCMD> <OWOBJDIR>/bwpp386.exe     <OWBINDIR>/bwpp386<CMDEXT>
    <CCCMD> <OWOBJDIR>/bwppd386<DYEXT> <OWBINDIR>/bwppd386<DYEXT>

[ BLOCK <BINTOOL> clean ]
#========================
    echo rm -f <OWBINDIR>/bwpp386<CMDEXT>
    rm -f <OWBINDIR>/bwpp386<CMDEXT>
    rm -f <OWBINDIR>/bwppd386<DYEXT>

[ BLOCK <1> rel cprel ]
#======================
    <CCCMD> dos386/wpp386.exe       <OWRELROOT>/binw/
    <CCCMD> dos386/wpp386.sym       <OWRELROOT>/binw/
    <CCCMD> dos386/wpp38601.int     <OWRELROOT>/binw/
    <CCCMD> os2386/wpp386.exe       <OWRELROOT>/binp/
    <CCCMD> os2386/wpp386.sym       <OWRELROOT>/binp/
    <CCCMD> os2386/wppd386.dll      <OWRELROOT>/binp/dll/
    <CCCMD> os2386/wppd386.sym      <OWRELROOT>/binp/dll/
    <CCCMD> os2386/wpp38601.int     <OWRELROOT>/binp/dll/
    <CCCMD> nt386/wpp386.exe        <OWRELROOT>/binnt/
    <CCCMD> nt386/wpp386.sym        <OWRELROOT>/binnt/
    <CCCMD> nt386/wppd386.dll       <OWRELROOT>/binnt/
    <CCCMD> nt386/wppd386.sym       <OWRELROOT>/binnt/
    <CCCMD> nt386/wpp38601.int      <OWRELROOT>/binnt/
    <CCCMD> ntaxp/wpp386.exe        <OWRELROOT>/axpnt/
    <CCCMD> ntaxp/wpp386.sym        <OWRELROOT>/axpnt/
    <CCCMD> ntaxp/wppd386.dll       <OWRELROOT>/axpnt/
    <CCCMD> ntaxp/wppd386.sym       <OWRELROOT>/axpnt/
    <CCCMD> ntaxp/wpp38601.int      <OWRELROOT>/axpnt/
    <CCCMD> qnx386/wpp386.exe       <OWRELROOT>/qnx/binq/wpp386
    <CCCMD> qnx386/wpp386.sym       <OWRELROOT>/qnx/sym/
    <CCCMD> qnx386/wpp38601.int     <OWRELROOT>/qnx/binq/
    <CCCMD> linux386/wpp386.exe     <OWRELROOT>/binl/wpp386
    <CCCMD> linux386/wpp386.sym     <OWRELROOT>/binl/
    <CCCMD> linux386/wpp38601.int   <OWRELROOT>/binl/

    <CCCMD> ntx64/wpp386.exe        <OWRELROOT>/binnt64/
    <CCCMD> ntx64/wppd386.dll       <OWRELROOT>/binnt64/
    <CCCMD> ntx64/wpp38601.int      <OWRELROOT>/binnt64/

[ BLOCK . . ]
#============
cdsay <PROJDIR>
