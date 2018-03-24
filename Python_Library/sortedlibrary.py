from natsort import natsort
# from natsort import humansorted

def human_sorted(list_string, reverse=False):
    return natsort.humansorted(list_string, reverse=reverse)

def reverse_human_sorted(list_string):
    return human_sorted(list_string, reverse=True)

def natural_sorted(list_string, reverse=False):
    return natsort.natsorted(list_string, reverse=reverse)

def real_sorted(list_string, reverse=False):
    return natsort.realsorted(list_string, reverse=reverse)
