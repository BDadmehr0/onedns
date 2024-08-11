#!/bin/bash
script_path=$(pwd)
tntsms_content="#!/bin/bash\n\ncd $script_path\n./onedns.sh"

echo -e $tntsms_content > /usr/local/bin/onedns.sh
chmod +x /usr/local/bin/onedns.sh
