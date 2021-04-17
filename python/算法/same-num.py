

def issame_num(nums,k,t):
    dick = {}
    if k >= 1 and t >= 0 and len(nums) >= 2:
        for item in nums:
            if len(dick) < k:
                pass
            elif len(dick) == k:
