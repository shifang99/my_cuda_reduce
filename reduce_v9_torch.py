import torch
tensor = torch.randn(1024, 32*1024, device='cuda')
print(tensor)
print(tensor.dtype)
# 在指定维度上计算平均值
dim = 1
result = torch.mean(tensor, dim=dim)
print(result)
print(result.shape)
