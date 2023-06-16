#!/bin/bash
script_path=$(pwd)
tntsms_content="#!/bin/bash\n\ncd $script_path\n./d403.sh"

echo -e $tntsms_content > /usr/local/bin/d403.sh
chmod +x /usr/local/bin/d403.sh