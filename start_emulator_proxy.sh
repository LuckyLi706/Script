#!/usr/bin/env bash

echo "              ########## Android Studio模拟器开启代理脚本 ######### "
echo "           ############ 需要先在Android Studio中创建模拟器 ############"
echo "     ########## 需要将~/Library/Android/sdk/emulator路径加入环境变量 ########"

source ~/.bash_profile
results=$(emulator -list-avds)

if [ $? -ne 0 ]
then
   echo '当前emulator命令未加入环境变量'
   # 使用内置命令exit来杀死当前脚本
   exit 0
fi

echo "获取到的模拟器列表："

# 定义模拟器数组
emulator_name=()
i=0
for itemId in ${results}; do
  emulator_name[i]=${itemId}
  i=$i+1
done

# 获取模拟器个数
emulator_nums=${#emulator_name[@]}

for ((i = 0; i < $emulator_nums; i++)); do
  echo ${i} ${emulator_name[i]}
done

echo "请输入(0~$((emulator_nums - 1))的数字选择模拟器):"
read num


#   启动模拟器指令参数说明：
#   1. -writable-system
#   使用这个参数表示可写的系统映像，使用adb remount命令来让系统系统映像可读写。
#
#
# 判断当前输入
if [ $num -lt $emulator_nums ] && [ $num -ge 0 ]; then
  emulator -avd ${emulator_name[num]} -writable-system -http-proxy http://127.0.0.1:8888 
else
  echo "输入错误，必须根据0~$((emulator_nums - 1))的数字选择模拟器)"
fi
