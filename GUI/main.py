## GUI 403.online service ##

# packgae
import tkinter as tk
from tkinter import messagebox
import requests

# Colors
BLUE = '\033[34m'
WHITE = '\033[37m'

# Service Check API
url = 'https://api.anti403.ir/api/search-filter?url='
fil_and_sop = '{"isSuccess":true,"message":"result success","result":{"support":true,"sanction_status":true,"crossings":[{"name":"DNS","link":"\/download"},{"name":"\u0633\u0631\u0648\u06cc\u0633 \u0648\u06cc\u0698\u0647","link":"\/subscription"}]},"statusCode":200}'
n_fil = '{"isSuccess":true,"message":"result success","result":{"support":false,"sanction_status":false,"crossings":null},"statusCode":200}'
fill_and_n_sop = '{"isSuccess":true,"message":"result success","result":{"support":false,"sanction_status":true,"crossings":null},"statusCode":200}'

# Texts
about = '''
Fa

403 چیست
۴۰۳ پلتفرمی برای برنامه‌نویسان و توسعه‌دهندگان عزیز کشورمان است که امروزه با انواع تحریم و اختلال در توسعه پروژه‌های مورد نظرشان مواجه هستند. این پروژه با پشتیبانی از پروتکل‌های مختلف به کاربران این امکان را می‌دهد که با حذف مشکلات موجود به کتابخانه‌ها و وبسایت‌هایی که برای توسعه نیاز دارند دسترسی داشته باشند. این سایت به مرور زمان با بازخورد کاربران تکمیل می‌شود تا تمام مشکلات این جامعه گرانقدر را رفع کند.

En

What is 403?
403 is a platform for the dear programmers and developers of our country who face all kinds of sanctions and disruptions in the development of their desired projects. By supporting various protocols, this project allows users to access the libraries and websites they need for development by removing the existing problems. This site will be updated over time with user feedback to fix all the problems of this precious community.
'''

info = "Please run with sudo for edit /etc/resolv.conf"

# DNSs
text = "nameserver 10.202.10.202\nnameserver 10.202.10.102\noptions edns0 trust-ad\nsearch domain.name"
reset_text = "nameserver 8.8.8.8\noptions edns0 trust-ad\nsearch domain.name"



def start_service():
    with open('/etc/resolv.conf', 'w') as file:
        file.write(text)
    messagebox.showinfo("Success", "DNS changed to (10.202.10.202, 10.202.10.102)")


def reset_dns():
    with open('/etc/resolv.conf', 'w') as file:
        file.write(reset_text)
    messagebox.showinfo("Success", "DNS reset to (8.8.8.8)")


def service_check():
    service_s_url = input("Service Url: ")
    response = requests.get(url + service_s_url).json()

    if response == fil_and_sop:
        messagebox.showinfo("Result", "URL Filter or support 403 Service")
    elif response == n_fil:
        messagebox.showinfo("Result", "URL No Filter or support 403 Service")
    elif response == fill_and_n_sop:
        messagebox.showinfo("Result", "URL Filter or not support 403 Service")


def about_info():
    messagebox.showinfo("About", about)


def show_dns():
    with open('/etc/resolv.conf', 'r') as file:
        out = file.read()
    messagebox.showinfo("DNS Configuration", out)


root = tk.Tk()
root.title("403 Service")
root.geometry("400x300")


menu_label = tk.Label(root, text="Select an option:")
menu_label.pack()

start_button = tk.Button(root, text="Start Service", command=start_service)
start_button.pack()

reset_button = tk.Button(root, text="Reset DNS to (8.8.8.8)", command=reset_dns)
reset_button.pack()

service_check_button = tk.Button(root, text="Service Check", command=service_check)
service_check_button.pack()

about_button = tk.Button(root, text="About", command=about_info)
about_button.pack()

show_dns_button = tk.Button(root, text="Show my DNS", command=show_dns)
show_dns_button.pack()

exit_button = tk.Button(root, text="Exit", command=root.destroy)
exit_button.pack()

root.mainloop()
