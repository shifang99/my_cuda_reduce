make
mkdir -p logs
python my_collect_env.py > ./logs/my_collect_evn.log 2>&1
bash my_nsys_profile.sh  > ./logs/my_nsys_profile.log  2>&1
bash my_nvprof.sh  > ./logs/my_nvprof.log  2>&1

