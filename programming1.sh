#!/bin/bash

#wechall programming1

r=$(curl -H 'Cookie: WC=tu_cookie' https://www.wechall.net/es/challenge/training/programming1/index.php?action=request)

curl -H 'Cookie: WC=tu_cookie' https://www.wechall.net/es/challenge/training/programming1/index.php?answer=$r


