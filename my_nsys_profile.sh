mkdir -p logs
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_0  ./bin/reduce_v0
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_0a_wo_div  ./bin/reduce_v0a_wo_div
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_1  ./bin/reduce_v1
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_2  ./bin/reduce_v2
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_3  ./bin/reduce_v3
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_4  ./bin/reduce_v4
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_5  ./bin/reduce_v5
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_6  ./bin/reduce_v6
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_7  ./bin/reduce_v7
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_8  ./bin/reduce_v8
nsys profile --gpu-metrics-device=all --trace=cuda,cudnn,cublas,osrt,nvtx --stats=true -o ./logs/report_9   python reduce_v9_torch.py


