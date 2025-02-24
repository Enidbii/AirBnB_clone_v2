#!/usr/bin/python3
""" fab script that generates .tgz archive from
the contents of web static"""

from fabric.api import local
from datetime import datetime


def do_pack():
    """ function to generate .tgz """
    try:
        local("mkdir -p versions")
        d_object = datetime.now()
        time_now = d_object.strftime("%Y%m%d%H%M%S")
        name_locale = "versions/web_static_{}.tgz".format(time_now)

        result = local("tar -czvf {} web_static".format(name_locale))
        return name_locale
    except Exception:
        return None
