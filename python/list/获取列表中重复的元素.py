
prd_case_ids_list = [1,3,5,5,7]

repeat_prd_case_ids = tuple(set([i for i in prd_case_ids_list if prd_case_ids_list.count(i) > 1]))