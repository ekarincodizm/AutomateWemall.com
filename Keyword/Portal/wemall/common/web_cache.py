
from robot.libraries.BuiltIn import BuiltIn
import redis


class WmCache:
    def __init__(self):
        self.host = BuiltIn().get_variable_value("${WM_REDIS_HOST}")
        self.port = BuiltIn().get_variable_value("${WM_REDIS_PORT}")
        self.db = BuiltIn().get_variable_value("${WM_REDIS_DB}")
        self._connect()

    def _connect(self):
        self._redis = redis.StrictRedis(self.host, self.port, self.db)


    def get_keys(self, pattern):
        keys = self._redis.keys(pattern)
        return keys

    def delete_all(self):
        return self._redis.flushall()


def get_wm_cache_keys(pattern="*"):
    cache = WmCache()
    keys = cache.get_keys(pattern)

    print keys

    return keys

def delete_all_cache():
    return WmCache().delete_all()

