在ubuntu上安装apscheduler时报错： 安装命令：

 pip3 install  apscheduler -i https://pypi.tuna.tsinghua.edu.cn/simple
报错信息：

Collecting backports.zoneinfo; python_version < "3.9" (from tzlocal!=3.*,>=2.0->apscheduler)
  Downloading https://pypi.tuna.tsinghua.edu.cn/packages/ad/85/475e514c3140937cf435954f78dedea1861aeab7662d11de232bdaa90655/backports.zoneinfo-0.2.1.tar.gz (74kB)
    100% |████████████████████████████████| 81kB 4.2MB/s
    Complete output from command python setup.py egg_info:
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/tmp/pip-build-mziohtt7/backports.zoneinfo/setup.py", line 26, in <module>
        setuptools.setup(ext_modules=[c_extension])
      File "/usr/lib/python3/dist-packages/setuptools/__init__.py", line 129, in setup
        return distutils.core.setup(**attrs)
      File "/usr/lib/python3.6/distutils/core.py", line 121, in setup
        dist.parse_config_files()
      File "/usr/lib/python3/dist-packages/setuptools/dist.py", line 494, in parse_config_files
        ignore_option_errors=ignore_option_errors)
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 106, in parse_configuration
        meta.parse()
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 382, in parse
        section_parser_method(section_options)
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 355, in parse_section
        self[name] = value
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 173, in __setitem__
        value = parser(value)
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 430, in _parse_version
        version = self._parse_attr(value)
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 305, in _parse_attr
        module = import_module(module_name)
      File "/usr/lib/python3.6/importlib/__init__.py", line 126, in import_module
        return _bootstrap._gcd_import(name[level:], package, level)
      File "<frozen importlib._bootstrap>", line 994, in _gcd_import
      File "<frozen importlib._bootstrap>", line 971, in _find_and_load
      File "<frozen importlib._bootstrap>", line 941, in _find_and_load_unlocked
      File "<frozen importlib._bootstrap>", line 219, in _call_with_frames_removed
      File "<frozen importlib._bootstrap>", line 994, in _gcd_import
      File "<frozen importlib._bootstrap>", line 971, in _find_and_load
      File "<frozen importlib._bootstrap>", line 941, in _find_and_load_unlocked
      File "<frozen importlib._bootstrap>", line 219, in _call_with_frames_removed
      File "<frozen importlib._bootstrap>", line 994, in _gcd_import
      File "<frozen importlib._bootstrap>", line 971, in _find_and_load
      File "<frozen importlib._bootstrap>", line 953, in _find_and_load_unlocked
    ModuleNotFoundError: No module named 'backports'

    ----------------------------------------
Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-mziohtt7/backports.zoneinfo/
wheeltec@wheeltec:~/catkin_ws$ pip3 install  backports -i https://pypi.tuna.tsinghua.edu.cn/simple
Collecting backports
  Could not find a version that satisfies the requirement backports (from versions: )
No matching distribution found for backports
看起来是像没有backports; 安装一下

pip3 install backports.weakref -i https://pypi.tuna.tsinghua.edu.cn/simple
确实也安装成功了，然后重新安装apscheduler，发现还是报错：

Collecting backports.zoneinfo; python_version < "3.9" (from tzlocal!=3.*,>=2.0->apscheduler)
  Using cached https://pypi.tuna.tsinghua.edu.cn/packages/ad/85/475e514c3140937cf435954f78dedea1861aeab7662d11de232bdaa90655/backports.zoneinfo-0.2.1.tar.gz
    Complete output from command python setup.py egg_info:
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/tmp/pip-build-i770ojsi/backports.zoneinfo/setup.py", line 26, in <module>
        setuptools.setup(ext_modules=[c_extension])
      File "/usr/lib/python3/dist-packages/setuptools/__init__.py", line 129, in setup
        return distutils.core.setup(**attrs)
      File "/usr/lib/python3.6/distutils/core.py", line 121, in setup
        dist.parse_config_files()
      File "/usr/lib/python3/dist-packages/setuptools/dist.py", line 494, in parse_config_files
        ignore_option_errors=ignore_option_errors)
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 106, in parse_configuration
        meta.parse()
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 382, in parse
        section_parser_method(section_options)
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 355, in parse_section
        self[name] = value
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 173, in __setitem__
        value = parser(value)
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 430, in _parse_version
        version = self._parse_attr(value)
      File "/usr/lib/python3/dist-packages/setuptools/config.py", line 305, in _parse_attr
        module = import_module(module_name)
      File "/usr/lib/python3.6/importlib/__init__.py", line 126, in import_module
        return _bootstrap._gcd_import(name[level:], package, level)
      File "<frozen importlib._bootstrap>", line 994, in _gcd_import
      File "<frozen importlib._bootstrap>", line 971, in _find_and_load
      File "<frozen importlib._bootstrap>", line 941, in _find_and_load_unlocked
      File "<frozen importlib._bootstrap>", line 219, in _call_with_frames_removed
      File "<frozen importlib._bootstrap>", line 994, in _gcd_import
      File "<frozen importlib._bootstrap>", line 971, in _find_and_load
      File "<frozen importlib._bootstrap>", line 953, in _find_and_load_unlocked
    ModuleNotFoundError: No module named 'backports.zoneinfo'

    ----------------------------------------
Command "python setup.py egg_info" failed with error code 1 in /tmp/pip-build-i770ojsi/backports.zoneinfo/
这次报的又是"ModuleNotFoundError: No module named 'backports.zoneinfo'" 感觉不太对，这样套娃的报错，感觉以前遇到过，有点像是pip的问题，查一下pip的版本:

 pip3 -V
输出：

pip 9.0.1 from /usr/lib/python3/dist-packages (python 3.6)
这版本也太低了，pip升一下级

python3 -m pip install --upgrade pip
升级成功，直接到pip-21.3.1

Collecting pip
  Cache entry deserialization failed, entry ignored
  Downloading https://files.pythonhosted.org/packages/a4/6d/6463d49a933f547439d6b5b98b46af8742cc03ae83543e4d7688c2420f8b/pip-21.3.1-py3-none-any.whl (1.7MB)
    100% |████████████████████████████████| 1.7MB 47kB/s
Installing collected packages: pip
Successfully installed pip-21.3.1
现在重新安装apscheduler， 一次成功。

Successfully installed apscheduler-3.9.1 backports.zoneinfo-0.2.1 importlib-resources-5.4.0 pytz-deprecation-shim-0.1.0.post0 tzdata-2022.1 tzlocal-4.2
