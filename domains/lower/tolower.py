#!/usr/bin/env python3
import sys
import tuxedo as t

class Server:
    def TOLOWER(self, req):
        return t.tpreturn(t.TPSUCCESS, 0, req.lower())

t.run(Server(), sys.argv)
