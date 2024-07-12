all:
	mkdir -p bin
	nvcc -o bin/reduce_v0 reduce_v0_baseline.cu
	nvcc -o bin/reduce_v0a_wo_div reduce_v0a_baseline_wo_div.cu
	nvcc -o bin/reduce_v1 reduce_v1_no_divergence_branch.cu
	nvcc -o bin/reduce_v2 reduce_v2_no_bank_conflict.cu
	nvcc -o bin/reduce_v3 reduce_v3_add_during_load.cu
	nvcc -o bin/reduce_v4 reduce_v4_unroll_last_warp.cu
	nvcc -o bin/reduce_v5 reduce_v5_completely_unroll.cu
	nvcc -o bin/reduce_v6 reduce_v6_multi_add.cu
	nvcc -o bin/reduce_v7 reduce_v7_shuffle.cu
	nvcc -o bin/reduce_v8 reduce_v8_float4.cu



