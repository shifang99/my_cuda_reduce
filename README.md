# CUDA Reduce 性能分析和优化

针对reduce的优化，Nvidia的官方文档 [Optimizing Parallel Reduction in CUDA](https://developer.download.nvidia.com/assets/cuda/files/reduction.pdf) 讲解比较详细，但是测试数据使用的GPU型号比较旧，有些优化方法在新款GPU上的性能收益发生了变化。知乎博文 [深入浅出GPU优化系列：reduce优化](https://zhuanlan.zhihu.com/p/426978026) 在NVidia官方文档的基础，进行更深入地说明和讲解。本文基于上述两个参考文献，进一步做了一些补充。


## 相比于上述参考文献本文新增内容
1. 新增使用移位代替除法，即 reduce0a。带宽提升显著，从 165.57 GB/s 提升到了 315.31 GB/s。
2. 增加对bank冲突情况的profile，即 my_nvprof。具体参考Nvidia官方文档[Nsight Compute CLI](https://docs.nvidia.com/nsight-compute/NsightComputeCli/index.html#nvprof-guide%5B/url%5D)， [减少bank冲突的代码示例](https://github.com/Kobzol/hardware-effects-gpu/blob/master/bank-conflicts/README.md)；
3. 新增 Vectorized Memory Access，即 reduce8。带宽提升不大，从784.27 GB/s 提升到了 790.93 GB/s，具体参考Nvidia官方文档 [CUDA Pro Tip: Increase Performance with Vectorized Memory Access](https://developer.nvidia.com/blog/cuda-pro-tip-increase-performance-with-vectorized-memory-access/) 。
4. 新增pytorch中reduce_kernel性能测试 reduce9，与 reduce7 实测带宽接近，略差于使用 Vectorized Memory Access 的reduce8。
5. 更正知乎博文中的带宽计算公式，具体参考Nvidia官方文档 [cuda-c-best-practices-guide#theoretical-bandwidth-calculation](https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#theoretical-bandwidth-calculation)。

> Theoretical bandwidth can be calculated using hardware specifications available in the product literature. For example, the NVIDIA Tesla V100 uses HBM2 (double data rate) RAM with a memory clock rate of 877 MHz and a 4096-bit-wide memory interface.

 \( 0.877 * 10^9 *(4096/8) * 2) / 10^9 = 898 GB/s \)

> In this calculation, the memory clock rate is converted in to Hz, multiplied by the interface width (divided by 8, to convert bits to bytes) and multiplied by 2 due to the double data rate. Finally, this product is divided by 109 to convert the result to GB/s.

> Some calculations use 1024^3 instead of 10^9 for the final calculation. In such a case, the bandwidth would be 836.4 GiB/s. It is important to use the same divisor when calculating theoretical and effective bandwidth so that the comparison is valid.




## 实验结果

| 实验序号 | 优化方案 | 传输数据量(MiB)| 传输耗时(ns) | 有效带宽(GB/s) | 理论带宽 (GB/s)| 带宽利用率（%） |
|---|---|----|----|----|----|----|
| reduce0 | 基线 | 128 | 804187 | 165.57 | 900 | 18.4% |
| reduce0a| 用移位代替除法 | 128 | 425663 | 315.31 | 900 | 35.03% |
| reduce1 | 减少warp divergence | 128 | 511838 | 262.22 | 900 | 29.14% |
| reduce2 | sequential addressing <br> 减少bank冲突 | 128 | 404031 | 332.19 | 900 | 36.91% |
| reduce3 | first add during global load <br> 减少idle线程数 | 128 | 219199 | 612.30 | 900 | 68.03% |
| reduce4 | 展开最后一维减少同步 | 128 | 186559 | 719.43 | 900 | 79.94% |
| reduce5 | 循环完全展开 | 128 | 184351 | 728.05 | 900 | 80.90% |
| reduce6 | Algorithm Cascading <br> 合理设置并行度 | 128 | 170176 | 788.69 | 900 | 87.63% |
| reduce7 | 使用shuffle指令 | 128 | 171136 | 784.27 | 900 | 87.14% |
| reduce8 | Vectorized Memory Access | 128 | 169696 | 790.93 | 900 | 87.88% |
| reduce9 | pytorch中的reduce_kernel | 128 | 171360 | 783.25 | 900 | 87.03% |

* 通过实测数据对比分析，发现对于V100性能提升主要来源：
1. 使用移位代替除法，即 reduce0a（或者更换为不需要除法的for循环模式，即 reduce1）；
2. sequential addressing 减少bank冲突，即 reduce2；
3. first add during global load 减少idle线程数，即 reduce3；
4. Algorithm Cascading 合理设置并行度， 即 reduce6。

## 参考文献
1. Nvidia官方文档[Optimizing Parallel Reduction in CUDA](https://developer.download.nvidia.com/assets/cuda/files/reduction.pdf) 
2. 知乎博文 [深入浅出GPU优化系列：reduce优化](https://zhuanlan.zhihu.com/p/426978026) 
3. Nvidia官方文档[Nsight Compute CLI](https://docs.nvidia.com/nsight-compute/NsightComputeCli/index.html#nvprof-guide%5B/url%5D)
4. [减少bank冲突的代码示例](https://github.com/Kobzol/hardware-effects-gpu/blob/master/bank-conflicts/README.md)；
5. Nvidia官方文档 [CUDA Pro Tip: Increase Performance with Vectorized Memory Access](https://developer.nvidia.com/blog/cuda-pro-tip-increase-performance-with-vectorized-memory-access/) 。
6. Nvidia官方文档 [cuda-c-best-practices-guide#theoretical-bandwidth-calculation](https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#theoretical-bandwidth-calculation)。