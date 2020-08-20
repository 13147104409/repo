@echo off&setlocal enabledelayedexpansion
@title 地址代码对照表
if exist 地址代码对照表.txt (
del 地址代码对照表.txt
)
echo 正在下载数据，请稍等......
curl -G -s  https://13147104409.github.io/codes.txt >> codes.tmp
iconv.exe -f utf-8 -t gbk  codes.tmp > 地址代码对照表.csv
del codes.tmp
echo  [ >>codes.json
for /f "tokens=1,2,3,4 delims=," %%a in (地址代码对照表.csv) do ( 
set /a n+=1
if  "!n!" =="1" (
echo { >>codes.json
echo "province":"%%d"  >>codes.json
echo "city":"%%a",  >>codes.json
echo "city_code":"%%b",  >>codes.json
echo "adcode":"%%c", >>codes.json
echo } >>codes.json	
) else (
echo ,{ >>codes.json
echo "province":"%%d"  >>codes.json
echo "city":"%%a",  >>codes.json
echo "city_code":"%%b",  >>codes.json
echo "adcode":"%%c", >>codes.json
echo } >>codes.json	)
)
echo ] >>codes.json
echo.
echo 写出到:%~dp0地址代码对照表.csv
echo 写出到:%~dp0codes.json
start explorer "%~dp0"
echo.
timeout /t 30
