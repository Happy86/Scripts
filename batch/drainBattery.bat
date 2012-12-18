@echo off

REM color z.B. 0A oder 0D
color 0A

REM while(true)
:a
for %%I in (*.*) do type %%I
goto a

