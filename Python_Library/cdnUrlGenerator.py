import sys
import os
import shutil
import hashlib


def get_cdn_url_expected(url, file_full_path):
    md5 = _get_md5_string(file_full_path)
    return url + '?v=' + md5[0:8]

def _get_md5_string(file_full_path):
    return hashlib.md5(open(file_full_path, 'rb').read()).hexdigest()