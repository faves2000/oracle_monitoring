cat ./python/PythOnBoardingBot/test3.py
#CHECK_error_for_vizdb2
import subprocess
import os
import slack
# последнее значение снизу
p1 = subprocess.Popen(["head", "-n", "-0", "/home/user/vizdb/vizdb2_err.txt"], stdout=subprocess.PIPE)
p2 = subprocess.Popen(["tail", "-1"], stdin=p1.stdout, stdout=subprocess.PIPE)
p1.stdout.close()  # Allow p1 to receive a SIGPIPE if p2 exits.
output,err = (p2.communicate())
x = (output)
last=float(x.decode('UTF-8','ignore'))
# предпоследнее значение снизу
p1 = subprocess.Popen(["head", "-n", "-1", "/home/user/vizdb/vizdb2_err.txt"], stdout=subprocess.PIPE)
p2 = subprocess.Popen(["tail", "-1"], stdin=p1.stdout, stdout=subprocess.PIPE)
p1.stdout.close()  # Allow p1 to receive a SIGPIPE if p2 exits.
output,err = (p2.communicate())
x = (output)
pre_last=float(x.decode('UTF-8','ignore'))
#print(int(last))
#print(int(pre_last))
#print(type(last))
rezult = last - pre_last
#print(int(rezult))
if rezult !=  0:
#   print("NOT ERROR")
#else:
   client = slack.WebClient(token=os.environ['SLACK_BOT_TOKEN'])

   response = client.chat_postMessage(
       channel='CVCRS20RY',
       text="ORACLE STREAMS ERROR VIZDB 2 !")
   assert response["ok"]
   assert response["message"]["text"] == "ORACLE STREAMS ERROR VIZDB 2 !"
