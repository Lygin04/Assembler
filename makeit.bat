@echo off
c:\masm32\bin\ml /c /coff /Cp /nologo /I"C:\Masm32\Include" %1.asm
if errorlevel 1 goto errasm

c:\masm32\bin\Link /SUBSYSTEM:CONSOLE /RELEASE /LIBPATH:"C:\Masm32\Lib" /OUT:"%1.exe" %1.obj
if errorlevel 1 goto errlink
goto TheEnd
:errlink
echo _
echo Link error
goto TheEnd
:errasm
echo _
echo Assembly Error
goto TheEnd
:TheEnd
pause