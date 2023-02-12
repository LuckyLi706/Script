@echo off
:: 支持中文输出
@chcp 65001
echo         ############# Android Studio模拟器开启代理 #############
echo       ############ 需要先在Android Studio中创建模拟器 ##############   
echo     ########### 需要将AndroidSDK/emulator目录加入环境变量 #############

:: 在for循环中使用局部变量,需要加这句话,变量使用!variable!形式输出
setlocal EnableDelayedExpansion

:: >nul 2>nul 表示不输出命令结果
emulator>nul 2>nul -list-avds
:: ERRORLEVEL表示获取上一个命令的运行状态,9009是当前命令找不到
if ERRORLEVEL 9009 (
   echo 请先配置emulator命令的环境变量
   pause
)

set nums=0
echo 获取到的模拟器列表：
for /f  %%i in ('emulator -list-avds') do (
	set emulator_name[!nums!]=%%i
	echo !nums!  %%i
	set /a nums+=1
)
set /a length=nums-1
set /p input= 请输入(0~%length%的数字选择模拟器)：
emulator -avd !emulator_name[%input%]! -writable-system -http-proxy http://127.0.0.1:8888 
