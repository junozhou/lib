ImportError: cannot import name 'safe_str_cmp' from 'werkzeug.security'


Werkzeug今天发布了v2.1.0，删除了werkzeug.security.safe_str_cmp。

您可能可以通过在requirements.txt文件（或类似文件）中固定Werkzeug~=2.0.0来解决这个问题。