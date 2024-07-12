nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  ./bin/reduce_v0
nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  ./bin/reduce_v0a_wo_div
nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  ./bin/reduce_v1
nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  ./bin/reduce_v2
nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  ./bin/reduce_v3
nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  ./bin/reduce_v4
nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  ./bin/reduce_v5
nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  ./bin/reduce_v6
nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  ./bin/reduce_v7
nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  ./bin/reduce_v8
nvprof -e shared_ld_bank_conflict,shared_st_bank_conflict --metrics shared_efficiency,shared_load_transactions_per_request  python reduce_v9_torch.py
