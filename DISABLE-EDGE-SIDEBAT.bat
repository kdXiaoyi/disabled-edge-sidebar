:: ����by kdXiaoyi
:::: HOME PAGE
::: https://kdxiaoyi.github.io/disabled-edge-sidebar
@echo off
goto getUACAdmin

:getUACAdmin
@REM rem ����path·��
@REM if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
rem ͨ������bcd�ķ����ж��Ƿ���UAC����ԱȨ��
bcdedit >>nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)

:UACPrompt
rem ͨ��VBS�����õ�UAC����ԱȨ��
rem mshta��һ������ִ��JS/VBS�ű��������й���
%1 start "GetUACAdmin:getting" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit 0 /b
exit 0 /b

:UACAdmin
cd /d "%~dp0"
echo ��ǰ����·���ǣ�%CD%
echo �ѻ�ȡ����ԱȨ��
goto main

:main
cls
echo ^> Disable Edge Sidebar
echo =======================================================
echo.
echo     ѡ��һ��������
echo     [1] ����Bing Discoverd
echo     [2] ����2 ��������ʵ�٣�
echo.
echo     [X] �ָ�
echo     [0] �˳�
echo.
echo  kdXiaoyi (C) 2023
echo  [A]ll copyright reserved.
echo =======================================================
echo.
choice /n /c 0x12 /m CHOICE^> 
echo.
echo.
if "%errorlevel%"=="1" exit /b 0
if "%errorlevel%"=="2" goto X
if "%errorlevel%"=="3" goto 1
if "%errorlevel%"=="4" goto 2
goto main

:X
echo �Ƿ�ָ�����ᵼ��ȫ����Policies��ɾ����
choice /n /c YN /m "CHOICE [Y/N]^>" 
if "%errorlevel%"=="1" reg delete HKEY_CURRENT_USER\Software\Policies\Microsoft\Edge /va /f
if "%errorlevel%"=="2" goto menu
goto end

:1
taskkill /f /im edge.exe /im msedge.exe
reg add HKEY_CURRENT_USER\Software\Policies\Microsoft\Edge /v HubsSidebarEnabled /t REG_DWORD /d 0x00000000 /f
taskkill /f /im edge.exe /im msedge.exe
echo.
echo    ����edge://policy/���Ƿ�����²���
echo    ��ʧЧ����鿴����URL�еĽ������
echo    https://kdxiaoyi.github.io/blogs/2023/18-edge-sidebar
start msedge.exe
goto end

:2
start https://kdxiaoyi.github.io/blogs/2023/18-edge-sidebar
exit /b 0

:end
echo.
echo.
echo   ������ִ�У�����������Edge�鿴Ч��
echo.
echo   ������˳�
echo  by kdxiaoyi
pause>nul
exit /b 0