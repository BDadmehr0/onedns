import os
command = 'cat /etc/resolv.conf'
rep1 = 'options edns0 trust-ad'
# Run
out = os.system(command)
out = out.replace(rep1, '')
print(out)
